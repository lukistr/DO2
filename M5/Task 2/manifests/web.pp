$packages = [ 'apache2', 'php', 'php-mysqlnd' ]

package { $packages: }

service { apache2:
  ensure => running,
  enable => true,
}

file { '/var/www/html/index.php':
  ensure => present,
  source => "/vagrant/app/web/index.php",
}

file { '/var/www/html/bulgaria-map.png':
  ensure => present,
  source => "/vagrant/app/web/bulgaria-map.png",
}