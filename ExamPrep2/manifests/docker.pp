class { 'docker':
  docker_ee => false,
}

group { 'docker':
  ensure => present,
}

user { 'vagrant':
  ensure => present,
  gid    => 'docker',
  groups => ['docker'],
}

file_line { 'hosts-server':
    ensure => present,
    path   => '/etc/hosts',
    line   => '192.168.100.101 server.do2.exam server',
    match  => '^192.168.100.101',
}

file_line { 'hosts-web':
    ensure   => present,
    path   => '/etc/hosts',
    line   => '192.168.100.102 web.do2.exam web',
    match  => '^192.168.100.102',
}

file_line { 'hosts-db':
    ensure => present,
    path   => '/etc/hosts',
    line   => '192.168.100.103 db.do2.exam db',
    match  => '^192.168.100.103',
}