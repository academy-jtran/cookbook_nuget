#
# Author:: Fabricio Correa Duarte (<fabricio.duarte@academymortgage.com>)
# Cookbook Name:: nuget
# Recipe:: default
#

directory node['nuget']['home'] do
  recursive true
  action :create
end

remote_file "#{node['nuget']['home']}\\nuget.exe" do
  source node['nuget']['url']
  action :create_if_missing
end

# update path
windows_path node['nuget']['home'] do
  action :add
end