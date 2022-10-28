#
# @summary install hashicorp vault
#
# @param user Customise the user vault runs as, will also create the user unless `manage_user` is false.
#
# @param manage_user Whether or not the module should create the user.
#
# @param group Customise the group vault runs as, will also create the user unless `manage_group` is false.
#
# @param manage_group Whether or not the module should create the group.
#
# @param bin_dir Directory the vault executable will be installed in.
#
# @param config_dir Directory the vault configuration will be kept in.
#
# @param config_mode Mode of the configuration file (config.json). Defaults to '0750'
#
# @param purge_config_dir Whether the `config_dir` should be purged before installing the generated config.
#
# @param download_url Manual URL to download the vault zip distribution from.
#
# @param download_url_base Hashicorp base URL to download vault zip distribution from.
#
# @param download_extension The extension of the vault download
#
# @param service_name Customise the name of the system service
#
# @param service_provider Customise the name of the system service provider; this
#   also controls the init configuration files that are installed.
#
# @param service_options Extra argument to pass to `vault server`, as per: `vault server --help`
#
# @param manage_repo Configure the upstream HashiCorp repository. Only relevant when $nomad::install_method = 'repo'.
#
# * `service_registration`
#   Extra configuration for service registration.
#   `vault server --help`
#
# * `manage_service`
#   Instruct puppet to manage service or not
#
# @param num_procs
#   Sets the GOMAXPROCS environment variable, to determine how many CPUs Vault
#   can use. The official Vault Terraform install.sh script sets this to the
#   output of ``nprocs``, with the comment, "Make sure to use all our CPUs,
#   because Vault can block a scheduler thread". Default: number of CPUs
#   on the system, retrieved from the ``processorcount`` Fact.
#
# @param api_addr
#   Specifies the address (full URL) to advertise to other Vault servers in the
#   cluster for client redirection. This value is also used for plugin backends.
#   This can also be provided via the environment variable VAULT_API_ADDR. In
#   general this should be set as a full URL that points to the value of the
#   listener address
#
# @param version The version of Vault to install
#
# @param extra_config
# @param enable_ui
# @param arch
# @param os
# @param manage_download_dir
# @param download_dir
# @param package_ensure
# @param package_name
# @param install_method
# @param manage_file_capabilities
# @param disable_mlock
# @param max_lease_ttl
# @param default_lease_ttl
# @param telemetry
# @param disable_cache
# @param seal
# @param ha_storage
# @param listener
# @param manage_storage_dir
# @param storage
# @param manage_service_file
# @param service_ensure
# @param service_enable
# @param manage_config_file
# @param download_filename
# @param manage_config_dir enable/disable the directory management. not required for package based installations
class vault (
  $user                                = 'vault',
  $manage_user                         = true,
  $group                               = 'vault',
  $manage_group                        = true,
  $bin_dir                             = $vault::params::bin_dir,
  $manage_config_file                  = true,
  $config_mode                         = '0750',
  $purge_config_dir                    = true,
  $download_url                        = $::vault::params::download_url,
  $download_url_base                   = $::vault::params::download_url_base,
  $download_extension                  = $::vault::params::download_extension,
  $service_name                        = $::vault::params::service_name,
  $service_enable                      = $::vault::params::service_enable,
  $service_ensure                      = $::vault::params::service_ensure,
  $service_provider                    = $::vault::params::service_provider,
  Boolean $manage_repo                 = $::vault::params::manage_repo,
  $manage_service                      = $::vault::params::manage_service,
  $manage_service_file                 = $::vault::params::manage_service_file,
  Hash $storage                        = $::vault::params::storage,
  $manage_storage_dir                  = $::vault::params::manage_storage_dir,
  Variant[Hash, Array[Hash]] $listener = $::vault::params::listener,
  Optional[Hash] $ha_storage           = $::vault::params::ha_storage,
  Optional[Hash] $seal                 = $::vault::params::seal,
  Optional[Boolean] $disable_cache     = $::vault::params::disable_cache,
  Optional[Hash] $telemetry            = $::vault::params::telemetry,
  Optional[String] $default_lease_ttl  = $::vault::params::default_lease_ttl,
  Optional[String] $max_lease_ttl      = $::vault::params::max_lease_ttl,
  Optional[Hash] $service_registration = $::vault::params::service_registration,
  $disable_mlock                       = $::vault::params::disable_mlock,
  $manage_file_capabilities            = $::vault::params::manage_file_capabilities,
  $service_options                     = '',
  $num_procs                           = $facts['processors']['count'],
  $install_method                      = $vault::params::install_method,
  $config_dir                          = if $install_method == 'repo' and $manage_repo { '/etc/vault.d' } else { '/etc/vault' },
  $package_name                        = 'vault',
  $package_ensure                      = 'installed',
  $download_dir                        = '/tmp',
  $manage_download_dir                 = false,
  $download_filename                   = 'vault.zip',
  $version                             = '1.12.0',
  $os                                  = downcase($facts['kernel']),
  $arch                                = $vault::params::arch,
  Optional[Boolean] $enable_ui         = undef,
  Optional[String] $api_addr           = undef,
  Hash $extra_config                   = {},
  Boolean $manage_config_dir           = $install_method == 'archive',
) inherits vault::params {
  # lint:ignore:140chars
  $real_download_url = pick($download_url, "${download_url_base}${version}/${package_name}_${version}_${os}_${arch}.${download_extension}")
  # lint:endignore

  contain vault::install
  contain vault::config
  contain vault::service

  Class['vault::install'] -> Class['vault::config']
  Class['vault::config'] ~> Class['vault::service']
}
