require 'spec_helper'

describe 'hachi-cookbook::default' do
  describe service('puma') do
    it { should be_running }
  end
  describe service('nginx') do
    it { should be_running }
  end
end
