Blueprint Designer
==================

Allows the user to jump around between designer areas with cheat mode enabled,
so that you can design blueprint using infinite resources, without affecting
your actual game.

How To
------

*Shift + B* will enter the last designer that you've entered, or go back to the
normal world if you're currently in a designer.

*Control + B* will open the designer management GUI, where you can create,
delete, and enter designers.

Developers
----------

If you want to add a development version of the mod to your factorio version, I
created a handy PowerShell script to aid in the process (this may or may not
work with PowerShell Core on non-Windows platforms).  Simply clone the repo
into a sub-folder of your factorio install:

```
cd "C:\Program Files\Factorio x.y.z"
mkdir repos
cd repos
git clone https://github.com/covertcj/factorio-bluprint-designer
cd factorio-bluprint-designer
```

Then you need to run the PowerShell script to link the folder into your instal
(note that the directory structure from the previous example is important for
this to work properly):

```
./updateEnv.ps1
```

A symlink from this directory into your mod directory should now exist.  If you
ever need to bump a version number, the script supports parameters for that and
should automatically re-symlink this directory to the new name (and delete old
mod symlinks).
