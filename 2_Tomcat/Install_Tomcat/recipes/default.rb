#
# Cookbook:: Install_Tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# case node["platform"]
# when "centos"
   include_recipe 'Install_Tomcat::tomcat_install_centos'
# when "ubuntu"
#   include_recipe 'Install_Tomcat::tomcat_install_ubuntu'
# end