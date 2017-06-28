# LocalizedStringsCleanup

When using `localizable.strings` with many entries in your XCode project you sooner or later 
may use a key more than once. Is is not possible to let XCode find that case 
and issue a warning. However you can type a howrt comman in the terminal and you get a 
list saying how often each key is used.

```
cut -d' ' -f1 Localizable.strings | sort | uniq -c
```

However when you to eliminate duplicates the swift tool of this project is helpful. Change into the
directory where you Localizable.strings file is located and type the following command. All duplicates
will be eliminated; all keys are sorted and if you have more then one key with different values they 
are postfixed with '.x' number. 

```
LocalizedCleanup Localizable.strings
```




