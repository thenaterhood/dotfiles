dot-conf
========

Version controlled dot configuration files for various Linux software.
In some cases, the Windows variants of the software use the same files.

Contents
------------

Configuration data for 

    tint2/		configuration for tint2
    .conkyrc	conky configuration
    .bashrc 	bash aliases and prompt customization
    .idlerc/ 	configuration for python3 IDLE (dark color scheme)

Installation
------------

To install the configurations, you must check out the repository
from github using:

	git clone --recursive https://github.com/thenaterhood/dot-conf.git ~/dot-conf
	
This command clones the repository to the dot-conf folder in your user directory.
	
followed by 
	
	cd ~/dot-conf
	git submodule update --init --recursive
	
The --init flag initizlizes the submodule repositories and the --recursive flag
makes sure that nested submodules are initialized and updated as well.

After you've downloaded and initialized the repository, you can link the
configuration files to their proper locations using the commands below.
These commands create a symlink in the proper location that points to the repository
on your computer.  You can update your dot-conf by running

	cd ~/dot-conf
	git fetch
	git pull
	
You may want to learn more github commands in order to update specific files.

To install the dot-conf files automatically, open a terminal and navigate
to the dot-conf folder.  Once there, run

    ./install.sh
    
This will create symlinks to all of the config files stored in the dot-conf
folder in the appropriate locations in your user directory.  Note that 
this will rename any affected configuration files that already exist and install
the dot-conf files in their place as symlinks.  Although this should be safe,
as with anything you should back them up just in case.  Running the script
more than once will replace the backup copies of the files, so DO NOT do it
unless you really need to.  You can remove the .BAK files it moves things to
if you don't need them.

### tint2

	ln -s ~/dot-conf/tint2 ~/.config/tint2
	
### conky

	ln -s ~/dot-conf/conkyrc ~/.conkyrc
	
### bash aliases

	ln -s ~/dot-conf/bashrc ~/.bashrc
	
### IDLE
	
	ln -s ~/dot-conf/idlerc ~/.idlerc
