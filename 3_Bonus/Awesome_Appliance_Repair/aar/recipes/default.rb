#
# Cookbook:: aar
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Install apache2
package 'apache2' do
  action :install
end

# Install mysql
package 'mysql-server' do
  action :install
end

# Install unzip
package 'unzip' do
  action :install
end

# Download remote install file
# Create install path and set proper ownership
# unpack file to proper path
# Create the apache conf file
# Populate the apache config file
# Create the AAR_config file
# Populate the AAR_Config file
# Create SQL config
# Enable and start mysql
# Enable and start apache