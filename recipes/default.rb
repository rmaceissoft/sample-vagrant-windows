#
# Cookbook Name:: sample-vagrant-windows
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#


# install mozilla firefox
windows_package 'Mozilla Firefox 5.0 (x86 en-US)' do
  source 'http://archive.mozilla.org/pub/mozilla.org/mozilla.org/firefox/releases/5.0/win32/en-US/Firefox%20Setup%205.0.exe'
  options '-ms'
  installer_type :custom
  action :install
end

# install git
include_recipe "git::default"

# install IIS
include_recipe "iis::default"

# create project directory root
directory "c:\\source_code"

# pull source code from github
git "c:\\source_code" do
  repository "git://github.com/rmaceissoft/sample-static-site.git"
  reference "master"
  action :sync
end

# add a new virtual site
iis_site 'hello_world' do
  protocol :http
  port 81
  path "c:\\source_code"
  action [:add,:start]
end