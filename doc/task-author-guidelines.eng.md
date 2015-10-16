Task Author Guidelines
===========================
2015-09-21




In this document, we discuss the basic guidelines for writing tasks.<br>
Those guidelines are just suggestions for task authors, they are conventions rather than strict rules.
 
 
 
 
Wrap your code with startTask and endTask
---------------------------------------------
 
Visual coherence is appreciable.

When you are running your program in the interactive shell, and the debug mode is on,
it's always nice to have some clean and well organized output.

The startTask and endTask functions help doing that.<br>
They provide visual separators indicating when your task starts and ends. 

Here is a sample code:

```bash

startTask myTask

# your code here

endTask myTask


```

 


Use the error, log and warning functions
---------------------------------------------

For error handling, consider using the error, log and warning functions.<br>
Those 3 core functions are all what you need to handle the errors and inform the interactive user of what's going on.<br>
Here is how and when you should use them:

- error:
   
        should be used when a task's author expectation is not met.
        For instance, if a variable is supposed to be initialized, but is actually not initialized, then
        it's a case where using the error function is appropriate.
        The error function is a way to indicate that a task could not complete as expected.
        
        The error message goes to STD_ERR.
        
        void    error ( msg )
        
        
        
- log:
   
        it displays a message to STD_OUT.
        It's meant to help debugging while working with the interactive console.
        Write the important expected things that your task is supposed to do.
        

        void    log ( msg )

- warning:
   
        like the log function, but is used to state a non optimal condition.
        
        For instance, imagine that you write a software that creates an ID card.
        It takes the identity of the user and prints its to the output.
        The task needs two parameters from the user: the first name and the last name.
        If the first name is empty (the user left it blank), you could use a warning.
        
        Warning are never critical, they won't stop the task.
        
        
        void    warning ( msg )
        

By convention, the message parameter passed to the error, log and warning functions should start with the task's name
followed by a colon and a space, like this:

```bash
# using the log function
log "myTask: secret file transferred."

# using the warning function
log "myTask: the user's first name is empty!"

# using the error function
log "myTask: file not found: ${filePath}"
```
        
        
        
        
Do not exit
------------------
        
Never put an exit statement in your bash task, this would prevent other tasks from being executed.
If you use a foreign script, you can safely exit, because foreign scripts are called in their own processes.





Handle the case of the empty task value
------------------------------------------

Some task don't require value, they just need to be called.
Some other tasks require a (per project) task value and cannot work without it.

As of version 1.06, it is possible to execute a task without specifying a project,
which basically means that any task can be called without a value specified.

Therefore, task authors should always handle the case where an empty value is passed to their task.
In a task where the value is required, this would probably mean skip the task without triggering a warning or an error.



Php task authors, use the phpManager plugin
------------------------------------------------

If you are comfortable with php, you should look at the 
[phpManager plugin](https://github.com/lingtalfi/bashmanager_plugin_phpmanager),
which make developing tasks with php easier.
        
                                        









