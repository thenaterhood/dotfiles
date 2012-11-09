#!/bin/bash
# Creates symlinks to the dot-conf files in their appropriate
# locations.
echo "This will install the dot-conf files into their appropriate locations."

# Creates symlinks to the files
ln -s ~/dot-conf/bashrc ~/.bashrc
ln -s ~/dot-conf/tint2 ~/.config/tint2
ln -s ~/dot-conf/conkyrc ~/.conkyrc
ln -s ~/dot-conf/idlerc ~/.idlerc

# Reports done
echo "Installed dot-conf."

