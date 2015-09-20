#!/bin/bash





startTask "Hello"
echo
echo
echo
echo "Hi, we are now inside the hello task!"
echo "Obviously, this task doesn't do much, but it gives a basic idea of how tasks are implemented."
echo "Every task has access to at least three variables:"
echo " - VALUE, the specific value for this task (in the config file)"
echo " - CONFIG, an array of configuration values, created using the HOME/config.defaults file"
echo "         and the command line options (--option-myKey=myValue)"
echo " - OTHER_VALUES, an array containing all the task's values for this project (for the current config file)."
echo "         So that task can see each other's values if necessary"

echo 
echo "Here are what those variables look like in the hello task:"
echo "VALUE:"
echo "-- $VALUE"
echo "CONFIG:"
for k in "${!CONFIG[@]}"; do
    echo "-- $k=${CONFIG[$k]}"
done
echo "OTHER_VALUES:"
for k in "${!OTHER_VALUES[@]}"; do
    echo "-- $k=${OTHER_VALUES[$k]}"
done


echo
echo
echo "Please feel free to edit the HOME/config.defaults file and the HOME/config.d/hello.sh file and"
echo "observe the change in the output."
echo "Then you should feel ok to create your own tasks ;)"



echo
echo
echo
endTask "Hello"
 
 