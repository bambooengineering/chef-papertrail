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

gem_package 'remote_syslog' do
  version node[:papertrail][:remote_syslog][:version]
  retries 2
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

remote_file "#{papertrail_conf_dir}/syslog.papertrail.crt" do
  source 'https://papertrailapp.com/tools/syslog.papertrail.crt'
  mode '0644'
  checksum '7d6bdd1c00343f6fe3b21db8ccc81e8cd1182c5039438485acac4d98f314fe10'
end

cookbook_file '/etc/init.d/remote_syslog' do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
  source 'remote_syslog.init'
end

service 'remote_syslog' do
  action :enable
end
