
#
# Cookbook Name:: dsecond
# Recipe:: launch
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

$ubuntu_count = node['dsecond']['u_count']
$centos_count = node['dsecond']['c_count']
$fedora_count = node['dsecond']['f_count']
$in_port = 5000
$out_port = 5000
docker_service 'default' do
action [ :create, :start]
end

docker_image 'ubuntu' do
action :pull
tag '15.10'
end

docker_image 'centos' do
action :pull
tag 'centos5'
end

docker_image 'fedora' do
action :pull
tag '20'
end

for i in 0..$ubuntu_count do
docker_container 'ubuntu' do
	#image 'fedora'
	action :run
	detach true
	port '5002:5002'
	env 'SETTINGS_FLAVOR=local'
	volume '/mnt/docker:/docker-storage'
end
$in_port +=1
$out_port +=1
end


