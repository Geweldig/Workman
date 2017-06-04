#!/bin/bash
function workspace() {
	local DIR=~/.workspaces

	if [ ! -d $DIR ]; then
		mkdir $DIR
	fi

	__workspace_man_add() {
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

	__workspace_man_delete() {
		if [ -f $DIR/.$1 ]; then
			rm $DIR/.$1
		fi
	}

	__workspace_man_list() {
		ls -A $DIR | grep ^\\. | sed s/\.//
	}
	
	# Handle flags, getops breaks for functions
	if [ ! -z "$1" ] && [[ $1 =~ ^- ]]; then
		
		# Handle -a/--add flag
		if [ "$1" = "-a" ] || [ "$1" = "--add" ]; then
			# Second parameter is required
			if [ ! -z "$2" ]; then
				__workspace_man_add $2
			else
				echo "A name is required when adding a new workspace."
				return 1
			fi
			return 0

		# Handle -l/--list flag
		elif [ "$1" = "-l" ] || [ "$1" = "--list" ]; then
			__workspace_man_list
			return 0

		# Handle -d/--delete flag
		elif [ "$1" = "-d" ] || [ "$1" = "--delete" ]; then
			# Second parameter is required
			if [ ! -z "$2" ]; then
				__workspace_man_delete $2
			else
				echo "A name is required when deleting a workspace."
				return 1
			fi
			return 0
		fi

	# Handle all other commands (i.e, switching directory
	elif [ ! -z "$1" ] && [ -f $DIR/.$1 ]; then
		cd $(head -n 1 $DIR/.$1)
		return 0
	fi
	
	return 1
}
