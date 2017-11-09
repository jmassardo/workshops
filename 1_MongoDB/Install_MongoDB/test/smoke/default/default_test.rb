# # encoding: utf-8

# Inspec test for recipe Install_MongoDB::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Some tests are different between centos and ubuntu so this separates those items
if os.debian?
  # Make sure the key got imported
  describe command('apt-key list') do
    its('stdout') { should match (/MongoDB/) }
  end
  
  # Make sure the source file exists
  describe file('/etc/apt/sources.list.d/mongodb-org-3.4.list') do
    it { should exist }
  end
  
elsif os.redhat?
  # Make sure the mongodb repo file gets created
  describe file('/etc/yum.repos.d/mongodb-org-3.4.repo') do
    it { should exist }
  end
end

#
# These are common tests
#

# Make sure that mongo is installed
describe package('mongodb-org') do
    it { should be_installed }
end

# Make sure service is configured correctly
describe service('mongod') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
end

# Test to see if we can successfully run the mongo executable from the command line
describe command('mongo --eval "quit()" | grep server') do
  its('stdout') { should eq "MongoDB server version: 3.4.10\n" }
end