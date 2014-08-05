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

steamcmd_path = node["steamcmd"]["install_path"]
steamcmd_init = node["steamcmd"]["init_script"]
steam_user = node["steamcmd"]["steam_user"]

#clean install
# directory node["steamcmd"]["install_path"]
#   :action delete
#   only_if attribute? node.override["steamcmd"]["force_clean"]
# end





user steam_user

directory "#{steamcmd_path}" do
	user "#{steam_user}"
end

remote_file "#{steamcmd_path}/steamcmd_linux.tar.gz" do
	source node["steamcmd"]["valve_source"]
	not_if { File.exists?  "#{steamcmd_path}/#{steamcmd_init}" }
end

yum_package "glibc.i686"
yum_package "libstdc++48.i686" #seems very specific to amzn linux

bash "extract and install steamcmd" do
	user "steam"
	cwd "#{steamcmd_path}"
	code <<-BLOCK
		if [ -f steamcmd_linux.tar.gz ]
		then
		tar -xzf steamcmd_linux.tar.gz
		rm -f steamcmd_linux.tar.gz
		fi
		./steamcmd.sh +quit
		BLOCK
	# not_if { File.exists?  "#{steamcmd_path}/#{steamcmd_init}" }
end
