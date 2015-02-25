#
# Author:: Fabricio Correa Duarte (<fabricio.duarte@academymortgage.com>)
# Cookbook Name:: nuget
# Recipe:: default
#
include_recipe "nuget"

# updates nuget to the latest version
execute "Updating NuGet" do
  command "#{node['nuget']['home']}\\nuget.exe update -self"
  action :run
end
