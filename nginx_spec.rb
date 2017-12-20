require_relative 'spec_helper'

describe command('pgrep nginx') do
  it { should return_exit_status 0 }
end

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_running }
  it { should be_enabled }
end

describe port(8000) do
  it { should be_listening }
end

#macquarie.com
