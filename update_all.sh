#!/bin/sh
##This bash file can update all git project in given directory

#in case this file being invoked form other path
base_dir=$(dirname "$0")
#a tool script for colorful output
. $base_dir/color
cd $base_dir

#read given directory as repositories directory,
#or current directory
project_dir="."
if [ ! -z $1 ]
then
	project_dir=$1
fi

if [ ! -d $project_dir ]
then
	error "$project_dir is not a directory."
	exit 1
fi

info "Set repository base directory to $project_dir"

for project in `ls $project_dir`
do
	if [ -d $project ]
	then
		cd $project
		#update git repository
		if [ -d '.git' ] 
		then
			info "Updating project:$project"
			git pull
			info "Done."
			echo
		#update svn repository
		elif [ -d '.svn' ]
		then
			info "Updating project:$project"
			svn update
			info "Done."
			echo
		else
			info "$project is not a repository.\n"
		fi
		cd ..
	fi
done
exit 0
