all:
	stow --verbose --target=$$HOME --restow .

delete:
	stow --verbose --target=$$HOME --delete .

apt_install:
	apt install stow
	apt install lsd
	mkdir -p ~/.vim/.backup
	mkdir -p ~/.vim/.swp
	mkdir -p ~/.vim/.undo
	apt install vim
	apt install zsh
	chsh -s $(which zsh)
