#
# Cookbook:: aar
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#
# Pre-req packages
#

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

#
# App specific packages
#

# Install module for Apache
package 'libapache2-mod-wsgi' do
  action :install
end

# Install Pip
package 'python-pip' do
  action :install
end

# Install mysql module for Python
package 'python-mysqldb' do
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

execute 'Restart Apache' do
  command 'apachectl graceful'
  action :nothing
end
