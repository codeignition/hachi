require 'spec_helper'

describe 'hachi_resource_server::default' do
  it 'should have apache 2' do
    expect(package('apache2')).to be_installed
  end
end
