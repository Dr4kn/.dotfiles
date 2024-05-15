all:
	stow --verbose --target=$$HOME --restow .

delete:
	stow --verbose --target=$$HOME --delete .

apt_install:
	apt install stow
	apt install lsd
	apt install vim
