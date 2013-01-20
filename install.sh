#!/bin/bash
#
# Author: Nate Levesque <public@thenaterhood.com>
# Language: Shell
# Filename: install.sh
#
# Description:
#   Creates symlinks to the dotfiles in their appropriate
#   locations.  Currently manages only dotfiles stored in a single
#   user's directory.  The script will create symlinks for other files
#   as well if their locations (relative to /home/user) are listed in
#   the locations file and the file is stored as the name of the config
#   file without the preceding "." in the dotfiles directory.
#
# TODO:
#   Add an update ability
#   Add the ability to restore from dotfiles.old files
#

#####################################################
# Sets a few initial variables and makes folders    #
# that the script expects to exist                  #
#####################################################
user=$USER
basepath=`pwd`
home=$HOME
root=''
rootUID=0
mkdir ~/dotfiles.old 2>/dev/null
mkdir ~/.config 2>/dev/null

NORMAL="\033[0m"
RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[34;1m"
YELLOW="\033[1;33m"


#####################################################
# Define a few functions to use later               #
#####################################################
ok(){
    echo "$GREEN=> ok -$NORMAL";
}
notice(){
    echo "$YELLOW\n=> notice -$NORMAL";
}
error(){
    echo "$RED\n!> error -$NORMAL";
}

rootTasks(){
    # Performs a few additional tasks if the script has been run
    # as root.  Moves the dotfiles folder to /opt/dotfiles so that
    # the (soon to be) system files don't get accidentally overwritten
    # and asks what user directory to link the personal dotfiles to.
    # Leaves permissions intact so the user still has rw access
    # to the files.
    if [ ! `pwd` = "/opt/dotfiles" ]; then
        echo -e "$(notice) For security and safety reasons, the dotfiles folder has been moved to /opt/dotfiles since it contains system files."

        mv `pwd` /opt/dotfiles
        basepath=/opt/dotfiles
    fi
    echo -e "$(notice) Please enter the full path to the home directory of the user to install personal dotfiles into\n"
    echo "Note that this script can be run more than once to install dotfiles to other users as well."
    read -p "User directory: " home
    
    if [ "$home" = "" ]; then home=$HOME; fi
}

#####################################################
# Dependency checks                                 #
#####################################################
checkRecommended(){
    if [ ! `command -v $1` ]; then
        echo -e "$(notice) It is recommended that you install $1."
    fi
}

checkRequired(){
    if [ ! `command -v $1` ]; then
        echo -e "$(error) could not fine $1, which is required for this script."
        exit 1
    fi
}

checkRequired sed
checkRecommended conky
checkRecommended tint2

echo -e "$(notice) This will install ALL the dotfiles into their appropriate locations."

#####################################################
# Checks if root                                    #
#####################################################
if [ $rootUID != $UID ]; then
    echo -e "$(notice) You are not logged in as root.  \nYou can safely ignore errors about permissions on /"
    read -p "Waiting for you to hit enter, as there were important messages"
    isRoot=False
else
    rootTasks
    isRoot=True
fi

#####################################################
# Iterates through the list of targets in locations #
#####################################################
while read p; do
    # Breaks the location line in the file to its location and basename
    file=`basename $p`
    target=`echo $p | sed -e s:'$HOME':$home:g | sed -e s:'$ROOT':$root:g`
    
    # Moves the existing file and links the dotfiles file in its place
    # depending on user permissions
    if [ $isRoot = True ] || [ `echo $p | cut -c 2-5` = 'HOME' ]; then
    
        # Picks out the dotfile that should be linked
        if [ `echo $file | cut -c 1` = "." ]; then
            local=`echo $file | cut -c 2-40`
        else
            local=$file
        fi
        
        # Moves the existing config file if it exists
        if [ -e "$target" ] || [ -h "$target" ]; then
            echo -e "$(notice) $file exists, moving it to ~/dotfiles.old"
            mv $target $HOME/dotfiles.old/ || echo -e "$(error) could not move $file out of the way"
        fi
        
        # Installs the new config file by linking it to the dotfiles folder
        ln -s $basepath/$local $target && echo -e "$(ok) Installed $file to $target" || echo -e "$(error) could not install $file to $target"
        
    else
        echo -e "$(notice) skipping $file, installing it requires root access."
    fi

done < $basepath/locations
