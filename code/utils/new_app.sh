#!/bin/bash


# This script creates the structure for a new bash manager based app.
#  
#  
# It will create the CODE directory for you. 
# The CODE directory contains two things:
# 
# - optionally the bash_manager_core-1.0.sh script  (or a link to the original bash_manager_core-1.0.sh script)
# - the HOME directory:
# 
# The home directory has the following structure:
# - home:
# ----- config.defaults
# ----- config.d
# ----- tasks.d
# 
# Options:
# -c CODEPath           The path to the CODE directory.
#                       It will be created if it doesn't exist.
#                       This option is mandatory.
# 
# -i                    imports the bash manager script into the CODE directory.
# -l (lowercase L)      if the bash manager script is imported, use a symbolic link rather than a copy.
# 
# 


codePath=""
importBashManager=0
useLink=0
bashManagerVersion="1.0"


while getopts :c:il opt; do
    case "$opt" in
        c) codePath="$OPTARG" ;;
        i) importBashManager=1 ;;
        l) useLink=1 ;;
    esac
done


abort() 
{
    echo "new_app: abort: $1"
    exit 1
}


# First let's check that we are inside the new_app.sh directory
#if ! [ "./new_app.sh" = "$0" ]; then
#    abort "You need to be inside the directory that contains new_app.sh to call it!"
#fi



# Then the codePath must be specified
if [ -z "$codePath" ]; then
    abort "You must specify the CODE path with the -c option"
fi 



# Let's try to create the CODE directory first (see if we don't have perms problems)
mkdir -p "$codePath"
if ! [ 0 -eq $? ]; then
    abort "Could not create the CODE directory ($codePath)"
fi



# One last thing: if the bash manager script is to be imported, 
# we need to find the path to the bash manager script
if [ 1 -eq $importBashManager ]; then
    cd $(dirname "$0")
    bashManagerProgramName="bash_manager_core-${bashManagerVersion}.sh"
    bashManagerPath="$(pwd)/../$bashManagerProgramName"
    
    if ! [ -f "$bashManagerPath" ]; then
        abort "Bash manager script not found: $bashManagerPath"
    fi 

fi

# If we have made it so far, creating the basic structure should be straight forward
cd "$codePath"
mkdir -p home/config.d home/tasks.d
touch home/config.defaults


if [ 1 -eq $importBashManager ]; then
    if [ 1 -eq $useLink ]; then
        if [ -f "$bashManagerProgramName" ]; then
            rm "$bashManagerProgramName"
        fi 
        ln -s "$bashManagerPath" "$bashManagerProgramName"
    else
        cp "$bashManagerPath" .
    fi 
fi 


echo "new_app: done"

















