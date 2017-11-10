#
# Cookbook:: aar
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#
# Pre-req packages
#

# Setup variables for passwords
# If this were a production environment, this would use a vault system
# to properly protect these secrets
mysql_root_password = 'P@ssw0rd'
appdbpw = 'P@ssw0rd'
secretkey = 'P@ssw0rd'

# Install apache2
package 'apache2' do
  action :install
end

# Workaround to set mysql root password
# This should be replaced with a vault type solution to protect
# this secret

# Reference: https://stackoverflow.com/questions/7739645/install-mysql-on-ubuntu-without-password-prompt
ruby 'Prepopulate mysql root password' do
  interpreter 'bash'
  code <<-EOF
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password P@ssw0rd'
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password P@ssw0rd'
  EOF
  not_if { ::File.exist?('/tmp/Awesome-Appliance-Repair-master/make_AARdb.sql.old') }
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

execute 'Install Flask' do
  command 'pip install flask'
  action :run
  not_if { ::File.exist?('/tmp/Awesome-Appliance-Repair-master/make_AARdb.sql.old') }
end


# Download remote install file
remote_file '/tmp/master.zip' do
  source 'https://github.com/colincam/Awesome-Appliance-Repair/archive/master.zip'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# unpack file to proper path
execute 'Unpack application files' do
  command <<-EOF
    unzip -u /tmp/master.zip -d /tmp
    sudo mv /tmp/Awesome-Appliance-Repair-master/AAR /var/www
  EOF
  action :run
  not_if { ::File.exist?('/var/www/AAR/awesomeapp.py') }
end

# The unzip actually makes the directory but we still need to set proper ownership
directory '/var/www/AAR' do
    owner 'www-data'
    group 'www-data'
    mode '0755'
    action :create
  end

# Create the AAR_config file
file '/var/www/AAR/AAR_config.py' do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

# Populate the AAR_Config file
template '/var/www/AAR/AAR_config.py' do
  variables(
      'appdbpw': appdbpw,
      'secretkey': secretkey
  )
  source 'aar_config.erb'
  action :create
end

# Remove default site conf so it doesn't conflict with the AAR site
file '/etc/apache2/sites-enabled/000-default.conf' do
  action :delete
end

# Create the apache conf file
file '/etc/apache2/sites-enabled/AAR-apache.conf' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Populate the apache config file
template '/etc/apache2/sites-enabled/AAR-apache.conf' do
  source 'apache_conf.erb'
  action :create
end

# Populate the AAR_Config file
template '/tmp/Awesome-Appliance-Repair-master/grant_perms.sql' do
  variables(
      'appdbpw': appdbpw
  )
  source 'sql_script.erb'
  action :create
end

# Create SQL config
execute 'Configure MySQL DB' do
  command <<-EOF
    mysql -uroot -p#{mysql_root_password} < /tmp/Awesome-Appliance-Repair-master/make_AARdb.sql
    mysql -uroot -p#{mysql_root_password} < /tmp/Awesome-Appliance-Repair-master/grant_perms.sql
    mv /tmp/Awesome-Appliance-Repair-master/make_AARdb.sql /tmp/Awesome-Appliance-Repair-master/make_AARdb.sql.old
  EOF
  action :run
  not_if { ::File.exist?('/tmp/Awesome-Appliance-Repair-master/make_AARdb.sql.old') }
  notifies :run, 'execute[Restart Apache]', :immediately
end

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
