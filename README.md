OpenCart Cookbook
=================
This cookbook can be used to install Opencart_v1.5.1.3.1 on CentOs.

Requirements
------------
This cookbook requires the following packages.

#### packages
- `mysql` 
- `apache2`

Attributes
----------
#### OpenCart::default
default['opencart']['url'] = "http://opencart.googlecode.com/files/#{node['opencart']['file_name']}.zip"

default['opencart']['epel'] = "http://www.gtlib.gatech.edu/pub/fedora-epel/6/i386/epel-release-6-8.noarch.rpm"

default['opencart']['web_dir'] = "/var/www/html/"
default['opencart']['store_dir'] = "#{node['opencart']['web_dir']}store/"
default['opencart']['store_admin_dir'] = "#{node['opencart']['store_dir']}admin/"


# config

default['opencart']['http_server'] = "#{node['ipaddress']}/store/"
default['opencart']['http_image'] = "#{node['ipaddress']}/store/image/"
default['opencart']['http_admin'] = "#{node['ipaddress']}/store/admin/"

default['opencart']['https_server'] = "#{node['ipaddress']}/store/"
default['opencart']['https_image'] = "#{node['ipaddress']}/store/image/"

default['opencart']['dir_application'] = "#{node['opencart']['store_dir']}catalog/"
default['opencart']['dir_system'] = "#{node['opencart']['store_dir']}system/"
default['opencart']['dir_database'] = "#{node['opencart']['store_dir']}system/database/"
default['opencart']['dir_language'] = "#{node['opencart']['store_dir']}catalog/language/"
default['opencart']['dir_template'] = "#{node['opencart']['store_dir']}catalog/view/theme/"
default['opencart']['dir_config'] = "#{node['opencart']['store_dir']}system/config/"
default['opencart']['dir_image'] = "#{node['opencart']['store_dir']}image/"
default['opencart']['dir_cache'] = "#{node['opencart']['store_dir']}system/cache/"
default['opencart']['dir_download'] = "#{node['opencart']['store_dir']}download/"
default['opencart']['dir_logs'] = "#{node['opencart']['store_dir']}system/logs/"

# admin-config 
default['opencart']['dir_admin'] = "#{node['opencart']['store_dir']}admin/"
default['opencart']['dir_admin_lag'] = "#{node['opencart']['dir_admin']}language/"
default['opencart']['dir_admin_template'] = "#{node['opencart']['dir_admin']}view/template/"
default['opencart']['dir_admin_catalog'] = "#{node['opencart']['store_dir']}catalog/"

# db 
default['opencart']['db_driver'] = 'mysql'
default['opencart']['db_hostname'] = 'localhost'
default['opencart']['db_username'] = 'root'
default['opencart']['db_password'] = 'qwerty'
default['opencart']['db_database'] = 'opencartdb'
default['opencart']['db_prefix'] = ''
default['opencart']['db_database_lib'] = "/var/lib/mysql/#{node['opencart']['db_database']}/"



Usage
-----
#### OpenCart::default

Just include `OpenCart` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[OpenCart]"
  ]
}
```

Contributing
------------
This is an OpenSource repo. Fell free to fork and improve or make the cookbook more generic.

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Shekar N H
