#!/bin/bash
# Creates symlinks to the dot-conf files in their appropriate
# locations.
echo "This will install the dot-conf files into their appropriate locations."
echo "Any file that exists will be renamed and kept, so if you forgot to"
echo "keep something, it won't break it.  If you don't want to install"
echo "all the files, do the installation manually."
echo ""
read -p "Hit enter to continue."


#####################################################
# Sets a few initial variables and makes folders    #
# that the script expects to exist                  #
#####################################################
user=$USER
basepath="/home/$user"
mkdir ~/dotfiles.old 2>/dev/null
mkdir ~/.config 2>/dev/null


#####################################################
# Iterates through the list of targets in locations #
#####################################################
while read p; do
    # Breaks the location line in the file to its location and basename
    file=`basename $p`
    target=$p
    
    # Picks out the dot-conf file that should be linked
    if [ `echo $file | cut -c 1` = "." ]; then
        local=`echo $file | cut -c 2-40`
    else
        local=$file
    fi
    
    # Moves the existing config file if it exists
    if [ -e "/home/$user/$target" ]; 
    then
        echo "$file exists, moving it to ~/dotfiles.old"
        mv /home/$user/$target /home/$user/dotfiles.old/
    fi
    
    # Installs the new config file by linking it to the dot-conf folder
    ln -s /home/$user/dot-conf/$local /home/$user/$target
    echo "Installed $p to ~/$target"

done < ./locations
