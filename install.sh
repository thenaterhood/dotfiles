#!/bin/bash
#
# Dotfiles installer script v2.
BASEPATH=`pwd`
BACKUPDIR=$HOME/.dotfiles.old
UNSAFE=false
COPY=false
MOVE=
DEST=$HOME
DOSYSTEM=false

# color codes for echo
NORMAL="\033[0m"
RED="\033[1;31m"
GREEN="\033[0;32m"
BLUE="\033[34;1m"
YELLOW="\033[0;33m"

function info()
{
    echo -e "$GREEN[INFO]$NORMAL $1";
}

function warning()
{
    echo -e "$YELLOW[WARN]$NORMAL $1";
}

function error()
{
    echo -e "$RED[FAIL] $1$NORMAL";
    exit 1
}

function checkFor() # $command - check the command is available
{
    if [ ! `command -v $1` ]; then
        error "$1 is required for this script."
    fi
}

function installDotfile() # $destination $target
{
    target=$2
    file=$1
    backUpFile "$target"

    if [ $COPY = true ]; then
        cp -r $file $target && info "Copied $file to $target" || error "Failed to copy $file to $target"
    else
        ln -sf $BASEPATH/$file $target && info "Installed $file to $target" || error "Failed to symlink $target to $file"
    fi
}

function backUpFile() # $original
{
    original=$1

    # Backs up a file if the UNSAFE flag is not set
    if [ $UNSAFE = false ] && [ -e "$original" ]; then
        info "$original exists - backing it up"
        mv "$original" "$BACKUPDIR" || error "Failed to back up $original."
    elif [ $UNSAFE = true ] && [ -e "$original" ]; then
        warning "UNSAFE is set - skipping backup of $original"
    fi
}

function installSystemfile() # $original $target
{
    target=$2
    original=$1

    backUpFile "$target"
    sudo cp "$original" "$target"
}

function checkForRoot()
{
    return [ $UID -eq 0 ]
}

function usage()
{
    cat <<HERETO
USAGE: install.sh [parameters]
    -s|--system          Install system dotfiles too
    -u|--unsafe          Don't back up files if they already
                         exist
    -c|--copy            For non-system files, copy the file
                         instead of creating a symlink
    -d|--dest DIRECTORY  Alternate destination (home) to place
                         symlinks. Useful with -c for setting
                         up another user quickly. Defaults to
                         $HOME.
HERETO
}

while [[ $# != 0 ]]; do
    case $1 in
        -s|--system)
            DOSYSTEM=true
            ;;
        -u|--unsafe)
            UNSAFE=true
            ;;
        -c|--copy)
            COPY=true
            ;;
        -d|--dest)
            DEST=$2
            shift
            ;;
        *)
            usage
            exit 0
            ;;
    esac
    shift
done

mkdir -p $BACKUPDIR || warning "Could not create $BACKUPDIR"
mkdir -p $DEST/.config || error "Could not create $DEST/.config"

while read p; do
    original=$(echo $p | awk '{print $1}')
    target=$(echo $p | awk '{print $2}')

    if [ $(expr "$target" : '$HOME') -gt 0 ]; then
        target=$(echo $target | sed -e s:'$HOME':$DEST:g)
        installDotfile $original $target
    fi

    if [ $(expr "$target" : '$ROOT') -gt 0 ]; then
        [ $DOSYSTEM = true ] && installSystemfile $original $target
    fi

done < $BASEPATH/locations
