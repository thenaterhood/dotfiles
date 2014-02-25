dotfiles
========

Version controlled dot configuration files for various Linux software.
In some cases, the Windows variants of the software use the same files.

README Contents
------------

    List of repository contents
    Installation instructions
    HOWTO Manually install dotfiles
    HOWTO work with the install script
    LICENSE
    

Repo Contents
------------

Configuration data for 

    tint2/		configuration for tint2 taskbar
    conkyrc	    conky configuration
    bashrc 	    bash aliases and prompt customization
    idlerc/ 	dark color scheme for python's IDLE
    redshift    ready-made redshift conf, uncomment your location
    fluxbox/    select fluxbox config files (does NOT include a menu)
    gtkrc-2.0   a basic gtkrc theme setup.  Relies on Adwaita currently.
    synaptics   multitouch configuration for synaptics with natural scrolling
    jupiter     a fixed notification script for jupiter, so notifications go away
    vconsole    font, keymap, and fontmap settings for the virtual console
    

Installation
------------

To install the configurations, you must check out the repository
from github into the directory of your choice using:

	git clone --recursive https://github.com/thenaterhood/dotfiles.git ~/dotfiles
	
This command clones the repository to the dotfiles folder in your user directory.
Note that the rest of these instructions assume you placed the dotfiles folder
into your user directory, in ~/dotfiles.  If you put it somewhere else, be sure
to adjust the path whenever the folder is referenced.
	
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
    
### Fluxbox

    ln -s ~/dotfiles/fluxbox ~/.fluxbox
    
Note: You will need to generate a menu (not currently included) for 
fluxbox to be easier to use.  It may do this when you first log into the 
fluxbox WM, if not you'll need to look up the command for your distro to 
generate the menu.  You can also create it manually if you know what 
you're doing.

### GTK 2.0

    ln -s ~/dotfiles/gtkrc-2.0 ~/.gtkrc-2.0

Note: You will most likely want this if you're using Fluxbox or another 
window manager.  It sets up a default theme for your apps to use so they 
don't look ugly.  It relies on the Adwaita theme right now, but you can 
edit the file without a problem to use a different theme.  Be aware when 
updating that this file is likely to change in the future.

Using the Install Script
------------
The install script is fairly flexible in how it works, so it can be expanded 
to serve other purposes or to install additional files.  Currently, the script 
is capable of installing files for a user in their home directory or installing 
a collection of dotfiles for the system (including users) if run with root 
privileges.  The script is entirely flexible and the dotfiles directory can 
be located anywhere on the system.

The install script reads from the locations file, which is a list of files 
and the location to install them to.  Each line of the file has the "local" 
name or path of the file as it is stored in relation to the dotfiles directory.  
Separated by a tab, the second section of the line contains the path to where 
the file should be installed.  This section is prefixed by either $HOME or 
$ROOT so that the script can identify if the file can be installed without 
root privileges.  These are automatically adjusted on the fly to point to the correct 
location when the script is run.

With these guidelines, the locations file can be modified to exclude files 
that are in the repository by default, include files that are not in the 
repository by default, or to change the locations the files are installed to 
or linked to.  Note that when the install script is run, links will be created 
whether or not the file actually exists, so make sure the path is correct as the 
script will not verify it.

If the install script is invoked with root privileges, the script will move the 
containing directory into the /opt folder if it isn't already there for safety 
because the folder now may contain shared and system files.  Worth noting 
is that on a multi-user system, the script can be invoked without root rights 
to install the personal collection of dotfile links into each individual user 
directory if the user chooses.  Root can also do this, as when the script 
is invoked by root it will present the option of installing the personal 
collection to a home directory other than that of root.  For this reason, 
the script could be used when initially creating a user to create a default
config for the user, if for some reason using the system defaults isn't 
desirable.

WARNINGS:
The install script does not restore or undo linking the files, so if 
you intend to use it, be aware that you will need to manually remove links 
or restore the original files.

Although the script will move existing files out of the way into a dotfiles.old 
folder in the home directory of the user invoking it, it will not check to 
see if files already exist in dotfiles.old prior to moving them there.  Run 
the script ONCE and if something goes wrong, the dotfiles directory gets moved, 
or any other reason, rename or otherwise backup the dotfiles.old directory 
because its contents will get overwritten by whatever happens to be in the 
location of the files being installed.


LICENSE
------------

Included software is distributed under the BSD license. 
See LICENSE for full license text. Files licensed under the BSD License 
contain a line specifying so in the docblock. 

Though not required by the license terms, 
please consider contributing, providing feedback, or simply dropping a line 
to say that this software was useful to you.

Included designs, art, graphics, styles, and any other contents not licensed under 
or not covered by the BSD License are licensed under the Creative Commons 
Attribution-ShareAlike v3.

[![Creative Commons License](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)](http://creativecommons.org/licenses/by-sa/3.0/)


This work is licensed under the [Creative Commons Attribution-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/).

To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/ or send
a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

thenaterhood/dotfiles repository (c) 2012-2014 Nate Levesque (TheNaterhood).
All rights reserved.
