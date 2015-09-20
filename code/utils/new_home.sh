#!/bin/bash


# This script creates the structure for a new home
#  
#  
# It will create the HOME directory for you.
# The home directory has the following structure:
# - HOME:
# ----- config.defaults
# ----- config.d
# ----- tasks.d
# 
# Options:
# -h homePath           The path to the HOME directory to create
# -f                    fill the structure with some hello like examples
# 
# 


homePath=""
feed=0


while getopts :h:f opt; do
    case "$opt" in
        f) feed=1 ;;
        h) homePath="$OPTARG" ;;
    esac
done


abort() 
{
    echo "new_home: abort: $1"
    exit 1
}


# Check that homePath is specified
if [ -z "$homePath" ]; then
    abort "You must specify the HOME path with the -h option"
fi 



# Let's try to create the HOME directory first (see if we don't have perms problems)
mkdir -p "$homePath"
if ! [ 0 -eq $? ]; then
    abort "Could not create the HOME directory ($homePath)"
fi


# If we have made it so far, creating the basic structure should be straight forward
cd "$homePath"
mkdir -p config.d tasks.d
touch config.defaults


if [ 1 -eq $feed ]; then
    
    
    cat > tasks.d/hello.sh <<"DELIM"
#!/bin/bash


startTask "Hello"
echo "Hello $VALUE"
endTask "Hello"

DELIM

    cat > config.d/me.txt <<"DELIM"
hello:
project1=World!

DELIM
    
fi 

echo "new_home: done"

















