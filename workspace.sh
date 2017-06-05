#!/bin/bash
function workspace() {
	local DIR=~/.workspaces

	if [ ! -d $DIR ]; then
		mkdir $DIR
	fi

	__workspaceman_add() {
		if [ -f $DIR/.$1 ]; then
			echo "Workspace with this name already exists, overwrite? "
			select yn in "Yes" "No"; do
			    case $yn in
			        Yes ) break;;
			        No ) return 0;;
			    esac
			done
		fi
		pwd > $DIR/.$1
	}

	__workspaceman_delete() {
		if [ -f $DIR/.$1 ]; then
			rm $DIR/.$1
		fi
	}

	__workspaceman_list() {
		ls -A $DIR | grep ^\\. | sed s/\.//
	}

	__workspaceman_help() {
		echo "Workspace - A simple workspace manager for your terminal."
		echo ""
		echo "ADDING"
		echo "workspace --add [name]      add a workspace with name [name]"
		echo "workspace -a [name]"
		echo ""
		echo "DELETING"
		echo "workspace --delete [name]   delete the workspace with name [name]"
		echo "workspace -d [name]"
		echo ""
		echo "LISTING"
		echo "workspace --list            list all workspaces"
		echo "workspace -l"
		echo ""
		echo "HELP"
		echo "workspace --help            display help"
		echo "workspace -h"
		echo ""
		echo "SWITCHING"
		echo "workspace [name]            go to workspace [name]"
		echo "workspace                   go to last used workspace"
	}
	
	# Handle flags, getops breaks for functions
	if [ ! -z "$1" ] && [[ $1 =~ ^- ]]; then
		
		# Handle -a/--add flag
		if [ "$1" = "-a" ] || [ "$1" = "--add" ]; then
			# Second parameter is required
			if [ ! -z "$2" ]; then
				__workspaceman_add $2
			else
				echo "A name is required when adding a new workspace."
				return 1
			fi
			return 0

		# Handle -l/--list flag
		elif [ "$1" = "-l" ] || [ "$1" = "--list" ]; then
			__workspaceman_list
			return 0

		# Handle -h/--help flag
		elif [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
			__workspaceman_help
			return 0

		# Handle -d/--delete flag
		elif [ "$1" = "-d" ] || [ "$1" = "--delete" ]; then
			# Second parameter is required
			if [ ! -z "$2" ]; then
				__workspaceman_delete $2
			else
				echo "A name is required when deleting a workspace."
				return 1
			fi
			return 0
		fi

	# Handle all other commands (i.e, switching directory
	elif [ ! -z "$1" ] && [ -f $DIR/.$1 ]; then
		cd $(head -n 1 $DIR/.$1)
		cp $DIR/.$1 $DIR/.last_used 2> /dev/null
		return 0
	elif [ -f $DIR/.last_used ]; then
		cd $(head -n 1 $DIR/.last_used)
		return 0
	fi
	
	return 1
}
