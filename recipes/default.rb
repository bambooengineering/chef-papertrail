#
# Cookbook Name:: papertrail
# Recipe:: default
#
# Copyright 2012, First Banco
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'build-essential'
include_recipe 'rsyslog'
package 'rsyslog-gnutls'

papertrail_conf_dir = '/etc/papertrail'

rbenv_gem 'remote_syslog' do
  version node[:papertrail][:remote_syslog][:version]
end


directory papertrail_conf_dir do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
end

template "#{papertrail_conf_dir}/logs.yml" do
  action :create
  owner 'root'
  group 'root'
  mode  '0644'
  source 'logs.yml.erb'
end

template "/etc/rsyslog.d/papertrail.conf" do
  action :create
  owner 'root'
  group 'root'
  mode '0644'
  source 'papertrail.syslog.conf.erb'
  notifies :restart, 'service[rsyslog]'
end

remote_file "#{papertrail_conf_dir}/papertrail-bundle.pem" do
  source 'https://papertrailapp.com/tools/papertrail-bundle.pem'
  mode '0644'
  checksum 'c03a504397dc45b4fc05f978dbf02129793cbd2a0b64856c2ba1bb49a3b9aacb'
end

cookbook_file '/etc/init.d/remote_syslog' do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
  source 'remote_syslog.init'
end

service 'remote_syslog' do
  action [:enable, :start]
end
