#
# Author:: Fabricio Correa Duarte (<fabricio.duarte@academymortgage.com>)
# Copyright:: Copyright (c) 2011-2012 Academy Mortgage, Corp.
# License:: Apache License, Version 2.0
#

actions :install

# Chef::Resource::package
attribute :id, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String
attribute :destination, :kind_of => String, :default => "C:\\package"
attribute :source, :kind_of => String, :default => "http://package/feed"

# installed is used to identify whether the package has already been installed or not.
attribute :installed, :kind_of => [TrueClass, FalseClass], :default => false

def initialize(name, run_context=nil)
  super
  @action = :install
end