#
# Author:: Fabricio Correa Duarte (<fabricio.duarte@academymortgage.com>)
# Copyright:: Copyright (c) 2011-2012 Academy Mortgage, Corp.
# License:: Apache License, Version 2.0
#

def load_current_resource
	@nugetPackage = Chef::Resource::NugetPackage.new(new_resource.name)
	@nugetPackage.id(new_resource.id)
	Chef::Log.debug("Checking for package #{new_resource.id}")

	installed = ::File.directory?("#{new_resource.destination}/#{new_resource.id}.#{new_resource.version}")
	@nugetPackage.installed(installed)
end

action :install do
	unless @nugetPackage.installed
		powershell "Installing #{new_resource.id} Package" do
			environment ( {'package_version' => new_resource.version, 'destination' => new_resource.destination, 'package_id' => new_resource.id, 'nuget_home' => node[:nuget][:home]} )
			code <<-EOH
				$version = $env:package_version
				$outputFolder = $env:destination
				$package_id = $env:package_id
				$nuget_home = '#{node[:nuget][:home]}'

				try
				{
					$result = . $nuget_home\\nuget.exe install $package_id -version $version -Source http://package/feed -OutputDirectory $outputFolder
					Write-Output $result
					[string] $output = $result
					if (($output.Contains('already installed') -ne $true) -and ( $output.Contains('Successfully installed') -ne $true))
					{
						Exit 1;
					}
				} catch
				{
					Exit 1;
				}
			EOH
		end
	end
end