# Cleanup Localizable.strings

When using `Localizable.strings` with many entries in your XCode project you sooner or later 
may use a key more than once. It is not possible to let XCode find that case 
and issue a warning. However you can type a unix command in the terminal and you get a 
list saying how often each key is used.

```
cut -d' ' -f1 Localizable.strings | sort | uniq -c
```

On the other hand when you want to eliminate duplicates the swift tool of this project is very handy. Change into the
directory where you `Localizable.strings` file is located and type the following command.

```
LocalizedCleanup Localizable.strings
```
All duplicates (lines with same key value pair) will be eliminated and sorted by ascending key. If you have more then one key with different values the keys are postfixed with a '.x' number. 
