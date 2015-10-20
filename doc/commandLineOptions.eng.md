Command line options
==================================================
2015-10-14




Any bash manager software inherits the following command line options.




-c configPath:

    adds a user config file to parse.
    It can be used multiple times.
    configPath is a relative path, relative to HOME/config.d directory.
    The .txt extension must not be specified.
    If the -c option is not set, all config files located in config.d will be used (this is probably not what you want).


-h home:
 
    sets the HOME path. 
    
        
-p project:

    adds a project to parse.
    It can be used multiple times.
    
    By default, if you don't specify a project, bashmanager will execute all 
    the projects that it finds.
    
    As of version 1.06, if you don't want to use a project, but just use a task and providing your own options for instance,
    you can use the special _none_ value
    
    
    
-s:

    set the STRICT_MODE flag to 1.
    If STRICT_MODE=1, your software will quit at the first error encountered.
    
-t task:

    adds a task to parse.
    It can be used multiple times.
    
-v:

    set the VERBOSE flag to 1.
    If VERBOSE=0, the log and warning calls do nothing.
    If VERBOSE=1, the log and warning calls output to STDOUT.
    
-vv:

    set the VERBOSE flag to 2.
    At this level, the bash manager core script details what it is doing.
    
    
--option-key=value:
   
   
    set an entry in the CONFIG array, with the given key and value.
    
    Can also be used to override a specific task's value, globally, or for a project in particular.
    To override a task's value, your key must have the following format: 
    
        key: <_VALUE_> <taskName> <:project>?
    
    For instance if I want to set the value of a task named depositories to /tmp/mydepo and for all projects,
    you can use the following option:
        
            --option-_VALUE_depositories=/tmp/mydep
            
    Now if you want to restrict this assignment to the project martin only, you can use the following:                
    
            --option-_VALUE_depositories:martin=/tmp/mydep
    
--option-key value:

    As of version 1.07
    Same as --option-key=value
    
