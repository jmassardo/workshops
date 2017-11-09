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

# Create tomcat group
# More info here: https://docs.chef.io/resource_group.html
group 'tomcat' do
  action :create
end

# Create the tomcat user and add it to the tomcat group
# More info here: https://docs.chef.io/resource_user.html
user 'tomcat' do
  gid 'tomcat'
  home '/opt/tomcat'
  shell '/bin/nologin'
  action :create
  end