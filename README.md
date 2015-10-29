Bash Manager
==================
2015-09-20



What is it?
------------------------


Bash manager is a mini framework for creating simple command line utilities (called softwares in this document).<br> 
It's written in bash 4. 
 
 
 
 
 
 
 
Features
------------------------ 

- simple conception (easy to learn)
- readable configuration file
- separation of concerns: you can focus on developing the utility
- automatic handling of the command line options 
- use of presets (save a lot of command line options typing) 
- support for different scripting languages: bash, php, python, perl, ruby or java  



Who is using it?
--------------------

Bash manager is used in the following projects:

- [Webmaster Wizard]( https://github.com/lingtalfi/webmaster-wizard )




Requirements 
-----------------

You need to have bash 4+ available in your machine.
 

 
How does it work?
------------------------


The software's structure is shown on figure 1.

![Bash manager structure](https://github.com/lingtalfi/bashmanager/blob/master/doc/images/bash-manager-structure.jpg "Bash manager 
structure")


A software consist of three parts:
 
- the core
- the config 
- the tasks    


The **core** is the part that the user communicates with when she wants to execute your software.

The **config** contains default parameters for your tasks.


The **tasks** are the functional steps that your software needs to execute in order to satisfy the 
user's request.<br>
For instance, if we wanted to construct a simple backup tool, our tasks could be the following:
 
- A: create an archive (.tar) of an application 
- B: create a dump of the database 
- C: create a tarball (.tar.gz) containing the archive and the dump  
- D: move the tarball in a given directory 


In this case you would have to create the four tasks: A, B, C and D.
Tasks are simple scripts (just like the core).<br>
However, you can write tasks in bash, php, python, ruby, perl or java if you want to.


#### Tasks order matters

From the example above, you can probably see that the order in which the tasks are executed is important.
That is, you can't move a tarball if it's not created for instance.

#### Selecting the right tasks 

You might also have guessed that some tasks might not apply equally for every user.
For instance, if the user's application doesn't use a database, then she doesn't need to execute task B.

Bash manager provides two mechanisms for handling this situation:
- the user can choose to execute only task A, C and D (skipping task B) directly from the command line options (provided
 by bash manager).
- the software author (you) can define a preset called ACD (for instance), that the user can easily call with one 
option (-p ACD in this case).
        

#### Passing parameters 

One more thing that you might have guessed: some tasks will require parameters (for instance task B requires the 
credentials and the name of the database).

Parameters can be passed either via:
- the options of the command line (when you invoke the software)
- a config file

In this particular case of the database credentials, it might actually be wiser to create user profiles 
(presets) in the configuration file, since the command line options might be more exposed, but that's just a 
particular case. 



That's it for the big picture.
From now on, you should be able to decide whether or not bash manager could help you.
If that's the case, please proceed with the next sections.






THE BIG TUTORIAL
------------------------

In the next sections, you will learn how to master **bash manager** and how to create simple software with it.<br>
To complete this tutorial, you need some basic bash skills.

We will start by a little bit of theory, just the basics so that you have a better understanding of the different 
concepts used by bash manager.

Then you will get your hands dirty with three tutorials:

- the famous [hello world tutorial](#user-content-hellotut) 
- the [flexible software tutorial] (https://github.com/lingtalfi/bashmanager/blob/master/the-flexible-software-tutorial.md), to understand the flexibility of a bash manager software 
- a [photoTouch tutorial](#user-content-phototut), for those who really want to master bash manager
 
 
I also added a [Task Author's Guideline]( https://github.com/lingtalfi/bashmanager/wiki/Task-Author-Guidelines ) document just in case, 
and an useful [Task Author Cheatsheet]( https://github.com/lingtalfi/bashmanager/wiki/Task-Author-Cheatsheet ).
 
 
Happy learning. 
 
 
 
 
 
 

Big tutorial intro
-------------------------------------------
2015-09-13

With the Bash manager framework, you will create software which interface is the command line.
You can also run your software in the background, like any unix command.


In the next sections of this document, you will find the information necessary to create a software 
using the Bash manager framework and to run your software from the command line.




Running your software
----------------------------

### Bash manager's command line options


Bash manager's command line options are described in the 
[command Line Options](https://github.com/lingtalfi/bashmanager/blob/master/doc/commandLineOptions.eng.md) 
document



Creating a software
------------------------

### Overview of the bash manager framework's concepts

- Software:

        This is what you will be creating.
        It's basically a command line tool.
        
        As its core, a software is a sequence of tasks executed in
        a given order.
        
        When an user calls your software, she can specify which project
        she wants to execute.
        
        You, as the software author, are in control of which tasks are 
        executed depending on the project.
        
        The bash manager takes care of the command line options of 
        your software.
        
        
- Task:

        A task can be seen as the functional unit of your software.
        
        Writing a task is the only thing that the Bash manager cannot do for you.
        It's personal, and depends on what you want your software to achieve.
        
        To write a task, you will need to create a script.
        You can write the script in any scripting language that you want (php, bash, python, ruby, ...).
                                  
                          
- Project:

        The users of your software work with their own projects.
        The term project here refers to their projects.
        
        For instance, for a webmaster, a project could be a website.
        
        When the user calls your software, she wants a job to be done for 
        a given project, or a set of projects.
        When you write a software using the Bash manager framework, your 
        application automatically inherits the command line options that let
        the user choose which project to execute (amongst other things).
        
- Config files:

        When a user calls your software, she can always choose any 
        combination of config files, projects and tasks.
        
        A config file allows you to create presets of those calls.
        By using config files, you spare a lot of typing to your users.
        
        Connexions between projects and tasks are done via the config files.
        

                                          
                          
        
        
### The software's HOME directory


Every Bash manager software has the same structure, contained in a so-called **HOME** directory.



    - HOME                              # this directory contains all the files of your application                                          
    ----- config.defaults               # this is a global configuration file for every projects
    ----- config.d                      # this directory contains the configuration files (usually one is enough)
    --------- my.conf.txt
    --------- john_doe.txt
    ----- tasks.d                       # this directory contains the available tasks of your software 
    --------- implementation_specific_task.sh
    --------- implementation_specific_task_two.sh
    --------- implementation_specific_task_three.py
    --------- implementation_specific_task_four.php
 
     
Tip: You don't have to create this structure by hand, the Bash manager framework provides an utility
    in code/utils/new_home.sh that creates this structure for you. 
    
    
    
    
           
### A config file example
 
Let's open a config file and see what we have:
 
 
    prepare:
    p1=&/tmp/images&/tmp/processed_images_p1
    p2=&/tmp/images&/tmp/processed_images_p2
    
    
    rename_php:
    p1=cat_{number}.{extension}

    
    resize:
    p1=w350h250
    p2=w500
    
    
    
This is an example from the tutorial that we'll be doing in a few moments.    
We can see that there are three sections: prepare, rename_php, resize.
Each section represents a task.
Each section has some lines assigned to it.
A section line has the following format:

    key=value    

The key represents the name of an user's project,
and the value is an arbitrary configuration value.

We can see that there are currently two projects in use: p1 and p2.






### How is the config file processed

When the Bash manager script processes this config file, it processes one project
at a time, until all projects have been processed.
 
This means that for the config file shown in the previous section, the thread of 
execution would look like this:
 
 
- processing project p1 

    - execute prepare task with value:      &/tmp/images&/tmp/processed_images_p1
    - execute rename_php task with value:   cat_{number}.{extension}
    - execute resize task with value:       w350h250

- processing project p2
 
    - execute prepare task with value:      &/tmp/images&/tmp/processed_images_p2
    - execute resize task with value:       w500



Tip: if a task's name begin with an underscore (in the config file), it's skipped.




        
                     
### the config.defaults file 
        
If all your projects share common configuration settings,
you can put them in the HOME/config.defaults file, using the following format:

    key1=value1
    key2=value2
    ...

This will populate the CONFIG array like this:

    CONFIG[key1]=value1
    CONFIG[key2]=value2
    ...
    
Note:
    The CONFIG keys set via the command line interface (--option-key=value) will override 
    the values of the config.defaults in case of conflict.
    
            


Ok.
So now, I'm a big fan of learning by doing, so rather than being too theoretical (and boring) here,
the next two sections will be tutorials.
 
The first tutorial is a hello world, for people in a hurry who wants to get something out of 5 minutes of time.
The tutorial is straight forward and few explanations are given.
It helps getting a basic sense of how to create a Bash manager software.
 
  
The second tutorial is for people who like to learn. It's a step by step process with more detailed explanations 
that will take you from a beginner to a real software author.
In this tutorial, we learn how to create a simple rename/resize images application.
 
 
<h2 id="hellotut">Hello tutorial: show me the simplest software ever!</h2>



Alright.
In this tutorial we are going to create a software that prints "Hello myName", myName being a variable.
 
The first thing to do is to create the software's HOME.
We will put our home in /tmp/helloHome.
The HOME structure has been explained in the "The software's HOME directory" section if you need a refresher.
 
Let's create the structure.
Type the following commands:
 
```bash    
> mkdir -p /tmp/helloHome/tasks.d               # creating the tasks directory       
> mkdir -p /tmp/helloHome/config.d              # creating the config directory
> touch /tmp/helloHome/config.defaults          # creating the global configuration file
> touch /tmp/helloHome/config.d/myconf.txt      # creating our config file
> touch /tmp/helloHome/tasks.d/hello.sh         # creating the hello task, it does not need execute right
```


        
From now on, I will use the word HOME to refer to /tmp/helloHome.
                             
Now let's create the hello task.
Open the HOME/tasks.d/hello.sh file in it and put the following content in it:

```bash    
echo "Hello $VALUE"
```    
    

Our task is available, but it won't be executed unless we assign a project to it.
Let's assign a project named p1 to the hello task.
Open the HOME/config.d/myconf.txt config file, and put the following content in it:
 
 
    hello:
    p1=World!     
 
 
We've just assigned the value "World!" to the hello task for the project p1.
We are now ready to test our application.

Go to the directory that contains the bash manager script (bash_manager.sh),
ensure it has the execute the permission,
then type the following command to launch the application:

```bash    
> ./bash_manager.sh -h /tmp/helloHome
Hello World!
```



That's the end of this tutorial.
I told you it would only take only 5 minutes.

So now, if you want to learn more, I invite you to complete the next tutorial.




<h2 id="phototut">Learning Bash manager: The photoTouch tutorial</h2>


Hi friends.
In this tutorial, we create a software that we could use in real life.
The software is called photoTouch, and it renames/resizes some photos from a directory.

This tutorial will be enlightening for a beginner.
After that tutorial, you will have all the knowledge necessary to create your own softwares.


I'll assume that you know nothing except a little bit of bash, and basic unix commands (set the execute permission
to a script). 
At some point, I'll demonstrate that we can use other scripting languages, and I'll be using a 
php script, so if you know php, good for you.




### Let's talk about our application

The software will be renaming and resizing images.
The first thing we don't want to do is modify the original images.
Therefore, the software will use two directories:
 
- images_src: a source directory that contain the original images.
- images_dst: a destination directory that will contain the processed (renamed and/or resized) images 


The strategy that our software will use is:

- 1. copy the images from the images_src directory to the images_dst directory.
- 2. Work only with the images inside the images_dst directory.


We will divide the actions of the software in three tasks:
 
- prepare 
- rename 
- resize 



The prepare task will always be the first task to be executed.
It's responsible for copying the images from the images_src directory to the images_dst directory.
It's also responsible for ensuring that the other tasks (rename and resize) know the location of those directories.

The rename task will rename the images located in the images_dst directory.
The resize task will resize the images located in the images_dst directory.



### Creating the bashman command

For the rest of this tutorial, we will call the Bash manager script by typing bashman (instead of /path/to/bash_manager.sh).
To do that, we need to create a symbolic link named bashman, accessible from our PATH, and that points to the real Bash manager script. 

In order to do that, type the following command (adapt the real path to the Bash manager script):

```bash    
> ln -s /path/to/real/bash_manager.sh /usr/local/bin/bashman
``` 



### Creating the software HOME

Every Bash manager script has a HOME.

In this tutorial, my HOME will be /tmp/photoTouch, so that you can just copy/paste the commands I will type.

The drawback, as you might know, is that the /tmp directory is emptied at when your machine reboots.
Therefore, if you want to save your work, copy your HOME somewhere else before your turn off your computer.


Let's create the HOME.
Type the following commands:
 
 
```bash     
> mkdir -p /tmp/photoTouch/tasks.d               # creating the tasks directory       
> mkdir -p /tmp/photoTouch/config.d              # creating the config directory
> touch /tmp/photoTouch/config.defaults          # creating the global configuration file
> touch /tmp/photoTouch/config.d/myconf.txt      # creating our config file
> touch /tmp/photoTouch/tasks.d/prepare.sh       # creating the prepare task, it does not need execute right
> touch /tmp/photoTouch/tasks.d/rename.sh        # creating the rename task with bash, it does not need execute right
> touch /tmp/photoTouch/tasks.d/resize.sh        # creating the resize task, it does not need execute right
```        
        
From now on, I will use the word HOME to refer to /tmp/photoTouch.

Tip: 
    the Bash manager framework provides a tool named new_home.sh that creates a basic home structure for you.
    We can use it like this:
    
```bash        
> /path/to/bashmanager/utils/new_home.sh -h /tmp/photoTouch         # creates a basic home structure
> /path/to/bashmanager/utils/new_home.sh -h /tmp/photoTouch -f      # creates a basic home structure, and adds an example hello task
```


### Creating the assets

To test our software, we will be using some photos of cats (no particular reason).
We will create a source directory that will contain our original photos of cats.

Type the following commands (or download any other images by yourself):

```bash    
> mkdir /tmp/images
> cd /tmp/images
> wget http://www.cats.org.uk/uploads/images/pages/photo_latest14.jpg \
http://i.dailymail.co.uk/i/pix/2014/10/06/1412613364603_wps_17_SANTA_MONICA_CA_AUGUST_04.jpg \
http://cl.jroo.me/z3/1/x/8/d/a.baa-One-very-cute-little-cat.jpg \
https://pbs.twimg.com/profile_images/447460759329460224/mt2UmwGG_400x400.jpeg \
http://hellogiggles.hellogiggles.netdna-cdn.com/wp-content/uploads/2015/07/05/maxresdefault-500x375c.jpg \
http://pad1.whstatic.com/images/thumb/e/ee/How-to-draw-anime-cats-Step-8.jpg/540px-How-to-draw-anime-cats-Step-8.jpg \
https://dq1eylutsoz4u.cloudfront.net/2014/10/sf-cat.jpg \
http://fora.mtv.ca/wp-content/uploads/2012/09/catsofinstagram.jpg \
http://i.ytimg.com/vi/2l_PmSOreGc/hqdefault.jpg \
http://www.rogerwehbe.com/wp-content/uploads/2014/12/unnamed.png \
http://img11.deviantart.net/1bcd/i/2010/244/e/4/happy_cat_by_geardupfritz-d2xspdk.jpg
```


If the downloads doesn't work (links not found), you basically can put any photos that you want,
it doesn't matter.
We just need to have some pictures to work with.



### Creating the config file


Open the HOME/config.d myconf.txt config file and put the following content in it:



 
    prepare:
    p1=&/tmp/images&/tmp/processed_images_p1
    p2=&/tmp/images&/tmp/processed_images_p2
    
    
    rename:
    p1=cat_{number}.{extension}

    
    resize:
    p1=w350h250
    p2=w500
    
    

Let's take a look at this config file.    
We can see the three sections, one for each task: prepare, rename_php, resize.
Each section contains some lines in it.
Each line has the same format, which is:
    
    projectName=value
        
We can see that this config file uses two projects named p1 and p2.

It's important to understand that every time you add a line to a task section, you 
actually assign a project to a task, with an arbitrary value.
It's that easy to do branching of projects with tasks using the config file.


Although very readable, this system has a drawback: the arbitrary value associated with 
a project for a given task has to fit on one line.
That's a pretty serious limitation, but with a little bit of imagination, there is always a way around.


Now, let me explain the meaning of the values for each task.
Understand those values is necessary before we code the actual tasks.


#### The prepare task's value

The prepare task needs to know the location of the images_src directory and the location of the 
images_dst directory.

Because we have more than one information here, I'll be using a special format provided by the
Bash manager framework.

The format is a little bit complex, but it's perfectly adapted for our case.
The abstract form of that format is:

    <delim> <var> (<delim> <var>)*
    
In our case, we know that we only need two variables, so we will use this format:

    <delim> images_src <delim> images_dst
    
In this line in particular: 
    
    p1=&/tmp/images&/tmp/processed_images_p1
        
in turns out that the delimiter is the ampersand symbol (&).
But if my path contained an ampersand symbol, I can change the delimiter to any char.
         
Visual spaces around the <delim> are allowed but the very first char of the value
must be the delimiter.


I could have used any other format,
the important thing is that the value for the prepare task contains two variables: images_src and images_dst.



#### The rename task's value

The value of the rename task looks like this: 

    cat_{number}.{extension}

For this tutorial, I have decided that this string would contain the following tags:

    - {number}: will be replaced by the current number of the image being processed, starting at 1
    - {extension}: will be replaced by the extension of the current image being processed
    
  


#### The resize task's value

The value of the rename task looks like one of the following values: 

    - w350h250
    - h250
    - w420
    
There are three possible formats:
    
    - w{number}        
    - h{number}        
    - w{number}h{number}        
    
The number indicates the maximum number of pixels for a given dimension (width or height).
Our resize task will transform the images so that they occupy the maximum space possible,
according to the restrictions that we give to it, preserving the ratio in all cases.

In other words, it will be able either to scale up an image, or to shrink down an image.

    

    
Now that we know more about the different tasks' values, let's code the tasks.



### Creating the prepare task

Let's start with the prepare task.
Open the HOME/tasks.d/prepare.sh task and put the following content in it:



```bash
#----------------------------------------
# GOALS
#----------------------------------------
# - set CONFIG[images_src]
# - set CONFIG[images_dst]
# - create the images_src directory
# - create the images_dst directory
# - copy images from images_src to images_dst
#----------------------------------------



startTask "Prepare"

splitLine "$VALUE" "&" "images_src" "images_dst"
if [ 1 -eq $? ]; then

    images_src="${SPLITLINE_ARR[images_src]}"
    images_dst="${SPLITLINE_ARR[images_dst]}"
    
    # remove any file that would have the name of the directory
    if [ -f "$images_src" ]; then
        rm "$images_src"
    fi
    if [ -f "$images_dst" ]; then
        rm "$images_dst"
    fi
    
    # create the dirs
    mkdir -p "$images_src"
    if [ 0 -eq $? ]; then
        mkdir -p "$images_dst"
        if [ 0 -eq $? ]; then
            
            
            # announce the tasks that the variables are ready
            CONFIG[images_src]="$images_src"
            CONFIG[images_dst]="$images_dst"
            log "prepare.sh: Set variable CONFIG[images_src]=$images_src"
            log "prepare.sh: Set variable CONFIG[images_dst]=$images_dst"
            
            
            #----------------------------------------
            # Now let's copy the images from images_src to images_dst
            #----------------------------------------
            cd "$images_src"
            log "prepare.sh: Copying images to $images_dst"
            for image in *; do
                echo "$image" | grep -qi '\.\(jpg\|gif\|png\|jpeg\)$'
                 if [ 0 -eq $? ]; then
                    log "prepare.sh: ---- $image" 
                    cp "$image" "$images_dst"
                 fi
            done
        else
            error "prepare: couldn't create the images_dst directory: $images_dst"
        fi        
    else
        error "prepare: couldn't create the images_src directory: $images_src"
    fi
    
    
    
    
    
    
else
    error "prepare: config error, unknown expression: $VALUE, use the following format: &images_src&images_dst"
fi




endTask "Prepare"
```




There are a few new things, let's explain them.

#### The startTask and endTask functions
  
The startTask and endTask functions are used to visually enclose the output of the task.
They are separators that only show up if you use the command line version of your software,
and if the VERBOSE mode is on (-v option).
Here is the signature of those methods:

    void    startTask ( title )
    void    endTask ( title )
    
 
    

#### The splitLine function

We've already talked about the splitLine function earlier.
The splitLine function splits a string using a delimiter, and set the values in an array.

Its signature is this:

    1|0     function splitLine # ( string, delimiter [, keyN ]* )


The string argument has the following format:
    
    <delim> <blank>? <var> (<blank>? <delim> <blank>? <var>)*
    
For instance:
    
    - # var1 # var2
    - .var1.var2.var3
    - & /path/to/images_src & /path/to/images_dst 


The delimiter must have a length of 1.



Then to retrieve the variables, we use the keyN arguments.
When the splitLine function is called: it creates a new array: SPLITLINE_ARR.
The variables found in the string are mapped to the keys that we passed to the function.

Here are some examples of calls and the resulting SPLITLINE_ARR:


```bash    
> splitLine "# var1 # var2" "#" "key1" "key2"

# will create the following SPLITLINE_ARR 
SPLITLINE_ARR["key1"]="var1"
SPLITLINE_ARR["key2"]="var2"


> splitLine ".var1.var2.var3" "." "key1" "key2" "key3"

# will create the following SPLITLINE_ARR 
SPLITLINE_ARR["key1"]="var1"
SPLITLINE_ARR["key2"]="var2"
SPLITLINE_ARR["key3"]="var3"


> splitLine "& /path/to/images_src & /path/to/images_dst" "&" "images_src" "images_dst"

# will create the following SPLITLINE_ARR 
SPLITLINE_ARR["images_src"]="/path/to/images_src"
SPLITLINE_ARR["images_dst"]="/path/to/images_dst"
```    


The function returns 1 if the delimiter was the very first char of the string,
and 0 otherwise.


#### The VALUE variable

The VALUE variable is the value that we associated to our projects in the HOME/config.d/myconf.txt config file.
Since we are now coding the prepare task, and given the fact that our prepare section looks 
like this (in the config file):


    prepare:
    p1=&/tmp/images&/tmp/processed_images_p1
    p2=&/tmp/images&/tmp/processed_images_p2
    
    
Then the value of VALUE will be either:

    - &/tmp/images&/tmp/processed_images_p1
    
    or

    - &/tmp/images&/tmp/processed_images_p2


depending on which project the Bash manager script is currently processing.




#### The CONFIG array
 
The CONFIG array is an associative array that is available to every task.
By convention, we use the CONFIG array to transmit variables from one task to another.
Therefore, the task order is important: task that creates new variables must be executed BEFORE
tasks that use them.


Note:
    The truth is that any variable you create in a task is accessible to the subsequent called tasks,
    but using the CONFIG array makes things cleaner.

 
 
#### The log function
 
When you code a task, the log function is your friend.

log displays a message like echo, but:
- it prefixes the message with the software name
- if the VERBOSE mode is off (-v option not set), it doesn't show anything at all


My advice is: unless you need to display something very specific to STDOUT, always use log instead of echo.

The signature is:
        
        void    log ( message )


#### The error function

The error function sends a message to STDERR.

If the VERBOSE mode is on (-v option on the command line), it also displays a trace (a debug string that
helps you spot the exact location ---script and line--- of the problem).

If the STRICT mode is on (-s options set on the command line), it will exit your program (software) with 
an exit status of 1.





Everything else in the prepare task is just bash code.


#### Testing the code so far

At this point, we can already run our software.
Since the rename and resize tasks are empty, they won't do any harm.


Type the following commands:


```bash    
> ls -l /tmp/processed_images_p1
ls: /tmp/processed_images_p1: No such file or directory

> ls -l /tmp/processed_images_p2
ls: /tmp/processed_images_p2: No such file or directory


> bashman -h /tmp/photoTouch -v
...
blabla
...

> ls /tmp/processed_images_p1
1412613364603_wps_17_SANTA_MONICA_CA_AUGUST_04.jpg happy_cat_by_geardupfritz-d2xspdk.jpg              photo_latest14.jpg
540px-How-to-draw-anime-cats-Step-8.jpg            hqdefault.jpg                                      sf-cat.jpg
a.baa-One-very-cute-little-cat.jpg                 maxresdefault-500x375c.jpg                         unnamed.png
catsofinstagram.jpg                                mt2UmwGG_400x400.jpeg

> ls /tmp/processed_images_p2
1412613364603_wps_17_SANTA_MONICA_CA_AUGUST_04.jpg happy_cat_by_geardupfritz-d2xspdk.jpg              photo_latest14.jpg
540px-How-to-draw-anime-cats-Step-8.jpg            hqdefault.jpg                                      sf-cat.jpg
a.baa-One-very-cute-little-cat.jpg                 maxresdefault-500x375c.jpg                         unnamed.png
catsofinstagram.jpg                                mt2UmwGG_400x400.jpeg
```    


Not bad: our software copied the images from images_src to images_dst.
But there is something I don't like that much: the software has executed project both p1 and p2.

That's because by default, the Bash manager script basically executes everything it can.
That means: every task and projects found in every config file in HOME/config.d.
Although there might some cases where this behaviour is desirable, in this tutorial,
we will be more specific.

Let's redo our testing process, but we will focus on project p1 of config file HOME/config.d/myconf.txt.
Type the following commands:


```bash    
> rm -r /tmp/processed_images_p*
> bashman -h /tmp/photoTouch -c myconf -p p1 -v 
...
blabla
...
> ls /tmp/processed_images_p1
1412613364603_wps_17_SANTA_MONICA_CA_AUGUST_04.jpg happy_cat_by_geardupfritz-d2xspdk.jpg              photo_latest14.jpg
540px-How-to-draw-anime-cats-Step-8.jpg            hqdefault.jpg                                      sf-cat.jpg
a.baa-One-very-cute-little-cat.jpg                 maxresdefault-500x375c.jpg                         unnamed.png
catsofinstagram.jpg                                mt2UmwGG_400x400.jpeg
> ls /tmp/processed_images_p2
ls: /tmp/processed_images_p2: No such file or directory
```

Aaah, much better.

When we write a software, it automatically inherits the Bash manager command line options,
which allow us to be specific on which config file to use (-c), which projects (-p), and also which tasks (-t).
In other words, a Bash manager based software is always modular.



 
 
 
### Creating the rename task

Let's now tackle the rename task.
Open the HOME/tasks.d/rename.sh task and put the following content in it:



```bash
#----------------------------------------
# GOAL
#----------------------------------------
# This task will rename the images (jpg, jpeg, gif, or png)
# located in the images_dst directory. 
# This will be destructive.
# 
# Example of expected value:
#       p1=cat_{number}.{extension}
# 


startTask "Rename"

images_dst="${CONFIG[images_dst]}"
format="$VALUE"

# we only treat data if the format is defined
if [ -n "$format" ]; then
    if [ -n "$images_dst" ]; then
        if [ -d "$images_dst" ]; then
            cd "$images_dst"
            
            
            log "rename.sh: Renaming images in $images_dst"
            
            number=1
            for image in *; do
                extension=${image##*.}
                echo "$extension" | grep -qi '^\(jpg\|gif\|png\|jpeg\)$'
                 if [ 0 -eq $? ]; then
                    newName=$(echo "$format" | sed -e "s/{number}/$number/g" -e "s/{extension}/$extension/g")
                    log "rename.sh: ---- $image > $newName" 
                    ((number++))
                    mv "$image" "$newName"
                 fi
            done
            
            
            
        else
            error "$images_dst is not a valid directory"
        fi    
        
    else
        error "The images_dst variable is not set"
    fi
fi


endTask "Rename"
```



There is nothing new here.
Basically, it's a Bash way to say: rename the images located in the images_dst directory, 
using the format that we described in the "The rename task's value" section.

Remember what's in the config file?

    ...
    rename:
    p1=cat_{number}.{extension}
    ...

That should rename all the images.
We shall test our software now.


```bash
> bashman -h /tmp/photoTouch -c myconf -p p1 -v 
...
blabla
...
> ls /tmp/processed_images_p1
cat_1.jpg  cat_10.jpg cat_11.png cat_2.jpg  cat_3.jpg  cat_4.jpg  cat_5.jpg  cat_6.jpg  cat_7.jpg  cat_8.jpeg cat_9.jpg
```


Good.
Now before we code the resize task, I would like to show you how to code the rename task 
using another scripting language.



### Creating the rename task using another scripting language

The Bash manager framework allows us, with a little extra work, to use any scripting 
language (python, php, perl, ruby, java, etc...).


In this section, I will demonstrate how we could have use php to create the rename task (which is currently coded in bash 4+).

Let's update the HOME/config.d/myconf.txt file and replace its content with the following:


    prepare:
    p1=&/tmp/images&/tmp/processed_images_p1
    p2=&/tmp/images&/tmp/processed_images_p2
    
    
    _rename:
    p1=cat_{number}.{extension}
    
    
    rename(php):
    p1=cat_{number}.{extension}
    
    
    resize:
    p1=w350h250
    p2=w500



I temporarily discarded the original rename task (in bash) by prefixing it with an underscore.
This is a convention that the Bash manager script uses.
It means: skip this task.

So instead of processing the _rename task,
it will process the following task, which is rename(php).

If the task name contains parenthesis like that, the expression in parenthesis represents
the extension of the script that you want to call.

The following extensions are available:

- sh => a bash script
- php => a php script
- py => a python script
- java => a java program
- rb => a ruby script
- pl => a perl script


Now we need to create a php version of our rename.sh task.
Create the HOME/tasks.d/rename.php file, and put the following in it:


```php
<?php




if (isset($_SERVER['BASH_MANAGER_CONFIG_IMAGES_DST'])) {
    if (isset($_SERVER['BASH_MANAGER_CONFIG__VALUE'])) {


        $imagesDst = $_SERVER['BASH_MANAGER_CONFIG_IMAGES_DST'];
        $images = scandir($imagesDst);
        $format = $_SERVER['BASH_MANAGER_CONFIG__VALUE'];
        $allowedExtensions = ['jpg', 'jpeg', 'gif', 'png'];

        echo "log: rename.php: Renaming images in $imagesDst" . PHP_EOL;
        
        
        $n = 1;
        foreach ($images as $image) {
            if ('.' !== $image && '..' !== $image) {

                
                // even though images might have been already filtered, 
                // we make sure that only images (jpg, jpeg, gif, png) are processed
                $extension = '';
                $extension = '';
                if (0 !== ($pos = strrpos($image, '.'))) {
                    $extension = substr($image, $pos + 1);

                    if (in_array(strtolower($extension), $allowedExtensions)) {
                        
                        $newName = str_replace([
                            '{number}',
                            '{extension}',
                        ], [
                            $n,
                            $extension,
                        ], $format);

                        if (false !== rename($imagesDst . "/" . $image, $imagesDst . "/" . $newName)) {
                            echo "log: rename.php: ---- $image > $newName" . PHP_EOL;
                            $n++;
                        }
                    }
                }
            }
        }
    }
    else {
        echo "warning: rename.php: BASH_MANAGER_CONFIG__VALUE undefined" . PHP_EOL;
    }
}
else {
    echo "warning: rename.php: BASH_MANAGER_CONFIG_IMAGES_DST undefined" . PHP_EOL;
}
```




Basically, this script does the same as the bash version.
However, there are a few rules that apply only to foreign scripts (scripts not written in bash).
Those rules are explained in more details in the 
[foreign script guidelines](https://github.com/lingtalfi/bashmanager/blob/master/doc/foreign-script-guidelines.eng.md)
.


        
        
        
        
        
That's how we can leverage the power of other scripting language in Bash manager.
        
        
At this point, we should test our code again and see if the php version of rename works as expected.
Type the following commands:        
        
```bash        
> bashman -h /tmp/photoTouch -c myconf -p p1 -v 
...
blabla
...
> ls /tmp/processed_images_p1
cat_1.jpg  cat_10.jpg cat_11.png cat_2.jpg  cat_3.jpg  cat_4.jpg  cat_5.jpg  cat_6.jpg  cat_7.jpg  cat_8.jpeg cat_9.jpg
```    
        

Everything seems fine, it worked.                


### Creating the resize task


Let's move on and create the resize task.
I've imagemagick installed on my machine, so I will be using imagemagick.
As always, any tool that does the job is good as well.

The task's value has already been discussed in the "The resize task's value" section,
so let's create the script.


Open the HOME/tasks.d/resize.sh task and put the following content in it:



```bash
#----------------------------------------
# GOAL 
#----------------------------------------
# 
# This script will resize images
# according to the given format.
# It leverages the imagemagick software.
# The format specifies the maxWidth and
# maxHeight values.
# 
# The format can have three forms that look like this:
# -- w600       # using only maxWidth
# -- h200       # using only maxHeight
# -- w600h420   # using both maxWidth and maxHeight
# 
# 
# 
#----------------------------------------
startTask "Resize"


images_dst="${CONFIG[images_dst]}"
format="$VALUE"



if [ -n "$format" ]; then
    if [ -n "$images_dst" ]; then


        #----------------------------------------
        # Converting the format to maxWidth and maxHeight
        #----------------------------------------
        width=0 # 0 means not set
        height=0
        if [ "w" = "${format:0:1}" ]; then
            width="${format:1}"
            if [[ "$width" == *"h"* ]]; then
                height=$(echo "$width" | cut -dh -f2)
                width=$(echo "$width" | cut -dh -f1)
            fi
        elif [ "h" = "${format:0:1}" ]; then
            height="${format:1}"
        fi
        m="Redimensioning using "
        if [ 0 -ne $width ]; then
            m+="maxWidth=$width; "
        fi
        if [ 0 -ne $height ]; then
            m+="maxHeight=$height; "
        fi
        log "resize.sh: $m"
        
        
        
        #----------------------------------------
        # Resizing the images using imagemagick
        #----------------------------------------
        cd "$images_dst"
        # prepare for use with imagemagick
        if [ "0" = "$width" ]; then
            width=""
        fi
        if [ "0" = "$height" ]; then
            height=""
        fi
        imageMagickFmt="${width}x${height}"
        
        
        for image in *; do
            extension=${image##*.}
            echo "$extension" | grep -qi '^\(jpg\|gif\|png\|jpeg\)$'
            if [ 0 -eq $? ]; then
            mogrify -geometry "$imageMagickFmt" "$image"
            log "resize.sh: redimensioning $image"
            fi
        done
    

    else
        error "images_dst.sh: images_dst not set"
    fi  
else
    error "resize.sh: empty format"
fi 




endTask "Resize"
```



There is nothing new in this script, except the imagemagick's specific mogrify command (see imagemagick for more 
info on this topic).

Let's test our software one last time.


Type the following commands.

```bash
# first check the size of the original images
> cd /tmp/images
> find . -name "*" -exec identify {} \; | awk '{printf "%-13s: %s\n", $1, $3}'
...
./1412613364603_wps_17_SANTA_MONICA_CA_AUGUST_04.jpg: 634x513
./540px-How-to-draw-anime-cats-Step-8.jpg: 540x525
./a.baa-One-very-cute-little-cat.jpg: 500x375
./catsofinstagram.jpg: 635x450
./happy_cat_by_geardupfritz-d2xspdk.jpg: 900x675
./hqdefault.jpg: 480x360
./maxresdefault-500x375c.jpg: 500x375
./mt2UmwGG_400x400.jpeg: 400x400
./photo_latest14.jpg: 574x710
./sf-cat.jpg : 500x315
./unnamed.png: 434x512


> bashman -h /tmp/photoTouch -c myconf -p p1 -v 
...
blabla
...
> cd /tmp/processed_images_p1
> find . -name "cat*" -exec identify {} \; | awk '{printf "%-13s: %s\n", $1, $3}'
./cat_1.jpg  : 309x250
./cat_10.jpg : 350x221
./cat_11.png : 212x250
./cat_2.jpg  : 257x250
./cat_3.jpg  : 333x250
./cat_4.jpg  : 350x248
./cat_5.jpg  : 333x250
./cat_6.jpg  : 333x250
./cat_7.jpg  : 333x250
./cat_8.jpeg : 250x250
./cat_9.jpg  : 202x250
```


None of our image has a width greater than 350px or a height greater than 250px, it worked.


Our software is now finished.

Remember that using the config file, you are in control on the branching between tasks and projects.
You could for instance create a project that would only rename files, or conversely, create a project
that would only resize images.



### Where to go from there?


If you completed photoTouch tutorial, you should be able to fly by yourself right now.
Just try small applications first, then progressively add the features, and hopefully you will 
see that the Bash manager framework is a good companion.





More documentation
------------------------

Although this document is quite wordy, we didn't cover every aspect of the bash manager.<br>
The following links might help you deepen your knowledge of the bash manager.
 

- [Install Bashmanager](https://github.com/lingtalfi/bashmanager/blob/master/doc/install-bashmanager.eng.md)
- [Task Author Cheatsheet](https://github.com/lingtalfi/bashmanager/blob/master/doc/task-author-cheatsheet.eng.md)
- [Task Author Guidelines](https://github.com/lingtalfi/bashmanager/blob/master/doc/task-author-guidelines.eng.md)
- [Foreign Script Guidelines](https://github.com/lingtalfi/bashmanager/blob/master/doc/foreign-script-guidelines.eng.md)
- [Reserved Functions](https://github.com/lingtalfi/bashmanager/blob/master/doc/task-author-reserved-functions.eng.md)
- [Command Line Aliases](https://github.com/lingtalfi/bashmanager/blob/master/doc/aliases.eng.md)
- [Command Line Options](https://github.com/lingtalfi/bashmanager/blob/master/doc/commandLineOptions.eng.md)
- [Constraints](https://github.com/lingtalfi/bashmanager/blob/master/doc/constraints.eng.md)



Plugins
--------------------

- [phpManager](https://github.com/lingtalfi/bashmanager_plugin_phpmanager)
    
    php plugin for bash manager: makes developing more obvious for php developer






Version history
------------------------


- 1.08 - 2015-10-29

    Add support for java (as foreign language)    
    
- 1.07 - 2015-10-20

    Add feature: --option-key=value can now be written --option-key value    
    
    
- 1.06 - 2015-10-16

    Add feature: special _none_ project can be used to execute any task 
    fix bug: tasks are now searched recursively under tasks.d (not just the root level) 
    
    
- 1.05 - 2015-10-14

    Added vv (very verbose) option, reduced the default verbosity of the bash man original command
    


- 1.04 - 2015-10-13
 
    - Fixed bug with script extension 
    - Fixed bug with underscore skipping
    - add wildcard * notation for project in config file
    - make OTHER_VALUES available to external scripts
    - add support for alwaysIncluded tasks (taskName*)
    - add support for startTask and endTask in foreign scripts
    - add support for alias
    


- 1.03 - 2015-09-21 21:39

    - Modified endTask output to improve readability
    - Fixed bug in 1.02 (overriding VALUE too) 

- 1.02 - 2015-09-21 20:28

    Added mechanism for overriding task's values from command line

- 1.01 - 2015-09-21

    Added newFileName function

- 1.0 - 2015-09-10

    Initial commit
    

