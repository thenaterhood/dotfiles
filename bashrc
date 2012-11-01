
# Check for an interactive session
PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
[ -z "$PS1" ] && return
PS1='[\u@\h \W]\$ '

# General aliases
alias ls='ls --color=auto'
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

# Scripts
alias displays='bash /home/nate/.apps/display_configurator.sh'
alias touchpad='bash /home/nate/.apps/touchpad_switch.sh'
alias rip='bash /home/nate/.apps/audio_ripper.sh'
alias backup='sudo bash /home/nate/.apps/backup/backup.sh'
alias sleep='sudo bash /home/nate/.apps/sleep.sh'

# Software-specific commands
alias l='slimlock'
alias Syu='sudo pacman -Syu'
alias Syua='sudo yaourt -Syua'
alias virtualbox='gksudo VirtualBox &'
alias fidget='figlet'
alias csv='cvs'

# Cygwin Aliases
alias win='cd /cygdrive/C'
alias winh='cd /cygdrive/C/Users/nate'
alias uac='/cygdrive/C/Users/nate/cmd_alias/uac.bat'
