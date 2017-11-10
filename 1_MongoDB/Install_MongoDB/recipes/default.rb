#
# Cookbook:: Install_MongoDB
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# install mongodb using the community cookbook
include_recipe "sc-mongodb::default"

# case node["platform"]
# when "centos"
#   include_recipe 'Install_MongoDB::mongodb_install_centos'
# when "ubuntu"
#   include_recipe 'Install_MongoDB::mongodb_install_ubuntu'
# end
