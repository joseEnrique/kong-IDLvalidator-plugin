#!/bin/bash

echo "Starting to Install custom plugins"
## For each custom plugin
## cd /usr/local/custom/kong/plugins/<plugin_name>
## luarocks make

ls -lasi 

cd /usr/local/custom/kong/plugins/idlvalidator
luarocks make

echo "Done Installing custom plugins"