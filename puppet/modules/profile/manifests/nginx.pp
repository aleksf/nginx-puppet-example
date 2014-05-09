class profile::nginx {

  include ::nginx
  include profile::base

  nginx::vhost { $::fqdn:
    vhost_name      => $::fqdn,
    vhost_port      => '8000',
    git_content_url => 'https://github.com/puppetlabs/exercise-webpage',
  }

  firewall { '101 allow http on port 8000':
    port   => ['8000'],
    proto  => tcp,
    action => accept,
  }
}
