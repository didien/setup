#! /bin/bash
function show {
	echo -e $1
}

function install {
	sudo pacman -S $1 --noconfirm
}

function fetch {
	git clone $1
}

function fetch_r {
	git clone --recursive $1
}

show "========== Configuration =========="

show "-> Apply awesome config"
cp ./pref/rc.lua ~/.config/awesome

show "-> Pimp it"
fetch https://github.com/powerline/fonts
cd fonts
./install.sh
cd .. && rm -rf fonts
cp -r wallpapers ~

show "-> Configure session"
cp ./pref/.zshrc ~/.zshrc
cp ./pref/.xinitrc ~/.xinitrc
cp ./pref/.Xresources ~/.Xresources
cp ./pref/.vimrc ~/.vimrc

show "-> Set scripts"
cp -r scripts ~
show "/!\\ REMOVE DEFAULT WALLPAPER FROM THEME /!\\"

show "-> Enable docker"
sudo tee /etc/modules-load.d/loop.conf <<< "loop"
sudo modprobe loop
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER
newgrp docker

show "-> Generate RSA keys"
cat /dev/zero | ssh-keygen -b 4096 -q -N ""

show "-> Enable network manager"
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

show "-> Configure i3lock"
echo 1 | yaourt i3lock-fancy-git --noconfirm
