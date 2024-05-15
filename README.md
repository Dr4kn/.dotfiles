# Dotfiles

My current dotfiles managed with GNU stow.
You can either use the commands directly or let the provided makefile do it for you.

## Instructions

If you want to use zsh you have to set it as your Shell manually.

Clone this folder into your home directory.
On Debian/Ubuntu you can run `sudo make install` to install the used programs (this includes stow).
Run `make` to let stow create the syslinks.

## Uninstall
Run `make delete` to remove all links created.
E.g.: Should be done before renaming the folder.
