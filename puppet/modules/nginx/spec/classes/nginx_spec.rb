require 'spec_helper'
describe 'nginx' do
  it 'should create default resources' do
    should contain_package('nginx').with_ensure('installed')
    should contain_service('nginx').with(
	    'ensure' => 'running',
	    'enable' => 'true',
    )
  end
end
