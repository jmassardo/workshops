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

# Fetch the installer for tomcat
# More info here: https://docs.chef.io/resource_remote_directory.html
remote_file '/tmp/apache-tomcat-8.5.23.tar.gz' do
  source 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23.tar.gz'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end