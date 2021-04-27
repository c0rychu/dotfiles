.PHONY: backup

backup:
	cp ~/.vimrc ~/dotfiles/
	cp ~/.tmux.conf ~/dotfiles/

install:
	-mv ~/.vimrc ~/.vimrc.bk.$(shell date +%Y_%m_%d_%H%M%S)
	-mv ~/.tmux.conf ~/.tmux.conf.bk.$(shell date +%Y_%m_%d_%H%M%S)
	cp ~/dotfiles/.vimrc ~/.vimrc 
	cp ~/dotfiles/.tmux.conf ~/.tmux.conf

