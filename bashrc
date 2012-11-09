
# Changes the prompt text.  See bash man page for codes.
#export PS1="\e[1;34m(\t)\e[0;32m \u\e[m\e[0;32m@\h \W \$ \e[m >\[\033[0m\] "
ROOT_UID=0
if [ "$UID" -eq "$ROOT_UID" ]
then
PS1="\[\033[31;1m\](\t)\[\033[0m\] \u@\h \\$\w \$ \[\033[0m\]"
else
PS1="\[\033[34;1m\](\t)\[\033[0m\] \[\033[0;32m\]\u@\h \\$\w> \[\033[0m\]\[\033[0m\]"
fi

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
alias python='python3'

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
