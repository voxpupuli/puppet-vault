#
# @summary install hashicorp vault
#
# @param user
#   Customise the user vault runs as, will also create the user unless 
#   `manage_user` is false.
#
# @param manage_user
#   Whether or not the module should create the user.
#
# @param group
#   Customise the group vault runs as, will also create the user unless 
#   `manage_group` is false.
#
# @param manage_group
#   Whether or not the module should create the group.
#
# @param bin_dir
#   Directory the vault executable will be installed in.
#
# @param config_dir
#   Directory the vault configuration will be kept in.
#
# @param manage_config_dir
#   Enable/disable the directory management. not required for package based
#   installations
#
# @param manage_config_file
#   Enable/disable managing the config file
#
# @param config_output
#   The language to use for the configuration output
#
# @param config_mode
#   Mode of the configuration file (config.json). Defaults to '0750'
#
# @param purge_config_dir
#   Whether the `config_dir` should be purged before installing the generated
#   config.
#
# @param create_env_file
#   Cause a blank vault.env file to be created in the config_dir. This also adds
#   the EnvironmentFile directive to the service file (if manage_service_file is
#   enabled)
#
# @param download_url
#   Manual URL to download the vault zip distribution from.
#
# @param download_url_base
#   Hashicorp base URL to download vault zip distribution from.
#
# @param download_extension
#   The extension of the vault download
#
# @param service_name
#   Customise the name of the system service
#
# @param service_enable
#   Whether or not to enable the vault service
#
# @param service_ensure
#   State in which the service is ensured to be

# @param service_provider 
#   Customise the name of the system service provider; this also controls the
#   init configuration files that are installed.
#
# @param service_options
#   Extra argument to pass to `vault server`, as per: `vault server --help`
#
# @param manage_service
#   Instruct puppet to manage service or not
#
# @param manage_service_file
#   Whether or not this module should manage the service file
#
# @param manage_storage_dir
#   Whether or not this module should concern itself with the storage directory
#
# @param manage_repo
#   Configure the upstream HashiCorp repository. Only relevant when 
#   $nomad::install_method = 'repo'.
#
# @param num_procs
#   Sets the GOMAXPROCS environment variable, to determine how many CPUs Vault
#   can use. The official Vault Terraform install.sh script sets this to the
#   output of ``nprocs``, with the comment, "Make sure to use all our CPUs,
#   because Vault can block a scheduler thread". Default: number of CPUs
#   on the system, retrieved from the ``processorcount`` Fact.
#
# @param install_method
#   How to install vault (i.e. from the official Hashicorp repo or archive)
#
# @param package_name
#   The name of the package to install
#
# @param package_ensure
#   State of the package to ensure (i.e. installed)
#
# @param download_dir
#   The directory to download the archive to for extraction
#
# @param manage_download_dir
#   Whether or not to manage the download directory
#
# @param download_filename
#   The filename to write the downloaded archive to
#
# @param version
#   The version of Vault to download and install (for archive installation)
#
# @param os
#   The operating system name
#
# @param arch
#   The cpu architecture
#
# @param storage
#   Configures the storage backend where Vault data is stored.
#
# @param ha_storage
#   Configures the storage backend where Vault HA coordination will take place.
#
# @param listener
#   Configures how Vault is listening for API requests.
#
# @param user_lockout
#   Configures the user-lockout behaviour for failed logins.
#
# @param seal
#   Configures the seal type to use for auto-unsealing, as well as for seal 
#   wrapping as an additional layer of data protection.
#
# @param cluster_name
#   Specifies the identifier for the Vault cluster
#
# @param cache_size
#   Specifies the size of the read cache used by the physical storage subsystem.
#
# @param disable_cache
#   Disables all caches within Vault, including the read cache used by the 
#   physical storage subsystem.
#
# @param disable_mlock
#   Disables the server from executing the mlock syscall.
#
# @param manage_file_capabilities
#   Whether or not to control the ipc_lock capability on the vault binary
#
# @param plugin_directory
#   A directory from which plugins are allowed to be loaded.
#
# @param plugin_file_uid
#   Uid of the plugin directories and plugin binaries if they are owned by an 
#   user other than the user running Vault.
#
# @param plugin_file_permissions
#   Octal permission string of the plugin directories and plugin binaries if 
#   they have write or execute permissions for group or others.
#
# @param telemetry
#   Specifies the telemetry reporting system.
#
# @param default_lease_ttl
#   Specifies the default lease duration for tokens and secrets.
#
# @param max_lease_ttl
#   Specifies the maximum possible lease duration for tokens and secrets.
#
# @param default_max_request_duration
#   Specifies the default maximum request duration allowed before Vault cancels
#   the request.
#
# @param detect_deadlocks
#   Specifies the internal mutex locks that should be monitored for potential
#   deadlocks.
#
# @param raw_storage_endpoint
#   Enables the sys/raw endpoint which allows the decryption/encryption of raw
#   data into and out of the security barrier.
#
# @param introspection_endpoint
#   Enables the sys/internal/inspect endpoint which allows users with a root 
#   token or sudo privileges to inspect certain subsystems inside Vault.
#
# @param enable_ui
#   Enables the built-in web UI, which is available on all listeners (address + 
#   port) at the /ui path.
#
# @param pid_file
#   Path to the file in which the Vault server's Process ID (PID) should be 
#   stored.
#
# @param enable_response_header_hostname
#   Enables the addition of an HTTP header in all of Vault's HTTP responses:
#   X-Vault-Hostname.
#
# @param enable_response_header_raft_node_id
#   Enables the addition of an HTTP header in all of Vault's HTTP responses:
#   X-Vault-Raft-Node-ID.
#
# @param log_level
#   Log verbosity level. Supported values (in order of descending detail) are 
#   trace, debug, info, warn, and error.
#
# @param log_format
#   Equivalent to the -log-format command-line flag.
#
# @param log_file
#   Equivalent to the -log-file command-line flag.
#
# @param log_rotate_duration
#   Equivalent to the -log-rotate-duration command-line flag.
#
# @param log_rotate_bytes
#   Equivalent to the -log-rotate-bytes command-line flag.
#
# @param log_rotate_max_files
#   Equivalent to the -log-rotate-max-files command-line flag.
#
# @param experiments
#  The list of experiments to enable for this node.
#
# @param api_addr
#   Specifies the address (full URL) to advertise to other Vault servers in the
#   cluster for client redirection.
#
# @param cluster_addr
#   Specifies the address to advertise to other Vault servers in the cluster for
#   request forwarding.
#
# @param disable_clustering
#   Specifies whether clustering features such as request forwarding are
#   enabled.
#
# @param disable_sealwrap
#   Disables using seal wrapping for any value except the root key.
#
# @param disable_performance_standby
#   Specifies whether performance standbys should be disabled on this node.
#
# @param license_path
#   Path to license file.
#
# @param replication
#   The replication stanza specifies various parameters for tuning replication
#   related values.
#
# @param sentinel
#   The sentinel stanza specifies configurations for Vault's Sentinel
#   integration.
#
# @param service_registration
#   The optional service_registration stanza configures Vault's mechanism for
#   service registration.
#
# @param log_requests_level
#   Vault can be configured to log completed requests using the
#   log_requests_level configuration parameter.
#
# @param entropy_augmentation
#   Entropy augmentation enables Vault to sample entropy from external
#   cryptographic modules.
#
# @param kms_library
#   The kms_library stanza isolates platform specific configuration for managed
#   keys.
#
# @param extra_config
#   Extra configuration options not covered by the rest of the parameters
#
class vault (
  Enum['archive', 'repo']    $install_method                      = $vault::params::install_method,
  String                     $user                                = 'vault',
  Boolean                    $manage_user                         = true,
  String                     $group                               = 'vault',
  Boolean                    $manage_group                        = true,
  Boolean                    $manage_repo                         = $vault::params::manage_repo,
  StdLib::AbsolutePath       $bin_dir                             = $vault::params::bin_dir,
  # lint:ignore:140chars
  StdLib::AbsolutePath       $config_dir                          = if $install_method == 'repo' and $manage_repo { '/etc/vault.d' } else { '/etc/vault' },
  # lint:endignore
  Boolean                    $manage_config_dir                   = $install_method == 'archive',
  Boolean                    $manage_config_file                  = true,
  Enum['hcl', 'json']        $config_output                       = 'json',
  StdLib::Filemode           $config_mode                         = '0444',
  Boolean                    $purge_config_dir                    = true,
  Boolean                    $create_env_file                     = false,
  Optional[StdLib::HTTPUrl]  $download_url                        = undef,
  StdLib::HTTPUrl            $download_url_base                   = $vault::params::download_base,
  String                     $download_extension                  = 'zip',
  String                     $service_name                        = 'vault',
  Boolean                    $service_enable                      = true,
  Variant[
    Boolean,
    Enum['running', 'stopped']
  ]                          $service_ensure                      = 'running',
  String                     $service_provider                    = $facts['service_provider'],
  Optional[String]           $service_options                     = undef,
  Boolean                    $manage_service                      = true,
  Optional[Boolean]          $manage_service_file                 = $vault::params::manage_service_file,
  Boolean                    $manage_storage_dir                  = false,
  Variant[Integer, String]   $num_procs                           = $facts['processors']['count'],
  String                     $package_name                        = 'vault',
  String                     $package_ensure                      = 'installed',
  StdLib::AbsolutePath       $download_dir                        = '/tmp',
  Boolean                    $manage_download_dir                 = false,
  String                     $download_filename                   = 'vault.zip',
  String                     $version                             = '1.12.0',
  String                     $os                                  = downcase($facts['kernel']),
  String                     $arch                                = $vault::params::arch,
  Hash                       $storage                             = { 'file' => { 'path' => '/var/lib/vault' }, },
  Optional[Hash]             $ha_storage                          = undef,
  Variant[Hash, Array[Hash]] $listener                            = { 'tcp' => { 'address' => '127.0.0.1:8200', 'tls_disable' => 1 }, },
  Optional[Hash]             $user_lockout                        = undef,
  Optional[Hash]             $seal                                = undef,
  Optional[String]           $cluster_name                        = undef,
  Optional[String]           $cache_size                          = undef,
  Optional[Boolean]          $disable_cache                       = undef,
  Optional[Boolean]          $disable_mlock                       = undef,
  Optional[Boolean]          $manage_file_capabilities            = undef,
  Optional[String]           $plugin_directory                    = undef,
  Optional[Integer]          $plugin_file_uid                     = undef,
  Optional[String]           $plugin_file_permissions             = undef,
  Optional[Hash]             $telemetry                           = undef,
  Optional[String]           $default_lease_ttl                   = undef,
  Optional[String]           $max_lease_ttl                       = undef,
  Optional[String]           $default_max_request_duration        = undef,
  Optional[String]           $detect_deadlocks                    = undef,
  Optional[Boolean]          $raw_storage_endpoint                = undef,
  Optional[Boolean]          $introspection_endpoint              = undef,
  Optional[Boolean]          $enable_ui                           = undef,
  Optional[String]           $pid_file                            = undef,
  Optional[Boolean]          $enable_response_header_hostname     = undef,
  Optional[Boolean]          $enable_response_header_raft_node_id = undef,
  Optional[
    Enum['trace', 'debug', 'info', 'warn', 'error']
  ]                          $log_level                           = undef,
  Optional[String]           $log_format                          = undef,
  Optional[String]           $log_file                            = undef,
  Optional[String]           $log_rotate_duration                 = undef,
  Optional[String]           $log_rotate_bytes                    = undef,
  Optional[String]           $log_rotate_max_files                = undef,
  Optional[Array]            $experiments                         = undef,
  Optional[String]           $api_addr                            = undef,
  Optional[String]           $cluster_addr                        = undef,
  Optional[Boolean]          $disable_clustering                  = undef,
  Optional[Boolean]          $disable_sealwrap                    = undef,
  Optional[Boolean]          $disable_performance_standby         = undef,
  Optional[String]           $license_path                        = undef,
  Optional[Hash]             $replication                         = undef,
  Optional[Hash]             $sentinel                            = undef,
  Optional[Hash]             $service_registration                = undef,
  Optional[String]           $log_requests_level                  = undef,
  Optional[String]           $entropy_augmentation                = undef,
  Optional[String]           $kms_library                         = undef,
  Hash                       $extra_config                        = {},
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
