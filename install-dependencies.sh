#!/bin/bash
echo
echo "This script is supposed to run individually."
echo "I.E: please do NOT run it in 'vim-adventures' repository folder."
echo
echo "Create an user before running this script. For example:"
echo "apt update; apt install sudo; useradd -m -s /bin/bash -G sudo <username>; passwd <username>"
read -p "Go? (Y/n): " ANS
if [ "$ANS" != "" ] && [ "$ANS" != "y" ] && [ "$ANS" != "Y" ] ; then
	exit 0
fi

mkdir -p $HOME/.local

echo "Install necessary packages..."
sudo apt update
sudo apt install -y build-essential python python3 python-dev python3-dev \
		python-pip python3-pip wget curl libncurses5-dev git cmake autoconf pkg-config
if [ $? -ne 0 ]; then
	echo "apt install failed, quit."
	exit 1
fi

echo
echo "Installing vim..."
cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --prefix=$HOME/.local --enable-pythoninterp=yes --enable-python3interp=yes
make -j$(nproc)
sudo make install
cd -
echo "" >> ~/.bashrc
echo "alias vi='vim'" >> ~/.bashrc
alias vi='vim'

echo
echo "Installing gtags..."
cd ~
wget -c "https://ftp.gnu.org/pub/gnu/global/global-6.6.8.tar.gz"
tar zxvf global-6.6.8.tar.gz
cd global-6.6.8
./configure --prefix=$HOME/.local
make -j$(nproc)
sudo make install
cd -

export PATH=$PATH:$HOME/.local/bin

echo
echo "Installing vim-plug then all plugins..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd ~
git clone https://github.com/super119/vim-adventures.git
cp vim-adventures/vimrc .vim

vim +PlugInstall +qall
rm -rf global-6.6.8 global-6.6.8.tar.gz vim vim-adventures
cd -
echo "Done."
