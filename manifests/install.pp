#
# @api private
#
class vault::install {
  assert_private()
  $vault_bin = "${vault::bin_dir}/vault"

  case $vault::install_method {
    'archive': {
      if $vault::manage_download_dir {
        file { $vault::download_dir:
          ensure => directory,
        }
      }

      #
      # Delete the vault binary if it exists and is not the version specified. This
      # is required because the archive statement only applies if there isn't 
      # already a version installed, thus making upgrades not work.
      #
      exec { 'delete_vault_if_incorrect_version':
        command => "rm ${vault_bin}/vault",
        path    => ['/bin', '/usr/bin'],
        onlyif  => "test \$(${vault_bin}/vault --version|awk '{print \$2}'|tr -cd '[:digit:].') != ${vault::version}",
        unless  => "test ! -f ${vault_bin}/vault",
      }

      archive { "${vault::download_dir}/${vault::download_filename}":
        ensure       => present,
        extract      => true,
        extract_path => $vault::bin_dir,
        source       => $vault::real_download_url,
        cleanup      => true,
        creates      => $vault_bin,
        before       => File['vault_binary'],
        require      => Exec['delete_vault_if_incorrect_version'],
      }

      $_manage_file_capabilities = true
    }

    'repo': {
      if $vault::manage_repo {
        include hashi_stack::repo
        Class['hashi_stack::repo'] -> Package[$vault::package_name]
      }
      package { $vault::package_name:
        ensure  => $vault::package_ensure,
      }
      $_manage_file_capabilities = false
    }

    default: {
      fail("Installation method ${vault::install_method} not supported")
    }
  }

  file { 'vault_binary':
    path  => $vault_bin,
    owner => 'root',
    group => 'root',
    mode  => '0755',
  }

  if !$vault::disable_mlock and pick($vault::manage_file_capabilities, $_manage_file_capabilities) {
    file_capability { 'vault_binary_capability':
      ensure     => present,
      file       => $vault_bin,
      capability => 'cap_ipc_lock=ep',
      subscribe  => File['vault_binary'],
    }

    if $vault::install_method == 'repo' {
      Package[$vault::package_name] ~> File_capability['vault_binary_capability']
    }
  }

  if $vault::manage_user {
    user { $vault::user:
      ensure => present,
    }
    if $vault::manage_group {
      Group[$vault::group] -> User[$vault::user]
    }
  }
  if $vault::manage_group {
    group { $vault::group:
      ensure => present,
    }
  }
}
