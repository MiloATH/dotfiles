#! /bin/bash
# Install dotfiles
# Determine machine
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ $machine == "Mac" ]; then
    which -s brew
    if [[ $? != 0 ]] ; then
        # Install Homebrew
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        brew update
        brew upgrade
    fi
    # Use brew to install
    brew bundle --file=$DIR/Brewfile
fi

# copy files to home directory with correct name
for i in $(ls $DIR/_*); do
    cp $i $HOME/$(sed -e 's/^_/./g' <(basename $i))
done

# setup .ssh
# mkdir -p $HOME/.ssh
# cp $DIR/ssh_config $HOME/.ssh/config
