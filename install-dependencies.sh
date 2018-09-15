#!/bin/bash
echo "Create an user before running this script. For example:"
echo "apt update; apt install sudo; useradd -m -s /bin/bash -G sudo <username>; passwd <username>"
read -p "Go? (Y/n): " ANS
if [ "$ANS" != "" ] || [ "$ANS" != "y" ] || [ "$ANS" != "Y" ] ; then
	exit 0
fi

echo "Install necessary packages..."
sudo apt update
sudo apt install build-essential python python3 python-dev python3-dev \
		python-pip python3-pip wget curl libncurses5-dev git cmake
if [ $? -ne 0 ]; then
	echo "apt install failed, quit."
	exit 1
fi

echo "Installing Rust... DO NOT CHANGE RUST INSTALL PATH"
curl https://sh.rustup.rs -sSf | sh
if [ $? -ne 0 ]; then
	echo "Install Rust failed, quit."
	exit 1
fi
source $HOME/.cargo/env
rustup component add rust-src

cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --enable-pythoninterp=yes --enable-python3interp=yes
make -j4
sudo make install
cd -
alias vi="vim"
echo "alias vi='vim'" >> ~/.bashrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd ~
git clone https://github.com/super119/vim-adventures.git
cp vim-adventures/vimrc .vim

echo "Done. Run vi and call 'PlugInstall'."
