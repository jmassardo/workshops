#
# Cookbook:: Install_MongoDB
# Recipe:: mongodb_install_ubuntu
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Import the GPG key for Mongo so apt can use the package
execute 'Update Mongo GPG key' do
  command 'sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6'
  action :run
  # Add guard to prevent continual execution
end

# Create the repo file
file '/etc/apt/sources.list.d/mongodb-org-3.4.list' do
  content 'deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Update the apt database to import the mongo repo info
execute 'apt-get update' do
  command 'sudo apt-get update'
  action :run
  # Add guard to prevent continual execution
end

# Install MongoDB
# More info here: https://docs.chef.io/resource_package.html
package 'Install MongoDB' do
  package_name 'mongodb-org'
  action :install
end

# Make sure the service is started and configured to run on a system restart
# More info here: https://docs.chef.io/resource_service.html
service 'mongod' do
  action [ :enable, :start ]
end