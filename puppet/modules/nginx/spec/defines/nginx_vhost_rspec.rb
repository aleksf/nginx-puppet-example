require 'spec_helper'
describe 'nginx::vhost' do
  let :params do
    {
      :vhost_name => 'abrakadabra',
      :vhost_port => '8888',
    }
  end

  it 'should create virtual host config' do
    should contain_file('/etc/nginx/conf.d/abrakadabra.conf').with_cotent(<<-EOT
  server {
      listen       abrakadabra:8888;
      server_name  abrakadabra;
      location / {
      root   /var/www/vhosts/abrakadabra;
          index  index.html index.htm;
      }
  }
  EOT
)
  end
end
