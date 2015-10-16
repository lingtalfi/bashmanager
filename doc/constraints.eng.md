Constraints
==================================================
2015-10-16






Recommendations
-------------------


### Tasks should have unique base names

As of 1.06, a bug has been fixed that allows tasks to be searched recursively.
So this allows the task author to organize her tasks in folders like this for instance:

    - tasks.d
    ----- database
    --------- applyPatch.php
    --------- backupRemote.php
    ----- image
    --------- resize.php
    --------- crop.php

The problem that comes with this feature is that now two file can possibly have the same
[baseName](https://github.com/lingtalfi/ConventionGuy/blob/master/nomenclature.fileName.eng.md).
When this occurs, bash manager only considers the first instance found.
Therefore, we recommend that task authors don't use identical basename for their task files.
 
 
