Task Author Cheatsheet
===========================
2015-09-21



        
Bash manager task author's cheatsheet.


functions:

- error ( message ) : sends a message to STDERR, exit only if STRICT mode is on (-s option)
- log ( message ): sends a message to STDOUT, only if VERBOSE mode is on (-v option) 
- warning ( message ): like log, but the text color is orange
- startTask ( taskName ): uses log to display a visual start separator 
- endTask ( taskName ): uses log to display a visual end separator
    

variables:

- VALUE 
    
        string: contains the task's value for the project. Can be empty.
    
    
- OTHER_VALUE
    
        associative array: contains the other task's values for the current project. 
                        
                        OTHER_VALUE[taskName]=value
                        
- CONFIG
    
        associative array: contains the key/value pairs from HOME/config.defaults, plus
        the options set via the command line (--option-key=value).
        Also contains some special values added by the bash manager:
                
                    CONFIG[_HOME]: path to the application's home
                    CONFIG[_VALUE]: the current task's value for the current project
                    
        To override the task's value from the command line, you can use the --option-key=value format,
        but your key must have the following format: 
        
            key: <_VALUE_> <taskName> <:project>?
        
        For instance if I want to set the value of a task named depositories to /tmp/mydepo and for all projects,
        you can use the following option:
            
                --option-_VALUE_depositories=/tmp/mydep
                
        Now if you want to restrict this assignment to the project martin only, you can use the following:                
        
                --option-_VALUE_depositories:martin=/tmp/mydep
                        
        
                    
                    
- CONFIG_OPTIONS
    
        associative array: contains only the options set via the command line with the format --option-key=value  
           
                    
                    
config.defaults
--------------------
                    
### Set the program name
   
```
_program_name=myProgram
```                    
                    