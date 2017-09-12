# Install Notes
Simply run the install script. This copies all the necessary files and adds sourcing to your bashrc and/or zshrc.

If you have oh-my-zsh you can use the auto-complete plugin. This plugin is automatically copied at install. You simply need to add the plugin "workspace" to your list of plugins in your zshrc.

# Usage
- `workspace -a/--add NAME`: Adds the current directory as a workspace with the name NAME.
- `workspace -d/--delete NAME`: Removes the workspace with the name NAME.
- `workspace -l/--list`: List all workspaces.
- `workspace -w/--which NAME`: Show workspace directory.
- `workspace -h/--help`: Display the help.
- `workspace -v/--version`: Display the version.
- `workspace NAME`: Go to workspace NAME.

