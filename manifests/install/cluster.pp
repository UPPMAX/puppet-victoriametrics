# PRIVATE CLASS: do not call directly
class victoriametrics::install::cluster {
  assert_private()
  contain victoriametrics::install
  $version = $victoriametrics::params::version
  $ensure = $victoriametrics::params::ensure
  $repository_url = $victoriametrics::params::repository_url
  $archive_name = $victoriametrics::params::archive_name
  $download_url = "${repository_url}/releases/download/${version}/${archive_name}.tar.gz"
  $binary_directory = $victoriametrics::params::binary_directory

  $cluster_binaries = [
    "vminsert",
    "vmselect",
    "vmstorage",
  ]
  if any($cluster_binaries) |$bin| { getvar("victoriametrics.${bin}_version") != $version } {
    archive { "/tmp/${archive_name}.tar.gz":
      ensure        => $ensure,
      source        => $download_url,
      extract       => true,
      extract_path  => "${binary_directory['path']}",
      extract_flags => '--no-same-owner -xf',
      user          => 'root',
      group         => 'root',
    }
  }
}
