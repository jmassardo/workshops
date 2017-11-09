#
# Cookbook:: Install_MongoDB
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#Create yum repo file so it knows how to find the mongodb packages

template '/etc/yum.repos.d/mongodb-org-3.4.repo' do
  source 'mongo_repo.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
