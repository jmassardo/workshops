#
# Cookbook:: middleman
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# update packages
execute 'apt-get update' do
  command 'sudo apt-get update'
  action :run
end

# Install packages
%w(
    build-essential
    libssl-dev
    libyaml-dev
    libreadline-dev
    openssl
    curl
    git-core
    zlib1g-dev
    bison
    libxml2-dev
    libxslt1-dev
    libcurl4-openssl-dev
    nodejs
    libsqlite3-dev
    sqlite3
    apache2
    git
  ).each do |pkg|
    package "#{pkg}" do
      action :install
    end
end


