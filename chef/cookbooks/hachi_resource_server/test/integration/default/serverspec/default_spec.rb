require 'spec_helper'

describe 'hachi_resource_server::default' do
  it 'should have apache 2' do
    expect(package('apache2')).to be_installed
  end

  it 'should have libhiredis0.10 installed' do
    expect(package('libhiredis0.10')).to be_installed
  end

  it 'should have libjansson4 installed' do
    expect(package('libjansson4')).to be_installed
  end

  it 'should have libcurl3 installed' do
    expect(package('libcurl3')).to be_installed
  end

  it 'should download mod auth openidc' do
    mod_auth_openidc_file_name = 'libapache2-mod-auth-openidc_1.8.7-1ubuntu1.trusty.1_amd64.deb'
    expect(File.exists? "/home/vagrant/#{mod_auth_openidc_file_name}").to eq(true)
  end
end
