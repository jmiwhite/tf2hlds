#
# Cookbook Name:: vxaforever
# Recipe:: default
#
# Copyright 2014, jmi
#
# All rights reserved - Do Not Redistribute
#

package 'httpd' 

service 'httpd' do
  action [:enable, :start]
end

template '/var/www/html/index.html' do 
  source 'index.html.erb'
end
