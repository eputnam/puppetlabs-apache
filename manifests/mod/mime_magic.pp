class apache::mod::mime_magic (
  $magic_file = "${::apache::$server_root}/conf/magic"
) {
  include ::apache
  $_magic_file = pick($magic_file, "${::apache::conf_dir}/magic")
  apache::mod { 'mime_magic': }
  # Template uses $magic_file
  file { 'mime_magic.conf':
    ensure  => file,
    path    => "${::apache::mod_dir}/mime_magic.conf",
    mode    => $::apache::file_mode,
    content => template('apache/mod/mime_magic.conf.erb'),
    require => Exec["mkdir -p ${::apache::mod_dir}"],
    before  => File[$::apache::mod_dir],
    notify  => Class['apache::service'],
  }
}
