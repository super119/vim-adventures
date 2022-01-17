#!/bin/bash
echo
echo "This script will remove the entire \$HOME/.vim folder."
read -p "Go? (Y/n): " ANS
if [ "$ANS" != "" ] && [ "$ANS" != "y" ] && [ "$ANS" != "Y" ] ; then
	exit 0
fi

tmpdir="$(mktemp -d vim-uninstall-dep-XXXX)";
if [ ! -d "${tmpdir}" ]; then
	echo "Error: Create temporary directory failed.";
	exit 1;
fi;

pushd "${tmpdir}" >& /dev/null
echo
echo "Uninstalling gtags..."
wget -c "https://ftp.gnu.org/pub/gnu/global/global-6.6.8.tar.gz"
tar zxvf global-6.6.8.tar.gz
cd global-6.6.8
./configure --prefix=$HOME/.local
sudo make uninstall
popd >& /dev/null

pushd "${tmpdir}" >& /dev/null
echo
echo "Uninstalling vim..."
git clone https://github.com/vim/vim.git
git checkout -b v8.2.4103 v8.2.4103
cd vim
./configure --prefix=$HOME/.local --enable-pythoninterp=yes --enable-python3interp=yes
sudo make uninstall
popd >& /dev/null

sed -i "/export PATH=\$HOME\/.local\/bin:\$PATH/d" ~/.bashrc
sed -i "/alias vi=/d" ~/.bashrc

rm -rf "${tmpdir}"
rm -rf ~/.vim

echo "Done."
