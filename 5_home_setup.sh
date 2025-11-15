#!/bin/sh

echo "Backup directory to restore user settings from?"
read backup_dir

# Copy backup files
pushd $backup_dir
cp -a .config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
cp -a .bash_history ~/
cp -a .bash_profile ~/
cp -a .bashrc ~/
cp -a .git ~/
cp -a .gitconfig ~/
cp -a .gitignore ~/
cp -a .gnupg ~/
cp -a .mozilla ~/
cp -a .profile ~/
cp -a .ssh ~/
cp -a .tmate.conf ~/
cp -a .tmux* ~/
~/.tmux/plugins/tpm/bin/install_plugins
# Install vinimum
git clone git@github.com:spastorino/vinimum.git ~/.vim
cp .vimrc.* ~/
ln -s ~/.vim/vimrc ~/.vimrc
vim +PlugInstall +UpdateRemotePlugins +qa

cp RustConf-2020-Desktop-Background.png ~/.local/share/backgrounds/
cp -a keybase ~/.config
cp mimeapps.list ~/.config
cp monitors.xml ~/.config
mkdir .config/pip
cat <<EOT > .config/pip/pip.conf
[global]
break-system-packages = true
EOT
sudo cp icons/santiago /var/lib/AccountsService/icons/santiago
sudo cat <<EOT > /var/lib/AccountsService/users/santiago
[User]
Session=
Icon=/var/lib/AccountsService/icons/santiago
SystemAccount=false
EOT
popd
