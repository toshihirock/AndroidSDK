#
# Cookbook Name:: android
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'java'

%w{unzip expect}.each do |pkg|
  package pkg do
    action :install
  end
end

ark 'android' do
  url 'http://dl.google.com/android/adt/22.6.2/adt-bundle-linux-x86_64-20140321.zip'
  path '/usr/local/android'
end

script 'Install Android SDK' do
  android_version="android-17"
  interpreter 'expect'
  not_if { ::File.exists?("/usr/local/android/sdk/#{android_version}") }
  code <<-EOF
    spawn /usr/local/android/sdk/tools/android update sdk --no-ui --filter #{android_version}
    set timeout 1800
    expect {
      -regexp "Do you accept the license.*" {
        exp_send "y\r"
	exp_continue
      }
    }
  EOF
end
