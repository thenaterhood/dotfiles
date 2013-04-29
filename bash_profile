#	~/.bash_profile shell configuration file
#
#	This file contains configuration commands which will
#	be executed for each shell which starts up (e.g., each
#	shell window, and most commands given to the shell).
#	Changes to this file will NOT take effect in existing
#	shells unless you give the shell-level command "source ~/.bash_profile",
#	but they WILL take effect in shells created after you
#	change this file.

system=/usr/local/lib/config/Bash_Profile
personal=~/.bashrc

if [ -f $system ]; then
	echo "Found systemwide bash profile, applying..."
	source $system
fi

if [ -f $personal ]; then
	echo "Found user bash profile, applying..."
	source $personal
fi
