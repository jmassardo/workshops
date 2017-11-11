#
# Cookbook:: Install_Tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Update the apt database
if platform?("ubuntu")
  execute 'apt-get update' do
    command 'sudo apt-get update'
    action :run
  end
end

# Install Java
# More info here: https://docs.chef.io/resource_package.html
package 'Install Java 1.7' do
  case node["platform"]
    when "centos"
      package_name 'java-1.7.0-openjdk-devel'
    when "ubuntu"
      package_name 'default-jdk'
    end
  action :install
end

# Leverage tomcat community cookbook to install and enable tomcat
tomcat_install 'helloworld' do
  version '8.5.23'
end

tomcat_service 'helloworld' do
  action [:enable, :start ]
end
