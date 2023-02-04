# Class: zookeeper
#
# This module manages zookeeper
#
# Parameters: None
#
# Actions: None
#
# Requires: None
#
# Sample Usage: include zookeeper
#

class zookeeper (
  $zookeeper_client_ip                   = $::ipaddress,
  $zookeeper_client_port                 = 2181,
  $zookeeper_election_port               = 2888,
  $zookeeper_leader_port                 = 3888,
  $zookeeper_autopurge_purge_interval    = $zookeeper::params::zookeeper_autopurge_purge_interval,
  $zookeeper_autopurge_snap_retain_count = $zookeeper::params::zookeeper_autopurge_snap_retain_count,
  $zookeeper_data_dir                    = $zookeeper::params::zookeeper_data_dir,
  $zookeeper_init_limit                  = $zookeeper::params::zookeeper_init_limit,
  $zookeeper_sync_limit                  = $zookeeper::params::zookeeper_sync_limit,
  $zookeeper_tick_time                   = $zookeeper::params::zookeeper_tick_time,
  $servers                               = $zookeeper::params::servers,
  $observers                             = $zookeeper::params::observers,
  $zookeeper_myid                        = $zookeeper::params::zookeeper_myid,
) inherits zookeeper::params {
  require java::jdk7

  package {
    'zookeeper':
      ensure => installed;
  }

  user {
    'zookeeper':
      require => Package['zookeeper'];
  }

  $zookeeper_init = $lsbdistcodename ? {
    'jessie' => '/lib/systemd/system/zookeeper.service',
    'xenial' => '/etc/systemd/system/zookeeper.service',
    default  => '/etc/init.d/zookeeper',
  }

  $zookeeper_init_mode = $lsbdistcodename ? {
    'jessie' => '644',
    'xenial' => '644',
    default  => '750',
  }

  service {
    'zookeeper':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => false,
      pattern    => '/usr/bin/java -Dzookeeper',
      require    => [File["${zookeeper_init}"],Package['zookeeper']];
  }

  file {
    $zookeeper_data_dir:
      ensure => directory,
      owner  => 'zookeeper',
      group  => 'zookeeper',
      mode   => '0755';
    $zookeeper_init:
      owner  => 'root',
      group  => 'root',
      mode   => "${zookeeper_init_mode}",
      source => "puppet:///puppet_dir_master/systems/_LINUX_${zookeeper_init}";
    '/etc/zookeeper/conf/zoo.cfg':
      notify  => Service['zookeeper'],
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${::puppet_dir_master}/systems/_LINUX_/etc/zookeeper/conf/zoo.cfg");
    '/etc/zookeeper/conf/myid':
      notify  => Service['zookeeper'],
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${::puppet_dir_master}/systems/_LINUX_/etc/zookeeper/conf/myid");
    '/var/log/zookeeper':
      ensure => directory,
      owner  => 'zookeeper',
      group  => 'zookeeper',
      mode   => '0755';
    "${zookeeper_data_dir}/myid":
      ensure => link,
      owner  => 'zookeeper',
      group  => 'zookeeper',
      mode   => '0644',
      target => '/etc/zookeeper/conf/myid';
  }
}
