#!/bin/bash

file_path="/etc/crio/crio.conf"
new_line="conmon = \"/usr/bin/conmon\""

# Replace specific line in crio.conf
sed -i "121s~.*~$new_line~" "$file_path"

# Append registries configuration to crio.conf
cat <<EOF >> "$file_path"
[registries.search]
registries = ['docker.io', 'quay.io', 'registry.fedoraproject.org']
EOF

echo "Configuration updated in $file_path"
