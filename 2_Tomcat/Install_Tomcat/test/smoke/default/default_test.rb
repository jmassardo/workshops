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