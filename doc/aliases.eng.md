Being more productive: creating command line alias
==================================================
2015-10-13




The bash manager command line can become wordy quite rapidly.
A solution for keeping a concise command line is to use aliases.



Locations 
-------------

Aliases are stored in files which reside in the following locations:

- ~/.bash_manager
- /etc/.bash_manager


The first file found only is used, meaning that if you have created the two mentioned aliases files,
the ~/.bash_manager file has precedence over the /etc/.bash_manager file.



The alias file structure
------------------------------

The abstract notation would be:


```
chanel[programName]:

    alias = aliasValue
    alias2 = aliasValue2
    ...

chanel2[programName2]:

    alias = aliasValue
    alias2 = aliasValue2
    ...
```


Indentation is not necessary, I added it for the sake of readability.
Also, spaces around the spaces symbol are not required.


chanel is equal to alias.
It might take other values in the future, that's because a .bash_manager is a general purpose 
config file for the bash manager, it's not JUST an alias file.


The programName is the name of your program.
Remember that you can change your program in different ways, the most common being to set it in the config.defaults file,
see the 
[task author cheatsheet](https://github.com/lingtalfi/bashmanager/blob/master/doc/task-author-cheatsheet.eng.md)
for more info.



Usage example
------------------

Imagine I create a ~/.bash_manager file with the following content:

```
alias[webWizard]:

    ddb = -t downloadRemoteDb -p 
    upsync = -t upsync -p 
    

```


Then, instead of typing this:


```bash
wwiz -t downloadRemoteDb -p sketch
```

(wwiz is my alias for a web wizard tool I'm working on now)

I could type this:

```bash
wwiz ddb sketch
```


Which is way much better, and glorifies the conciseness of the command line, I hope you will agree on this. 






