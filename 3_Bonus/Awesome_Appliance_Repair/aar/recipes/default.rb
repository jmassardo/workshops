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
remote_file '/tmp/master.zip' do
  source 'https://github.com/colincam/Awesome-Appliance-Repair/archive/master.zip'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Create install path and set proper ownership
directory '/var/www/AAR' do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

# unpack file to proper path
# Create the apache conf file
file '/etc/apache2/sites-enabled/AAR-apache.conf' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Populate the apache config file
# Create the AAR_config file
file '/var/www/AAR/AAR_config.py' do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

# Populate the AAR_Config file
# Create SQL config
# Enable and start mysql
service 'mysql' do
  action [ :enable, :start ]
end
# Enable and start apache
service 'apache2' do
  action [ :enable, :start ]
end