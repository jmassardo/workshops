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

# Create the directory for tomcat
# More info here: https://docs.chef.io/resource_directory.html
directory '/opt/tomcat' do
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
  action :create
end

# Unpack tarball with a guard to only unpack it only if the service file doesn't exist
# This will keep the resource from breaking the install if run multiple times
# More info here: https://docs.chef.io/resource_execute.html
execute 'Unpack Tomcat' do
  command 'sudo tar xvf /tmp/apache-tomcat-8.5.23.tar.gz -C /opt/tomcat --strip-components=1'
  action :run
  not_if { ::File.exist?('/etc/systemd/system/tomcat.service') }
end

# Set the recursive permissions
# More info here: https://docs.chef.io/resource_execute.html
execute 'Set Tomcat permissions' do
  command <<-EOF
    sudo chgrp -R tomcat /opt/tomcat
    cd /opt/tomcat
    sudo chmod -R g+r conf
    sudo chmod g+x conf
    sudo chown -R tomcat webapps/ work/ temp/ logs/
  EOF
  action :run
  not_if { ::File.exist?('/etc/systemd/system/tomcat.service') }
end

# resource for reloading the systemctl daemon
# it does nothing until notified
# More info here: https://docs.chef.io/resource_execute.html
execute 'Systemctl Reload' do
  command 'sudo systemctl daemon-reload'
  action :nothing
end

# Load the service file up from a template
# More info here: https://docs.chef.io/resource_template.html
template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  notifies :run, 'execute[Systemctl Reload]', :immediately
end

# Enable and start the service
# More info here: https://docs.chef.io/resource_service.html
service 'tomcat.service' do
  action [ :enable, :start ]
end