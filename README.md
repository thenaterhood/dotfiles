dot-conf
========

Version controlled dot configuration files for various Linux software.
In some cases, the Windows variants of the software use the same files.

Contents
------------

Configuration data for 

    tint2/		configuration for tint2 taskbar
    .conkyrc	conky configuration
    .bashrc 	bash aliases and prompt customization
    .idlerc/ 	dark color scheme for python's IDLE
    redshift    ready-made redshift conf, uncomment your location

Installation
------------

To install the configurations, you must check out the repository
from github using:

	git clone --recursive https://github.com/thenaterhood/dotfiles.git ~/dotfiles
	
This command clones the repository to the dot-conf folder in your user directory.
	
followed by 
	
	cd ~/dotfiles
	git submodule update --init --recursive
	
The --init flag initizlizes the submodule repositories and the --recursive flag
makes sure that nested submodules are initialized and updated as well.

After you've downloaded and initialized the repository, you can link the
configuration files to their proper locations using the commands below.
These commands create a symlink in the proper location that points to the repository
on your computer.  You can update your dot-conf by running

	cd ~/dotfiles
	git fetch
	git pull
	
You may want to learn more github commands in order to update specific files.

To install the dotfiles files automatically, open a terminal and navigate
to the dot-conf folder.  Once there, run

    ./install.sh
    
This will create symlinks to all of the config files stored in the dotfiles
folder in the appropriate locations in your user directory.  Note that 
this will move any affected configuration files that already exist and install
the dotfiles files in their place as symlinks.  Although this should be safe,
as with anything you should back them up just in case.  Running the script
more than once will replace the backup copies of the files, so DO NOT do it
unless you really need to.  You can remove the dotfiles.old directory it moves things to
if you don't need them.

The script can be run from any location in your home directory so feel free
to put it in ~/bin, ~/documents, or wherever you'd like to keep it.  If you
move it, run the install script again and it will replace symlinks to point to its
new location.

To manually install one or all of the files, use the commands below.

### tint2

	ln -s ~/dotfiles/tint2 ~/.config/tint2
	
### conky

	ln -s ~/dotfilesconkyrc ~/.conkyrc
	
### bash aliases

	ln -s ~/dotfiles/bashrc ~/.bashrc
	
### IDLE
	
	ln -s ~/dotfiles/idlerc ~/.idlerc
    
### Redshift
    
    ln -s ~/dotfiles/redshift.conf ~/.config/redshift.conf
