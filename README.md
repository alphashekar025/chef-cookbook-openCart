OpenCart Cookbook
=================
This cookbook can be used to install Opencart_v1.5.1.3.1 on CentOs.

Requirements
------------
This cookbook requires the following packages.

#### packages
- `mysql` 
- `apache2`
- `database`

Attributes
----------
#### OpenCart::default
default['opencart']['version'] = "1.5.1.3.1"
default['opencart']['file_name'] = "opencart_v1.5.1.3.1"
default['opencart']['url'] = "http://opencart.googlecode.com/files/#{node['opencart']['file_name']}.zip"

default['opencart']['epel'] = "http://www.gtlib.gatech.edu/pub/fedora-epel/6/i386/epel-release-6-8.noarch.rpm"

default['opencart']['web_dir'] = "/var/www/html/"
default['opencart']['store_dir'] = "#{node['opencart']['web_dir']}store/"
default['opencart']['store_admin_dir'] = "#{node['opencart']['store_dir']}admin/"


# config

node['opencart']['http_server'] 
node['opencart']['http_image'] 
node['opencart']['http_admin'] 

node['opencart']['https_server'] 
node['opencart']['https_image'] 

node['opencart']['dir_application'] 
node['opencart']['dir_system'] 
node['opencart']['dir_database'] 
node['opencart']['dir_language'] 
node['opencart']['dir_template'] 
node['opencart']['dir_config'] 
node['opencart']['dir_image'] 
node['opencart']['dir_cache'] 
node['opencart']['dir_download'] 
node['opencart']['dir_logs'] 

# admin-config 
node['opencart']['dir_admin'] 
node['opencart']['dir_admin_lag'] 
node['opencart']['dir_admin_template'] 
node['opencart']['dir_admin_catalog'] 

# db 
node['opencart']['db_driver'] 
node['opencart']['db_hostname'] 
node['opencart']['db_username'] 
node['opencart']['db_password'] 
node['opencart']['db_database'] 
node['opencart']['db_prefix'] 
node['opencart']['db_database_lib'] 



Usage
-----
#### OpenCart::node

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

LICENSE:
========

<table>
  <tr>
    <th>Author</th><td>Shekar N H</td>
  </tr>
  <tr>
    <th>Copyright</th><td>Copyright (c) 2013 Sheakr_nh</td>
  </tr>
  <tr>
    <th>License</th><td>GNU GPL_v2</td>
  </tr>
</table>