define nginx::vhost ($vhost_name, $vhost_port, $git_content_url = undef) {
  
  include ::nginx

  $vhost_root = "/var/www/vhosts/${vhost_name}"

  File{
    owner => 'root',
    group => 'root',
  }

  file { ['/var/www', '/var/www/vhosts', $vhost_root ]:
    ensure => directory,
    mode   => '0755',
  }

  file { "/etc/nginx/conf.d/${vhost_name}.conf":
    ensure  => file,
    mode    => '0644',
    content => template("${module_name}/vhost.conf.erb"),
    require => File['/var/www'],
    notify  => Service['nginx'],
  }

  if($git_content_url) {
    exec { 'exercise-webpage':
      path        => '/usr/bin:/bin',
      command     => "git clone ${git_content_url} ${vhost_root}",
      creates     => "${vhost_root}/index.html",
      require     => File['/var/www'],
    }
  }
}
