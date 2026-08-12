class secure_module::params {
  $service_user = 'secure-module'

  $root_group = $facts['os']['family'] ? {
    'Debian' => 'root',
    'RedHat' => 'root',
    default  => 'root',
  }
}
