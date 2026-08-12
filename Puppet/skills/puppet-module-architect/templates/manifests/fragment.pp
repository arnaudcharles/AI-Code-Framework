define secure_module::fragment (
  Stdlib::Absolutepath $path,
  String[1]            $content,
  String[1]            $owner = 'root',
  String[1]            $group = 'root',
  Pattern[/\A0[0-7]{3}\z/] $mode = '0640',
) {
  file { $path:
    ensure  => 'file',
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => $content,
  }
}
