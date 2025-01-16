#
# @summary This class is called from vault for service config
#
# @api private
#
class vault::config {
  assert_private()
  if $vault::manage_config_dir {
    file { $vault::config_dir:
      ensure  => directory,
      purge   => $vault::purge_config_dir,
      recurse => $vault::purge_config_dir,
      owner   => $vault::user,
      group   => $vault::group,
    }
  }

  if $vault::manage_config_file {
    case $vault::mode {
      'server': {
        $_config_hash = delete_undef_values({
            'listener'          => $vault::listener,
            'storage'           => $vault::storage,
            'ha_storage'        => $vault::ha_storage,
            'seal'              => $vault::seal,
            'telemetry'         => $vault::telemetry,
            'disable_cache'     => $vault::disable_cache,
            'default_lease_ttl' => $vault::default_lease_ttl,
            'max_lease_ttl'     => $vault::max_lease_ttl,
            'disable_mlock'     => $vault::disable_mlock,
            'ui'                => $vault::enable_ui,
            'api_addr'          => $vault::api_addr,
        })
      }
      'agent': {
        $_config_hash = delete_undef_values({
            'vault'             => $vault::agent_vault,
            'auto_auth'         => $vault::agent_auto_auth,
            'api_proxy'         => $vault::agent_api_proxy,
            'cache'             => $vault::agent_cache,
            'listener'          => $vault::agent_listeners,
            'template'          => $vault::agent_template,
            'template_config'   => $vault::agent_template_config,
            'exec'              => $vault::exec,
            'env_template'      => $vault::agent_env_template,
            'telemetry'         => $vault::agent_telemetry,
        })
      }
      default: {
        fail("Unsupported vault mode: ${vault::mode}")
      }
    }

    $config_hash = merge($_config_hash, $vault::extra_config)

    file { "${vault::config_dir}/config.json":
      content => to_json_pretty($config_hash),
      owner   => $vault::user,
      group   => $vault::group,
      mode    => $vault::config_mode,
    }

    # If manage_storage_dir is true and a file or raft storage backend is
    # configured, we create the directory configured in that backend.
    #
    if $vault::manage_storage_dir {
      if $vault::storage['file'] {
        $_storage_backend = 'file'
      } elsif $vault::storage['raft'] {
        $_storage_backend = 'raft'
      } else {
        fail('Must provide a valid storage backend: file or raft')
      }

      if $vault::storage[$_storage_backend]['path'] {
        file { $vault::storage[$_storage_backend]['path']:
          ensure => directory,
          owner  => $vault::user,
          group  => $vault::group,
        }
      } else {
        fail("Must provide a path attribute to storage ${_storage_backend}")
      }
    }
  }

  # If nothing is specified for manage_service_file, defaults will be used
  # depending on the install_method.
  # If a value is passed, it will be interpretted as a boolean.
  if $vault::manage_service_file == undef {
    case $vault::install_method {
      'archive': { $real_manage_service_file = true }
      'repo':    { $real_manage_service_file = false }
      default:   { $real_manage_service_file = false }
    }
  } else {
    assert_type(Boolean,$vault::manage_service_file)
    $real_manage_service_file = $vault::manage_service_file
  }

  if $real_manage_service_file {
    case $vault::service_provider {
      'systemd': {
        systemd::unit_file { 'vault.service':
          content => template('vault/vault.systemd.erb'),
        }
      }
      default: {
        fail("vault::service_provider '${vault::service_provider}' is not valid")
      }
    }
  }
}
