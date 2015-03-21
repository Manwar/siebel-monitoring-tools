# Siebel-Srvrmgr setup procedures #

The Siebel-Srvrmgr download-able tarball (see http://search.cpan.org/perldoc?Siebel::Srvrmgr for it) includes a Makefile.PL to make it easier to install the application. After unpacking the tarball, there are two ways to install it:

  * the good and old "perl Makefile.PL; make; make install".
  * using the CPAN shell.

Both methods relies in features available in any Perl distribution.

## Using directly the Makefile.PL ##

After unpacking the tarball, it is just a matter to go to created folder and type:

```
$ perl Makefile.PL
$ make
$ make install
```

The problem with this method is that you will need to solve the dependencies necessary for the finder.pl script manually. If you have Internet connection available, the CPAN shell method should be much easier to use.

## Using the CPAN shell ##

There are several ways to use the CPAN shell to install the Perl modules dependencies. The explained methods are from the easiest to the hardest.

### Use the Bundle ###

There is a [CPAN Bundle](http://search.cpan.org/perldoc?Bundle::Siebel::MonitoringTools) available for installing all Perl modules dependencies that this project need.

You even do not have to understand what is a CPAN Bundle: just use the sequence of commands show below:

```
$ perl -MCPAN -e shell
```

After this command the CPAN shell will be opened to you:

```
cpan shell -- CPAN exploration and modules installation (v2.00)
Enter 'h' for help.

cpan>
```

Then type:

```
install Bundle::Siebel::MonitoringTools
```

And that's it!

You can find more information about the bundle in it's [Perl Pod](http://search.cpan.org/perldoc?Bundle::Siebel::MonitoringTools).

### Use the CPAN experimental feature ###

You will need to rename the extracted directory from the tarball, appending a dot to it. For example, let suppose that you have the following directory:

```
Siebel-Srvrmgr-<version>
```

You will need to rename it to:

```
Siebel-Srvrmgr-<version>.
```

Inside a shell, type:

```
$ perl -MCPAN -e shell
```

If you never used the CPAN shell before, you will need to reply some questions to get it configured. For more information about that, please consult http://search.cpan.org/perldoc?CPAN.

After that, inside the CPAN shell type:

```
install Siebel-Srvrmgr-<version>.
```

The CPAN shell will find the Makefile.PL, process it, solve all needed dependencies and copy the files to the correct places.

More information about this feature of CPAN shell can be seen at http://search.cpan.org/perldoc?CPAN#Integrating_local_directories.