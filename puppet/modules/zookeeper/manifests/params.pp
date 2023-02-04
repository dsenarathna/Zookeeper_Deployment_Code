# Class: zookeeper::params
#
# This class manages parameters for the zookeeper module
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class zookeeper::params {
  $zookeeper_client_ip = $zookeeper_client_ip ? {
    ''      => '127.0.0.1',
    default => $zookeeper_client_ip
  }
  $zookeeper_client_port = $zookeeper_client_port ? {
    ''      => '2181',
    default => $zookeeper_client_port
  }
  $zookeeper_election_port = $zookeeper_election_port ? {
    ''      => '2888',
    default => $zookeeper_election_port
  }
  $zookeeper_leader_port = $zookeeper_leader_port ? {
    ''      => '3888',
    default => $zookeeper_leader_port
  }
  $zookeeper_autopurge_purge_interval = $zookeeper_autopurge_purge_interval ? {
    ''      => '24',
    default => $zookeeper_autopurge_purge_interval
  }
  $zookeeper_autopurge_snap_retain_count = $zookeeper_autopurge_snap_retain_count ? {
    ''      => '5',
    default => $zookeeper_autopurge_snap_retain_count
  }
  $zookeeper_data_dir = $zookeeper_data_dir ? {
    ''      => '/var/lib/zookeeper',
    default => $zookeeper_data_dir
  }
  $zookeeper_init_limit = $zookeeper_init_limit ? {
    ''      => '10',
    default => $zookeeper_init_limit
  }
  $zookeeper_sync_limit = $zookeeper_sync_limit ? {
    ''      => '5',
    default => $zookeeper_sync_limit
  }
  $zookeeper_tick_time = $zookeeper_tick_time ? {
    ''      => '2000',
    default => $zookeeper_tick_time
  }
  $servers = $servers ? {
    ''      => [''],
    default => $servers
  }
  $observers = $observers ? {
    ''      => [''],
    default => $observers
  }
}
