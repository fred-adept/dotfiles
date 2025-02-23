#!/bin/bash

set -x

target=$(sudo -u $SUDO_USER echo $HOME/dotfiles)

if ! [ -x "$(command -v git)" ]; then
  apt-get update
  apt-get install -y git
fi

if ! [ -x "$(command -v puppet)" ]; then
  apt-get update
  apt-get install -y puppet r10k
fi

if [ ! -d "$target" ]; then
  sudo -u $SUDO_USER git clone https://github.com/frrad/dotfiles.git $target
fi

cd ${target}/puppet
r10k puppetfile install
export FACTER_sudo_user=$SUDO_USER
puppet apply --test --verbose $target/puppet/main.pp --modulepath=$target/puppet/modules

cd $target
sudo -u $SUDO_USER ./stow.sh
