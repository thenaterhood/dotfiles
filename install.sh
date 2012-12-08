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
basepath=`pwd`
home=$HOME
mkdir ~/dotfiles.old 2>/dev/null
mkdir ~/.config 2>/dev/null

NORMAL="\033[0m"
RED="\033[31;1m"
GREEN="\033[0;32m"
BLUE="\033[34;1m"
YELLOW="\033[0;33m"


#####################################################
# Define a few functions to use later               #
#####################################################
ok(){
    echo "$GREEN ok -$NORMAL";
}
notice(){
    echo "$YELLOW notice -$NORMAL";
}
error(){
    echo "$RED error -$NORMAL";
}

#####################################################
# Grabs wallpapers off the Internet                 #
#####################################################
cd backgrounds
curl -O http://www.thenaterhood.com/images/dotfileswall.jpg
cd ..

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
    if [ -e "$HOME/$target" ] || [ -h "$HOME/$target" ]; 
    then
        echo -e "$(notice) $file exists, moving it to ~/dotfiles.old"
        mv $HOME/$target $HOME/dotfiles.old/ || echo -e "$(error) could not move $file out of the way"
    fi
    
    # Installs the new config file by linking it to the dot-conf folder
    ln -s $basepath/$local $HOME/$target && echo -e "$(ok) Installed $p to ~/$target" || echo -e "$(error) could not install $file"

done < ./locations
