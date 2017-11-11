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
# This uses a whitespace array
# More info here: https://docs.chef.io/resource_examples.html#package
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

# Install Ruby
script 'Install Ruby' do
  interpreter 'bash'
  code <<-EOH
    mkdir ~/ruby
    cd ~/ruby
    wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz
    tar -xzf ruby-2.1.3.tar.gz
    cd ruby-2.1.3
    ./configure
    make install
    rm -rf ~/ruby
    sudo cp /usr/local/bin/ruby /usr/bin/ruby
    sudo cp /usr/local/bin/gem /usr/bin/gem
  EOH
  not_if { ::File.exist?('/usr/local/bin/ruby') }
end

# Run commands to config apache
script 'config apache' do
  interpreter 'bash'
  code <<-EOH
    a2enmod proxy_http
    a2enmod rewrite
  EOH
  not_if { ::File.exist?('/etc/apache2/sites-enabled/blog.conf') }
end

# Remove default apache conf
file '/etc/apache2/sites-enabled/000-default.conf' do
  action :delete
end

# Create apache site file
file '/etc/apache2/sites-enabled/blog.conf' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Populate site file
template '/etc/apache2/sites-enabled/blog.conf' do
  source 'apache_conf.erb'
  action :create
  notifies :run, 'execute[Restart Apache]', :immediately
end

# Apache restart. only used when the site file template converges
execute 'Restart Apache' do
  command 'service apache2 restart'
  action :nothing
end

# Clone the app and install the bits for it
script 'App install script' do
  interpreter 'bash'
  code <<-EOH
  cd /var/www
  git clone https://github.com/learnchef/middleman-blog.git
  cd middleman-blog
  sudo gem install bundler
  bundle install
  sudo thin install
  /usr/sbin/update-rc.d -f thin defaults
  EOH
  not_if { ::File.exist?('/etc/thin/blog.conf') }
end

# Create thin conf file
file '/etc/thin/blog.conf' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Populate conf file
template '/etc/thin/blog.conf' do
  source 'thin_blog_yml.erb'
  action :create
end

# Create thin init file
file '/etc/init.d/thin' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Populate thin init file
template '/etc/init.d/thin' do
  source 'thin_init.erb'
  action :create
  notifies :run, 'execute[Restart Thin]', :immediately
end

# Thin restart. only used when the site file template converges
execute 'Restart Thin' do
  command 'sudo systemctl daemon-reload && sudo service thin restart'
  action :nothing
end