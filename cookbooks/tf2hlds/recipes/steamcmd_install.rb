#
# Cookbook Name:: tf2hlds
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# useradd steam
# su - steam
# mkdir /home/steam/steamcmd
# cd /home/steam/steamcmd
# wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
# tar -xvzf steamcmd_linux.tar.gz
# rm steamcmd_linux.tar.gz
# cd /home/steam/steamcmd
# ./steamcmd.sh 
steamcmd_path = "/home/steam/steamcmd"

user "steam"

directory "#{steamcmd_path}" do
	user "steam"
end

remote_file "#{steamcmd_path}/steamcmd_linux.tar.gz" do
	source "http://media.steampowered.com/installer/steamcmd_linux.tar.gz"
end

yum_package "glibc.i686"
yum_package "libstdc++48.i686" #seems very specific to amzn linux

bash "install steamcmd_linux" do
	user "steam"
	cwd "#{steamcmd_path}"
	code <<-EOH
		tar -xvzf steamcmd_linux.tar.gz
		rm steamcmd_linux.tar.gz
		EOH
end
