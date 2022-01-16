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
export PATH=$PATH:$HOME/.local/bin
echo "" >> ~/.bashrc
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc

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
git checkout -b v8.2.4103 v8.2.4103
./configure --prefix=$HOME/.local --enable-pythoninterp=yes --enable-python3interp=yes
make -j$(nproc)
make install
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
make install
cd -

echo
echo "Installing vim-plug then all plugins..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd ~
wget -c "https://raw.githubusercontent.com/super119/vim-adventures/master/vimrc" -O .vim/vimrc

vim +PlugInstall +qall
rm -rf global-6.6.8 global-6.6.8.tar.gz vim
cd -

echo "Done."
