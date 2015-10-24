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
#   Licensed under the BSD license. See LICENSE for full license

NORMAL="\033[0m"
RED="\033[1;31m"
GREEN="\033[0;32m"
BLUE="\033[34;1m"
YELLOW="\033[0;33m"

inform(){
	echo -e "$GREEN[INFO]$NORMAL $1";
}
warn(){
	echo -e "$YELLOW[WARN]$NORMAL $1";
}
error(){
	echo -e "$RED[FAIL] $1$NORMAL";
}

#####################################################
# Sets a few initial variables and makes folders
# that the script expects to exist
#####################################################
user=$USER
basepath=`pwd`
home=$HOME
root=''
rootUID=0

inform "DO NOT use this script to install user files systemwide."
inform "You can create system-wide preferences by putting files in /etc"

#####################################################
# Define a few functions to use later
#####################################################
rootTasks(){
	# Performs a few additional tasks if the script has been run
	# as root.  Moves the dotfiles folder to /opt/dotfiles so that
	# the (soon to be) system files don't get accidentally overwritten
	# and asks what user directory to link the personal dotfiles to.
	# Leaves permissions intact so the user still has rw access
	# to the files.
	if [ ! `pwd` = "/opt/dotfiles" ]; then
		warn "Moving files to /opt/dotfiles since it contains system files."

		mv `pwd` /opt/dotfiles && basepath=/opt/dotfiles || error "Something went wrong, leaving it where it is"
	fi

	read -p "Install system files (not just personal)? y/n: " doRoot
	if [ $doRoot = "n" ]; then
		isRoot=False
	fi

	read -p "Enter the full path to the home directory of a user: " home

	if [ "$home" = "" ]; then home=$HOME; fi
}

linkfile(){
        targetfile=$2
        file=$1

        if [ -e "$targetfile" ] || [ -h "$targetfile" ]; then
                warn "$file exists, backing up original"
                mv $targetfile ~/dotfiles.old/ || error "Failed to back up $targetfile"
        fi

        ln -sf $basepath/$localfile $targetfile && inform "Installed $file to $targetfile" || error "Could not symlink $file to $targetfile"
}

#####################################################
# Dependency checks
#####################################################
checkRequired(){
	if [ ! `command -v $1` ]; then
		error "could not fine $1, which is required for this script."
		exit 1
	fi
}

checkRequired sed
checkRequired awk

#####################################################
# Checks if root
#####################################################
if [ $rootUID != $UID ]; then
	read -p "Waiting for you to hit enter, as there were important messages"
	isRoot=False
else
	isRoot=True
	rootTasks
fi

#####################################################
# Iterates through the list of targets in locations
#####################################################
mkdir ~/dotfiles.old 2>/dev/null || error "could not create backup directory"
mkdir $home/.config 2>/dev/null || error "could not create .config directory"

while read p; do
	# Breaks the location line in the file to its location and basename
	localfile=`echo $p | awk '{print $1}'`
        target=`echo $p | awk '{print $2}'`

        if [ `expr match "$target" '$HOME'` -gt 0 ]; then
                targetfile=`echo $target | sed -e s:'$HOME':$home:g`

                linkfile $localfile $targetfile
        fi

        if [ `expr match "$target" '$ROOT'` -gt 0 ]; then
                targetfile=`echo $target | sed -e s:'$ROOT'::g`

                if [ $isRoot = True ]; then
                        linkfile $localfile $targetfile
                fi
        fi

done < $basepath/locations
