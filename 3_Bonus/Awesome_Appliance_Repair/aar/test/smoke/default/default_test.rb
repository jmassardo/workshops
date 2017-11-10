# # encoding: utf-8

# Inspec test for recipe aar::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Is apache2 installed?
describe package('apache2') do
  it { should be_installed }
end

# Is mysql installed?
describe package('mysql-server') do
  it { should be_installed }
end

# Is unzip installed?
describe package('unzip') do
  it { should be_installed }
end

# Did the remote file get downloaded?
describe file('/tmp/master.zip') do
  it { should exist }
end

# Did the install get unpacked to the proper path?
describe directory('/var/www/AAR') do
  it { should exist }
  its('owner') { should eq 'www-data' }
end

# Does the apache conf file exist?
describe file('/etc/apache2/sites-enabled/AAR-apache.conf') do
  it { should exist }
end

# TODO
# -> and does it have the correct content?

# Does the AAR_config file exist?
describe file('/var/www/AAR/AAR_config.py') do
  it { should exist}
end

# TODO
# -> and does it have the correct content?

# Is mysql running?
describe service('mysql') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
describe port(3306) do
  it { should be_listening }
end
# Is apache running?
describe service('apache2') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
describe port(80) do
  it { should be_listening }
end

# TODO
# Does the app load properly?