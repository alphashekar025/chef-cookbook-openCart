#
# Cookbook Name:: OpenCart
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Download the remote file
include_recipe ='yum'
include_recipe ='database::mysql'
include_recipe ='chef_gem'

# create database for the store
chef_gem "mysql" do
 action :install
end

mysql_connection_info = { :host => "#{node['opencart']['db_hostname']}",
                         :username => "#{node['opencart']['db_username']}",
                         :password => "#{node['opencart']['db_password']}" }


mysql_database "#{node['opencart']['db_database']}" do
  connection mysql_connection_info
  action :create
end

directory "#{node['opencart']['web_dir']}" do
  owner "root"
  group "root"
  action :create
end

directory "#{node['opencart']['store_dir']}" do
  owner "root"
  group "root"
  action :create
end


# download the zip file to the default chef cache path; only if it is missing
remote_file "#{Chef::Config[:file_cache_path]}/opencart_v#{node['opencart']['version']}.zip" do
  source node['opencart']['url']
  action :create_if_missing
  
end

# unzip the file
f_name = "#{node['opencart']['file_name']}.zip"
execute "unzip" do
  cwd "#{Chef::Config[:file_cache_path]}"
  command "unzip #{node['opencart']['file_name']}.zip"
  not_if { ::File.exists?(f_name) }
end

# move files to web
execute "copy opencart" do
  cwd "#{Chef::Config[:file_cache_path]}"
  command "cp -r upload/* #{node['opencart']['store_dir']}"
end

# prepare for installation
directory "#{node['opencart']['store_dir']}system/download" do
  recursive true
  action :create
  mode 0777
end

execute "rpm for php-mcrypt" do
  user "root"
  cwd "/var/tmp"
  command <<-EOH
  rpm -Uvh #{node['opencart']['epel']}
  EOH
  not_if "rpm -qa | grep epel-release-6-8.noarch"
end

# install dependencies for OpenCart
%w{php php-mysql php-gd php-curl php-pecl-zip unzip php-mcrypt}.each do |pkg|
  yum_package "#{pkg}" do
    action :install
    retry_delay 5
  end
end

execute "prepare store" do
  cwd "#{node['opencart']['store_dir']}"
  command <<-EOH
  chmod 0777 system/
  chmod 0777 system/cache/ 
  chmod 0777 system/logs/ 
  chmod 0777 system/download/
  chmod 0777 image/
  chmod 0777 image/cache/ 
  chmod 0777 image/data/ 
  chmod 0777 download/ 
  EOH
end


template "#{node['opencart']['store_dir']}config.php" do
    source "config-store.php.erb"
    owner "root"
    group "root"
    mode 00777
 end
 
template "#{node['opencart']['store_admin_dir']}config.php" do
    source "config-admin.php.erb"
    owner "root"
    group "root"
    mode 00777
 end


service "httpd" do
  action [:restart]
end 

execute "delete Install Folder" do
  cwd "#{node['opencart']['store_dir']}"
  command <<-EOH
  rm -fR install
  EOH
  only_if do
  File.exists?("#{node['opencart']['store_dir']}install")
  end
end

# copy database tables
remote_directory "#{node['opencart']['db_database_lib']}" do
  source "tables"
  files_owner "mysql"
  files_group "mysql"
  files_mode 00660
  only_if do
  File.exists?("#{node['opencart']['db_database_lib']}")
  end
end

# give permission to mysql
execute "change security context" do
  cwd "#{node['opencart']['db_database_lib']}"
  command <<-EOH
  chcon -R -t mysqld_db_t *
  EOH
  only_if do
  File.exists?("#{node['opencart']['db_database_lib']}")
  end
end

