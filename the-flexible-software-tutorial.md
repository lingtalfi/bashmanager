The Flexible Software Tutorial
====================================
2015-09-21


The goal of this tutorial is to demonstrate the flexibility that any software created with bash manager automatically 
inherits.

This is an easy to follow tutorial, using the "copy paste observe" technique.
I assume that you have already completed at least the hello world tutorial from the [main documentation] (https://github.com/lingtalfi/bashmanager).
 


The flexibility of any Bash manager software comes from the fact that the tasks that compose your software can be assembled in 
many different ways, and using two mediums: the config file and the command line options.

In this tutorial, we will test and observe such power by invoking the software from the command line.
But before we can do that, we need to prepare the software first.

 
 
Creating the software 
---------------------------

The software we will be creating is totally abstract.
We will use dumb (boring) names so that you can better see the flexibility of the software (which is the goal of this tutorial).
 
Let's create 5 tasks to play with.

Create the following files (or download them from the code/tutorials/the-flexible-tutorial directory): 

- HOME/tasks.d/t1.sh
- HOME/tasks.d/t2.sh
- HOME/tasks.d/t3.sh
- HOME/tasks.d/t4.sh
- HOME/tasks.d/t5.sh


And put the following content in them:


```bash`

echo "$task: processing value $VALUE (project $project)"

````


Note: although I used them for this tutorial, I would not recommend to use the **non documented** $task and $project variables, unless you know where they come from.



Ok, so that was the hard part.
Now our software is created, we need to configure it.



Configuring the software
-----------------------------

I will assume that we have 3 clients, each client correspond to a project, and for each client we want to prepare a profile
in the configuration file.


Create the HOME/config.d/me.txt and put the following content in it:        
    
    
    t1:
    p1=123
    p2=456
    p3=789
    
    
    t2:
    p1=apple
    p3=cherry
    
    
    t3:
    p2=karate
    p3=
    
    
    t4:
    p1=square
    p2=oval
    
    
    t5:
    p1=red
    p2=green
    p3=blue




Now please take some time and try to guess what this configuration file does.

```
...
```



The configuration file defines 3 profiles, one per client.
Basically, this config file defines the default values that your software
will be using for each client.


Don't forget the config.defaults
-----------------------------

Finally create an empty HOME/config.defaults file.
It's required by the software (otherwise it complains).
We won't be using that file in this tutorial so don't bother about it.



Now, our software is fully functional, let's use it!



Using the software
-----------------------------

We first need to define the location of the HOME that we just created.
The HOME is actually what characterizes the software, and the bash_manager.sh script is just
the executive part of it.

The cool thing is that you can reuse the same bash manager script to execute any HOME,
and therefore focus on the task development (the hard part, remember?).


The best way to use a software is to create a specialized command, a wrapper, that would contain the 
absolute path to our HOME. Then we put this command in the PATH of our system and voilà! We can
use our command on that host machine.

Well, that was just a suggestion that you should seriously consider if you write software that 
will be used by others.

But for now, we will simply define the home location from the command line.
Our commands will be more verbose, but at least we can get started without further ado.

To define the home location from the command line, we need to use the -h switch.<br>
We also need to define the config file to use with the -c switch.<br>
This is actually **VERY VERY IMPORTANT** because otherwise, bash manager would execute all config files
found in the HOME/config.d directory (which is almost never what you want).

Let's try it and see what happens (of course, replace the paths by your own paths):


```bash
cd /path/to/bash_managers_parent_directory
./bash_manager.sh -h /path/to/our_softwares_home -c me
```

    
If you do it right, the output will be:


    t1: processing value 123 (project p1)
    t2: processing value apple (project p1)
    t4: processing value square (project p1)
    t5: processing value red (project p1)
    t1: processing value 456 (project p2)
    t3: processing value karate (project p2)
    t4: processing value oval (project p2)
    t5: processing value green (project p2)
    t1: processing value 789 (project p3)
    t2: processing value cherry (project p3)
    t3: processing value  (project p3)
    t5: processing value blue (project p3)



Since this is a long command to type already, type the following (unless you already have a bashman wrapper to the bash_manager.sh script):

```bash
alias bashman='./bash_manager.sh -h /path/to/our_softwares_home -c me'
```


Verify that you get the same output:

```bash
bashman
```

Output:

    t1: processing value 123 (project p1)
    t2: processing value apple (project p1)
    t4: processing value square (project p1)
    t5: processing value red (project p1)
    t1: processing value 456 (project p2)
    t3: processing value karate (project p2)
    t4: processing value oval (project p2)
    t5: processing value green (project p2)
    t1: processing value 789 (project p3)
    t2: processing value cherry (project p3)
    t3: processing value  (project p3)
    t5: processing value blue (project p3)
    
    

There are many things to observe:
    
- the projects are executed in order: first p1, then p2, and then p3    
- the tasks, in the scope of a project, are also executed in order of appearance in the HOME/config.d/me.txt config file    
- in our config file, we didn't set a assign project p2 to task t2, and indeed task t2 hasn't been executed for project p2    
- in our config file, we assigned project p3 with an empty value to task t3, and indeed task t3 has been executed with an empty value for project p3    
    

But the most important thing is to understand that by default, the bash manager script executes 
every project and every task it finds in the config file.




Now, let's leverage the command line and see how we can customize the software to our needs.
I will use a **recipe approach** for the rest of this tutorial.


    
#### Execute only task t1 of every project

```bash    
bashman -t t1
```    
    
Output:

    t1: processing value 123 (project p1)
    t1: processing value 456 (project p2)
    t1: processing value 789 (project p3)
    
    
    
    
#### Execute only task t1 and task t3 of every project

```bash    
bashman -t t1 -t t3
```    
    
Output:

    t1: processing value 123 (project p1)
    t1: processing value 456 (project p2)
    t3: processing value karate (project p2)
    t1: processing value 789 (project p3)
    t3: processing value  (project p3)
    
    
#### Execute only project p1

```bash    
bashman -p p1
```    
    
Output:

    t1: processing value 123 (project p1)
    t2: processing value apple (project p1)
    t4: processing value square (project p1)
    t5: processing value red (project p1)
    
    

#### Execute only project p1 and project p2

```bash    
bashman -p p1 -p p2
```    
    
Output:

    t1: processing value 123 (project p1)
    t2: processing value apple (project p1)
    t4: processing value square (project p1)
    t5: processing value red (project p1)
    t1: processing value 456 (project p2)
    t3: processing value karate (project p2)
    t4: processing value oval (project p2)
    t5: processing value green (project p2)
    
    
    
#### Execute only task t1 for project p1 and project p2

```bash    
bashman -p p1 -p p2 -t t1
```    
    
Output:

    t1: processing value 123 (project p1)
    t1: processing value 456 (project p2)
    
    
    
#### Execute only task t1 for project p1 and project p2, and change the value of task t1 to joker 

```bash    
bashman -p p1 -p p2 -t t1 --option-_VALUE_t1=joker
```    
    
Output:

    t1: processing value joker (project p1)
    t1: processing value joker (project p2) 
    
    
    
#### Execute only task t1 for project p1 and project p2, and change the value of task t1 to joker for project p1, and to rekoj for project p2 (woa, that's a damn long title) 

```bash    
bashman -p p1 -p p2 -t t1 --option-_VALUE_t1:p1=joker --option-_VALUE_t1:p2=rekoj
```    
    
Output:

    t1: processing value joker (project p1)
    t1: processing value rekoj (project p2)
    
    
    
    
If you realize that every software written with bash_manager inherits those command line options, and thus this flexibility, 
then you have successfully completed this tutorial, congratulations!
    
    
    
    


