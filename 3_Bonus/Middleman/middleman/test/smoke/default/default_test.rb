# # encoding: utf-8

# Inspec test for recipe middleman::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

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
  describe package("#{pkg}") do
    it { should be_installed }
  end
end

# Is ruby installed?
describe file('/usr/local/bin/ruby') do
  it { should exist }
end

# does the blog config file exisst?
describe file('/etc/apache2/sites-enabled/blog.conf') do
  it { should exist}
end

# Is apache running?
describe service('apache2') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# Is bundler installed
describe command('gem list --local | grep -m 1 bundler') do
  its ('stdout') { should match /bundler/ }
end

# Does the blog conf file exist?
describe file('/etc/thin/blog.conf') do
  it { should exist}
end

# does the thin init script exist?
describe file('/etc/init.d/thin') do
  it { should exist }
end

# Is apache listening
describe port(80) do
  it { should be_listening }
end

# Does the app load properly?
describe command ('curl localhost | grep Ada') do
  its ('stdout') { should match /Ada/ }
end
