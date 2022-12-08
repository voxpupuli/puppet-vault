#
# @summary This class is meant to be called from vault. It sets variables according to platform.
#
# @api private
#
class vault::params {
  case $facts['os']['architecture'] {
    'aarch64':        { $arch = 'arm64' }
    /(x86_64|amd64)/: { $arch = 'amd64' }
    'i386':           { $arch = '386' }
    /^arm.*/:         { $arch = 'arm' }
    default:          { fail("Unsupported kernel architecture: ${facts['os']['architecture']}") }
  }

  case $facts['os']['family'] {
    'Archlinux': {
      $install_method      = 'repo'
      $bin_dir             = '/bin'
      $manage_service_file = true
      $manage_repo         = false
    }
    default: {
      $install_method      = 'archive'
      $bin_dir             = '/usr/local/bin'
      $manage_service_file = undef
      $manage_repo         = true
    }
  }
}
