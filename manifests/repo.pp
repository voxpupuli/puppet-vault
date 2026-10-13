# @summary This class is called from vault to set up the managed apt or yum repo
#
# @api private
#
class vault::repo {
  assert_private()

  if $vault::manage_package and $vault::manage_repo {
    if $vault::bin_name == 'bao' {
      case $facts['os']['family'] {
        'RedHat': {
          yumrepo { 'openbao':
            ensure   => 'present',
            descr    => 'openbao',
            gpgkey   => 'https://openbao.org/assets/openbao-gpg-pub-20240618.asc',
            baseurl  => 'https://pkgs.openbao.org/rpm/$basearch',
            gpgcheck => 1,
          }
        }
        'Debian': {
          include apt
          apt::source { 'openbao':
            location => 'https://pkgs.openbao.org/deb/',
            release  => 'stable',
            repos    => 'main',
            key      => {
              name   => 'openbao.asc',
              source => 'https://openbao.org/assets/openbao-gpg-pub-20240618.asc',
            },
          }
        }
        default: {
          fail("`\$manage_repo` not valid for: ${facts['os']['family']}")
        }
      }
    } else {
      include hashi_stack::repo
    }
  }
}
