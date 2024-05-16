# Dotfiles

My current dotfiles managed with GNU stow.
You can either use the commands directly or let the provided makefile do it for you.

## Instructions

Clone this folder into your home directory.
On Debian/Ubuntu you can run `sudo make install` to install the used programs.
Run `make` to let stow create the syslinks.

The programms that are installed are:
vim, stow, lsd and zsh (which is then also set as the default shell)

## Uninstall
Run `make delete` to remove all links created.
E.g.: Should be done before renaming the folder.
