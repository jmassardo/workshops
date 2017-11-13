#
# Cookbook:: Install_MongoDB
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'Install_MongoDB::default' do
  context 'When all attributes are default, on an Cemtos 7.4.1708' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates /etc/yum.repos.d directory' do
      expect(chef_run).to create_directory('/etc/yum.repos.d/')
    end

    it 'creates mongo repo file' do
      expect(chef_run).to create_template('/etc/yum.repos.d/mongodb-org-3.4.repo')
    end

    it 'installs mongodb' do
      expect(chef_run).to install_package 'mongodb-org'
    end
  
    it 'enables the mongodb service' do
      expect(chef_run).to enable_service 'mongod'
    end
  
    it 'starts the mongodb service' do
      expect(chef_run).to start_service 'mongod'
    end
  end
end
