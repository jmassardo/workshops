#
# Cookbook:: Install_Tomcat
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'Install_Tomcat::default' do
  context 'When all attributes are default, on an CentOS 7.4.1708' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs java' do
      expect(chef_run).to install_package('java-1.7.0-openjdk-devel')
    end

    it 'creates tomcat group' do
      expect(chef_run).to create_group('tomcat')
    end

    it 'creates tomcat user' do
      expect(chef_run).to create_user('tomcat')
    end

    it 'downloads file' do
      expect(chef_run).to create_remote_file('/tmp/apache-tomcat-8.5.23.tar.gz')
    end

    it 'creates directory' do
      expect(chef_run).to create_directory('/opt/tomcat')
    end

    it 'creates tomcat service file' do
      expect(chef_run).to create_template('/etc/systemd/system/tomcat.service')
    end

    it 'enables the tomcat service' do
      expect(chef_run).to enable_service 'tomcat.service'
    end
  
    it 'starts the tomcat service' do
      expect(chef_run).to start_service 'tomcat.service'
    end
  end
end
