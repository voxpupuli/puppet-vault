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
    if $vault::config_output == 'json' {
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

      $config_hash = merge($_config_hash, $vault::extra_config)
      $content = to_json_pretty($config_hash)
    } else {
      $content = epp(
        'vault/vault.hcl.epp',
        {
          storage                             => $vault::storage,
          ha_storage                          => $vault::ha_storage,
          listener                            => $vault::listener,
          user_lockout                        => $vault::user_lockout,
          seal                                => $vault::seal,
          cluster_name                        => $vault::cluster_name,
          cache_size                          => $vault::cache_size,
          disable_cache                       => $vault::disable_cache,
          disable_mlock                       => $vault::disable_mlock,
          plugin_directory                    => $vault::plugin_directory,
          plugin_file_uid                     => $vault::plugin_file_uid,
          plugin_file_permissions             => $vault::plugin_file_permissions,
          telemetry                           => $vault::telemetry,
          default_lease_ttl                   => $vault::default_lease_ttl,
          max_lease_ttl                       => $vault::max_lease_ttl,
          default_max_request_duration        => $vault::default_max_request_duration,
          detect_deadlocks                    => $vault::detect_deadlocks,
          raw_storage_endpoint                => $vault::raw_storage_endpoint,
          introspection_endpoint              => $vault::introspection_endpoint,
          ui                                  => $vault::enable_ui,
          pid_file                            => $vault::pid_file,
          enable_response_header_hostname     => $vault::enable_response_header_hostname,
          enable_response_header_raft_node_id => $vault::enable_response_header_raft_node_id,
          log_level                           => $vault::log_level,
          log_format                          => $vault::log_format,
          log_file                            => $vault::log_file,
          log_rotate_duration                 => $vault::log_rotate_duration,
          log_rotate_bytes                    => $vault::log_rotate_bytes,
          log_rotate_max_files                => $vault::log_rotate_max_files,
          experiments                         => $vault::experiments,
          api_addr                            => $vault::api_addr,
          cluster_addr                        => $vault::cluster_addr,
          disable_clustering                  => $vault::disable_clustering,
          disable_sealwrap                    => $vault::disable_sealwrap,
          disable_performance_standby         => $vault::disable_performance_standby,
          license_path                        => $vault::license_path,
          replication                         => $vault::replication,
          sentinel                            => $vault::sentinel,
          service_registration                => $vault::service_registration,
          log_requests_level                  => $vault::log_requests_level,
          entropy_augmentation                => $vault::entropy_augmentation,
          kms_library                         => $vault::kms_library,
        }
      )
    }
    file { "${vault::config_dir}/config.json":
      content => $content,
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
