class nginx {
  File{
    owner => 'root',
    group => 'root',
  }

  package { 'nginx':
    ensure  => installed,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    notify  => Service['nginx'],
    require => Package['nginx'],
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['nginx'],
    subscribe => File['/etc/nginx/nginx.conf'],
  }
}
