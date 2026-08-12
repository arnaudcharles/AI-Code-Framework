class secure_module (
  Enum['present', 'absent'] $ensure              = 'present',
  Stdlib::Absolutepath       $config_file_path    = '/etc/secure_module/config.conf',
  Integer[1, 65535]          $service_port        = 8443,
  Boolean                    $manage_service_user = true,
) inherits secure_module::params {

  if $manage_service_user {
    user { $secure_module::params::service_user:
      ensure => 'present',
      system => true,
    }
  }

  file { $config_file_path:
    ensure  => $ensure,
    owner   => 'root',
    group   => $secure_module::params::root_group,
    mode    => '0640',
    content => epp('secure_module/config.epp', { 'service_port' => $service_port }),
  }
}
