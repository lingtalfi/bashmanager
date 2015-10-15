Install bashmanager
=========================
2015-10-15



This document describes the procedure to install the bash manager command on your machine,
and make it system wide available as the "bashman" command.
 
 
There are two steps:
 
- download the code 
- create the bashman command 

 

 
Download the code
-------------------------------

Download the basmanager code (or clone it) and put it in a directory of your choice.

 
 
Create the bashman command
-------------------------------


To make the bashman command system wide available, it needs to be in one of the directories listed in your PATH.
Assuming that /usr/local/bin is in your PATH, we will create a bashman symbolic link that points to 
the actual bash manager command, which is in the code directory.

```bash    
> ln -s /path/to/real/bashmanager/code/bashbash_manager.sh /usr/local/bin/bashman
``` 


Voilà.
Check your work:

```bash
> which bashman 
/usr/local/bin/bashman 
```
 