#####################################################
#   Sets the bash color codes to english variables  #
#####################################################
NORMAL="\[\033[0m\]"
RED="\[\033[31;1m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[34;1m\]"


#####################################################
# Sets a few prelimary variables for later commands #
#####################################################
username=$USER
ROOT_UID=0

#####################################################
# Changes the prompt text and colors                #
# See bash man page for codes.                      #
#####################################################
if [ "$UID" -eq "$ROOT_UID" ]; then
    PS1="$RED(\t) \u@\h $RED\\w\\$ $NORMAL"
else
    PS1="$BLUE(\t)$NORMAL $GREEN\u@\h \\w\\$ $NORMAL"
fi

#####################################################
# General aliases to shorten commands/make other OS #
# commands available (coming fron windows)          #
#####################################################
alias ls='ls --color=auto'
alias sl='ls -lr'
alias ll='ls -lh'
alias la='ls -a'
alias lal='ls -alh'
alias quit='exit'
alias cls='clear'
alias ..='cd ..'
alias KILLITWITHFIRE='killall -KILL'
alias lgrep='ls | grep'
alias llgrep='ls -lh | grep'
alias lagrep='ls -alh | grep'
alias lg='ls | grep'
alias llg='ls -lh | grep'
alias lag='ls -alh | grep'
alias python='python3'

#####################################################
# Typo-related aliases                              #
#####################################################
alias pgp='gpg'
alias fidget='figlet'
alias csv='cvs'

#####################################################
# Application-related shortcuts for accidentally    #
# using vim/whatever commands in bash               #
#####################################################
alias :q='exit'

#####################################################
# Aliases to call scripts (found in shellzilla repo)#
#####################################################
alias displays='bash ~/bin/shellzilla/display_configurator.sh'
alias touchpad='bash ~/bin/shellzilla/touchpad_switch.sh'
alias rip='bash ~/bin/shellzilla/audio_ripper.sh'
alias backup='~/bin/shellzilla/system_backup.sh'
alias suspend='bash ~/bin/shellzilla/suspend.sh'

#####################################################
# Distro/software specific commands                 #
#####################################################
alias l='slimlock'
alias Syu='sudo pacman -Syu'
alias pacS='sudo pacman -S'
alias pacR='sudo pacman -Rs'
alias Syua='sudo yaourt -Syua'
alias virtualbox='gksudo VirtualBox &'
alias sign='pgp --detach-sign' 
alias verify='pgp --verify'

#####################################################
# Cross-platform alias setup (linux/mac/cygwin)     #
#####################################################
case "$OSTYPE" in 
    cygwin)
        alias win='cd /cygdrive/C'
        alias winh='cd /cygdrive/C/Users/$username'
        alias uac='/cygdrive/C/Users/$username/cmd_alias/uac.bat'
        alias sudo='/cygdrive/C/Users/$username/cmd_alias/uac.bat'
        alias open='cmd /c start'
        alias ifconfig='ipconfig'
        ;;
    linux*)
        alias win='cd /mnt/windows_seven'
        alias winh='cd /mnt/windows_seven/Users/$username'
        alias uac='sudo'
        alias open='xdg-open'
        alias ipconfig='ifconfig'
        ;;
    darwin*)
        alias uac='sudo'
        alias ipconfig='ifconfig'
        #mac already has an open command
        
esac
