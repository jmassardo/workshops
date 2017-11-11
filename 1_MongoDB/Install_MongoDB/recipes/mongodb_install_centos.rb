#
# Cookbook:: Install_MongoDB
# Recipe:: mongodb_install_centos
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Create yum repo folder if it doesn't exist
# More info here: https://docs.chef.io/resource_directory.html
directory '/etc/yum.repos.d/' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Populate the file from a template. Using a template keeps the recipe cleaner
# More info here: https://docs.chef.io/resource_template.html
template '/etc/yum.repos.d/mongodb-org-3.4.repo' do
  source 'mongo_repo.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
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
