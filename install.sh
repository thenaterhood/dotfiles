#!/bin/bash
#
# Author: Nate Levesque <public@thenaterhood.com>
# Language: Shell
# Filename: install.sh
#
# Description:
#   Creates symlinks to the dotfiles in their appropriate
#   locations relative to a home directory or the partition root.
#   The script will create symlinks for other files
#   as well if their locations are listed in the locations file.  
#   The idea was to give the script as much flexibility as possible
#   so that it can have uses beyond installing dotfiles.
#
# TODO:
#   Add an update ability
#   Add the ability to restore from dotfiles.old files
#

#####################################################
# Sets a few initial variables and makes folders	#
# that the script expects to exist				  #
#####################################################
user=$USER
basepath=`pwd`
home=$HOME
root=''
rootUID=0
mkdir ~/dotfiles.old 2>/dev/null || echo -e "$(error) could not create backup directory"
mkdir ~/.config 2>/dev/null || echo -e "$(error) could not create .config directory"

NORMAL="\033[0m"
RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[34;1m"
YELLOW="\033[1;33m"


#####################################################
# Define a few functions to use later			   #
#####################################################
ok(){
	echo "$GREEN=> ok -$NORMAL";
}
notice(){
	echo "$YELLOW=> notice -$NORMAL";
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
	
	read -p "Install system files (not just personal)? y/n: " doRoot
	if [ $doRoot = "n" ]; then
		isRoot=False
	fi
	
	echo -e "$(notice) Please enter the full path to the home directory of the user to install personal dotfiles into\n"
	echo "Note that this script can be run more than once to install dotfiles to other users as well."
	read -p "User directory: " home
	
	if [ "$home" = "" ]; then home=$HOME; fi
}

#####################################################
# Dependency checks								 #
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
checkRequired awk
checkRecommended conky
checkRecommended tint2

echo -e "$(notice) This will install ALL the dotfiles into their appropriate locations."

#####################################################
# Checks if root									#
#####################################################
if [ $rootUID != $UID ]; then
	read -p "Waiting for you to hit enter, as there were important messages"
	isRoot=False
else
	isRoot=True
	rootTasks
fi

#####################################################
# Iterates through the list of targets in locations #
#####################################################
while read p; do
	# Breaks the location line in the file to its location and basename
	local=`echo $p | awk '{print $1}'`
	file=$local
	target=`echo $p | awk '{print $2}' | sed -e s:'$HOME':$home:g | sed -e s:'$ROOT':$root:g`
	
	# Moves the existing file and links the dotfiles file in its place
	# depending on user permissions
	if [ $isRoot = True ] || [ `echo $target | cut -c 2-5` = 'home' ] || [ `echo $target | cut -c 2-6` = 'Users' ] || [ `echo $target | cut -c 2-5` = 'root' ]; then
	
		# Moves the existing config file if it exists
		if [ -e "$target" ] || [ -h "$target" ]; then
			echo -e "$(notice) $file exists, moving it to ~/dotfiles.old"
			mv $target $HOME/dotfiles.old/ || echo -e "$(error) could not move $file out of the way"
		fi
		
		# Installs the new config file by linking it to the dotfiles folder
		ln -s $basepath/$local $target && echo -e "$(ok) Installed $file to $target" || echo -e "$(error) could not install $file to $target"
		
	else
		echo -e "$(notice) skipping $file."
	fi

done < $basepath/locations
