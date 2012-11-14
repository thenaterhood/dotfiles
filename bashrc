# Sets the bash color codes to english variables
NORMAL="\[\033[0m\]"
RED="\[\033[31;1m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[34;1m\]"

username=`whoami`

# Changes the prompt text.  See bash man page for codes.
ROOT_UID=0
if [ "$UID" -eq "$ROOT_UID" ]; then
    PS1="$RED(\t) \u@\h $RED\\w\\$ $NORMAL"
else
    PS1="$BLUE(\t)$NORMAL $GREEN\u@\h \\w\\$ $NORMAL"
fi

# General aliases
alias ls='ls --color=auto'
alias sl='ls -lr'
alias ll='ls -lh'
alias la='ls -a'
alias lal='ls -alh'
alias pgp='gpg'
alias quit='exit'
alias cls='clear'
alias h='cd ~/'
alias ..='cd ..'
alias KILLITWITHFIRE='killall -KILL'
alias lgrep='ls | grep'
alias llgrep='ls -lh | grep'
alias lagrep='ls -alh | grep'
alias lg='ls | grep'
alias llg='ls -lh | grep'
alias lag='ls -alh | grep'
alias python='python3'

# Scripts
alias displays='bash /home/$username/.apps/display_configurator.sh'
alias touchpad='bash /home/$username/.apps/touchpad_switch.sh'
alias rip='bash /home/$username/.apps/audio_ripper.sh'
alias backup='sudo bash /home/$username/.apps/backup/backup.sh'
alias suspend='sudo bash /home/$username/.apps/sleep.sh'

# Software-specific commands
alias l='slimlock'
alias Syu='sudo pacman -Syu'
alias pacS='sudo pacman -S'
alias pacR='sudo pacman -Rs'
alias Syua='sudo yaourt -Syua'
alias virtualbox='gksudo VirtualBox &'
alias fidget='figlet'
alias csv='cvs'

# Windows-related Aliases
if [ `uname | cut -c 1-5` != "Linux" ]; then
    alias win='cd /cygdrive/C'
    alias winh='cd /cygdrive/C/Users/$username'
    alias uac='/cygdrive/C/Users/$username/cmd_alias/uac.bat'
    alias sudo='/cygdrive/C/Users/$username/cmd_alias/uac.bat'
else
    alias win='cd /mnt/windows_seven'
    alias winh='cd /mnt/windows_seven/Users/$username'
    alias uac='sudo'
fi
