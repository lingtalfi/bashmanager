Foreign scripting guidelines
================================
2015-10-13



By default, tasks in bash manager are coded with the bash scripting language.
However, because some languages are sometimes more appropriate than others, 
bash manager also handles the following scripting languages: php, python, ruby and perl.

Those are called foreign scripts in the bash manager lingo.



In order to use foreign script at their full potential, foreign script authors should be aware of the special rules described below. 



Printing a line
--------------------

A line printed inside a foreign script is printed as is by the Bash manager script.
The only exceptions are the special notations described in this document.

All the lines that you print from a foreign script should end with the "end of line" symbol (\n), 
that's because the bash manager does some post-processing on them.


Reading values from the CONFIG and OTHER_VALUES arrays
------------------------------------------


In a foreign script, the CONFIG array is accessible for reading via the foreign script's environment.

Each foreign script has its own way to access the environment.
In php for instance, the environment variables are stored in the $_SERVER variable.

When exported to the foreign script environment, the keys of the CONFIG array are converted to uppercase.
So for instance, if your CONFIG array contains a key foo, you have to access it from your foreign script 
environment using the key BASH_MANAGER_CONFIG_FOO.
                
You should know that the CONFIG array contains a special key _VALUE representing the current task's value.
You can access it with the key: BASH_MANAGER_CONFIG__VALUE.

Similarly, a foreign script can read the values of the OTHER_VALUES array.
For instance, if the OTHER_VALUES array contains a key task1, 
the foreign script can access to the corresponding value using the key following key from its environment:
                
```bash
BASH_MANAGER_OTHER_VALUES_TASK1
```
        


Writing values in the CONFIG
--------------------------------

The CONFIG array can be used to share data between the different tasks (scripts).
In order to set a key FOO with value 789 in the CONFIG array, a foreign script needs to write the following 
special line:

```bash
BASH_MANAGER_CONFIG_FOO=789
```

In php, that would be:

```php 
<?php 
echo "BASH_MANAGER_CONFIG_FOO=789" . PHP_EOL;
```

This line will not be printed like a normal line, but instead, will tell Bash manager to set the FOO 
variable in the CONFIG array, with value 789.
Don't forget the new line symbol at the end, otherwise bash manager might not interpret this line as an instruction,
and might just display it as a normal line.



Using basic methods
-----------------------


The following methods (defined in the bash manager script) are available to the foreign scripts:


- log
- error
- warning
- exit
- startTask
- endTask


To use a method, a foreign script has to print a line with the following format:

```bash
<method> <:> <argumentString> <endOfLine>
```

For instance, if you want to use the native log function with message hello, you can print the following line 
                

```bash
log: hello
```

In php for instance, that would look like this:


```php
echo "log: hello" . PHP_EOL; // this will call the native log function defined in the bash manager core script.
```

Don't forget to end the line with the end of line symbol, or bash manager might not be able to process it properly.
    
    
    
    
Some snippets
--------------------

### java

```
# that's the call in your bash manager configuration
MyBashManHello(java):
project1=Friday
```

```java
# source code of your java program
public class MyBashManHello {


    public static void main(String[] args) {

        String value = System.getenv("BASH_MANAGER_CONFIG__VALUE");
        System.out.println("log:Java said: value from bash manager is " + value);

    }
}

```

Note: we don't need to bother with the package, because bash manager simply don't handles them.
So instead, we use a program name that will not conflict with our other java programs.
Here: MyBashManHello does not conflict with any other java program in my environment.


    