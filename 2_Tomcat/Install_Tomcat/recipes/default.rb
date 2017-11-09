#
# Cookbook:: Install_Tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Install Java
# More info here: https://docs.chef.io/resource_package.html
package 'Install Java 1.7' do
    package_name 'java-1.7.0-openjdk-devel'
    action :install
  end