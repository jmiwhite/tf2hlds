steamcmd_path = node["steamcmd"]["install_path"]

bash "install_tf2" do 
	user "steam"
	cwd #{steamcmd_path}	
	code <<-EOH
		steamcmd.sh +login anonymous +app_update 232250 &
		EOH
end