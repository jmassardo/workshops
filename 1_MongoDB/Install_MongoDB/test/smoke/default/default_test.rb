# # encoding: utf-8

# Inspec test for recipe Install_MongoDB::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Make sure the mongodb repo file gets created
describe file('/etc/yum.repos.d/mongodb-org-3.4.repo') do
  it { should exist }
end
