# PRIVATE CLASS: do not call directly
class victoriametrics::install {
  assert_private()
  $root_install = $victoriametrics::params::root_install
  $binary_directory = $victoriametrics::params::binary_directory

  file { $root_install['path']:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file { $binary_directory['path']:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/var/lib/victoriametrics':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}
