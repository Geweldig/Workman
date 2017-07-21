if [ ! -d ~/.workspaces ]; then
	mkdir ~/.workspaces
fi
cp "workspace.sh" ~/.workspaces
cp "version" ~/.workspaces
cp "help" ~/.workspaces
if [ -f ~/.bashrc ]; then
	echo "source ~/.workspaces/workspace.sh" >> ~/.bashrc
fi
if [ -f ~/.zshrc ]; then
	if [ -d ~/.oh-my-zsh ]; then
		cp -r workspace ~/.oh-my-zsh/plugins
	fi
	echo "source ~/.workspaces/workspace.sh" >> ~/.zshrc
fi
