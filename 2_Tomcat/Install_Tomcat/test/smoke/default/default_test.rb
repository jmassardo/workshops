# # encoding: utf-8

# Inspec test for recipe Install_Tomcat::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Is Java installed?
describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed }
end

# Does the tomcat group exist?
describe group('tomcat') do
  it { should exist }
end

# Does the tomcat user exist with the correct properties?
describe user('tomcat') do
  it { should exist }
  its('group') { should eq 'tomcat' }
  its('home') { should eq '/opt/tomcat' }
  its('shell') { should eq '/bin/nologin' }
end

# Did it download the install tarball?
describe file('/tmp/apache-tomcat-8.5.23.tar.gz') do
  it { should exist }
end

# Does the /opt/tomcat directory exist?
describe directory('/opt/tomcat') do
  it { should exist }
  its('owner') { should eq 'tomcat' }
end