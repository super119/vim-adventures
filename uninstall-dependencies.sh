#!/bin/bash
echo
echo "This script is supposed to run individually."
echo "I.E: please do NOT run it in 'vim-adventures' repository folder."
echo
echo "This script will remove the entire $HOME/.vim folder."
read -p "Go? (Y/n): " ANS
if [ "$ANS" != "" ] && [ "$ANS" != "y" ] && [ "$ANS" != "Y" ] ; then
	exit 0
fi

echo
echo "Uninstalling gtags..."
cd ~
wget -c "https://ftp.gnu.org/pub/gnu/global/global-6.6.8.tar.gz"
tar zxvf global-6.6.8.tar.gz
cd global-6.6.8
./configure --prefix=$HOME/.local
sudo make uninstall
cd -

echo
echo "Uninstalling vim..."
cd ~
git clone https://github.com/vim/vim.git
git checkout -b v8.2.4103 v8.2.4103
cd vim
./configure --prefix=$HOME/.local --enable-pythoninterp=yes --enable-python3interp=yes
sudo make uninstall
cd -

sed -i "/export PATH=\$HOME\/.local\/bin:\$PATH/d" ~/.bashrc
sed -i "/alias vi=/d" ~/.bashrc

cd ~
rm -rf global-6.6.8 global-6.6.8.tar.gz vim
rm -rf .vim
cd -

echo "Done."
