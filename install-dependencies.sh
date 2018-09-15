#!/bin/bash
echo "Create an user before running this script. For example:"
echo "apt update; apt install sudo; useradd -m -s /bin/bash -G sudo <username>; passwd <username>"
read -p "Go? (Y/n): " ANS
if [ "$ANS" != "" ] && [ "$ANS" != "y" ] && [ "$ANS" != "Y" ] ; then
	exit 0
fi

echo "Install necessary packages..."
sudo apt update
sudo apt install -y build-essential python python3 python-dev python3-dev \
		python-pip python3-pip wget curl libncurses5-dev git cmake autoconf pkg-config
if [ $? -ne 0 ]; then
	echo "apt install failed, quit."
	exit 1
fi

echo
echo "Installing Rust... DO NOT CHANGE RUST INSTALL PATH"
curl https://sh.rustup.rs -sSf | sh
if [ $? -ne 0 ]; then
	echo "Install Rust failed, quit."
	exit 1
fi
source $HOME/.cargo/env
rustup component add rust-src

echo
echo "Installing vim..."
cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --enable-pythoninterp=yes --enable-python3interp=yes
make -j4
sudo make install
cd -
echo "" >> ~/.bashrc
echo "alias vi='vim'" >> ~/.bashrc

echo
echo "Installing universal-ctags..."
cd ~
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make -j4
sudo make install
cd -

echo
echo "Installing gtags..."
cd ~
wget -c "https://ftp.gnu.org/pub/gnu/global/global-6.6.2.tar.gz"
tar zxvf global-6.6.2.tar.gz
cd global-6.6.2
./configure
make -j4
sudo make install
cd -

echo
echo "Installing vim-plug then all plugins..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd ~
git clone https://github.com/super119/vim-adventures.git
cp vim-adventures/vimrc .vim

vim +PlugInstall +qall
rm -rf ctags global-6.6.2 global-6.6.2.tar.gz install-dependencies.sh vim vim-adventures
cd -
echo "Done."
