#!/bin/bash
# Creates symlinks to the dot-conf files in their appropriate
# locations.
echo "This will install the dot-conf files into their appropriate locations."
echo "Any file that exists will be renamed and kept, so if you forgot to"
echo "keep something, it won't break it.  If you don't want to install"
echo "all the files, do the installation manually."
echo ""
read -p "Hit enter to continue."

# Creates symlinks to the files, renaming existing files/folders if they exist
if [ -f ~/.bashrc ]
then
    echo "You already have a bashrc configuration, moving it to bashrc.BAK."
    mv ~/.bashrc ~/bashrc.BAK
fi
ln -s ~/dot-conf/bashrc ~/.bashrc


if [ -d ~/.config/tint2 ]
then
    echo "You already have a tint2 configuration, moving it to tint2.BAK."
    mv ~/.config/tint2 ~/.config/tint2.BAK
fi
ln -s ~/dot-conf/tint2 ~/.config/tint2


if [ -f ~/.conkyrc ]
then
    echo "You already have a conky configuration, moving it to conkyrc.BAK."
    mv ~/.conkyrc ~/conkyrc.BAK
fi
ln -s ~/dot-conf/conkyrc ~/.conkyrc


if [ -d ~/.idlerc ]
then
    echo "You already have a idle configuration, moving it to idlerc.BAK"
    mv ~/.idlerc ~/idlerc.BAK
fi
ln -s ~/dot-conf/idlerc ~/.idlerc

# Reports that it finished
echo ""
echo "Installed dot-conf files.  Restart programs for them to take effect."

