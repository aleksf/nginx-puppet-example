require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end
require 'puppetlabs_spec_helper/module_spec_helper'
RSpec.configure do |c|
    c.module_path = '/Users/aleksf/vagrant_nginx/puppet/modules'
end
