# # encoding: utf-8

# Inspec test for recipe Install_Tomcat::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Is Java installed?
if os.debian?
  describe package('default-jdk') do
    it { should be_installed }
  end
elsif os.redhat?
  describe package('java-1.7.0-openjdk-devel') do
    it { should be_installed }
  end
end

# Does the /opt/tomcat directory exist?
describe directory('/opt/tomcat_helloworld') do
  it { should exist }
  its('owner') { should eq 'tomcat_helloworld' }
end

# Make sure the service is configured properly.
describe service('tomcat_helloworld') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# The real test... does it actually work?
describe port(8080) do
  it { should be_listening }
end