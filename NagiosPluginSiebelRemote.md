# Introduction #

This plug-in monitors if the Siebel Remote transactions pending to be routed to Siebel Clients number is lower or higher than the thresholds defined by command line options: depending on the values recovered, the output generated to Nagios will take care of the next configured steps.

Why is this plug-in useful?

  * Sometimes the Transaction Router has a OK status (like "Running" or "Online") but the transactions are not being routed due a failure in a tasks or a intermittent database problem.
  * Sometimes nothing is generating errors, but for some reason (like an unknown huge data load) the Siebel Transaction Router and/or the database have a bottleneck problem and are not being able to route all those transactions.

This plug-in does not the Siebel-Srvrmgr API: all that is necessary is to have a database connection to the Siebel Enterprise database.

# Details #

The plug-in works by using the steps described below:

  1. Connect to the configured ODBC DSN in the configuration file.
  1. Execute a query (SELECT only) to the database to recover the number of pending transactions.
  1. Compare the returned values with the thresholds defined by the command line parameters.
  1. Returns to standard output a string in a format expected by Nagios
  1. Based on the returned string Nagios server will proceed as configured.

## Setup ##

This Nagios plug-in needs to have some Perl distributions installed (see Makefile.PL) from CPAN and, of course, need to have installed Perl (any distribution should do it) with the minimum version being 5.16. More details about installing Perl and CPAN modules is available at PerlDistroSetup.

After downloading and unpacking the plug-in tar.gz file, just run:

  1. perl Makefile.PL
  1. make
  1. make install

The plug-in uses a configuration file that looks like this:

```ini

timeout = 15
[ODBC]
dsn = dbi:ODBC:FOOBAR
user = FOO
password = BAR
```

timeout parameter is the value, in seconds, that the program should wait to connect and recover data from the data base defined in the ODBC DSN: after that, the plug-in execution is aborted with a UNKNONW status to Nagios.

The values FOOBAR (the ODBC DSN to be used), FOO and BAR are the values that you want to change for ODBC connection.

The plug-in can be executed by Nagios by using three methods:

  * Directly from the Nagios servers.
  * Using the NSC client to communicate with a Microsoft Windows computer/server.
  * Using NRPE client to to communicate with a Linux computer/server.

In any case, besides the Perl interpreter and distributions, an ODBC configuration is necessary. This may be changed to pure Perl DBI connections in future releases.

Considering the flexibility, the suggested setup is to use any other server that is not running the Siebel Enterprise.

## Usage ##

After installing, you will have the Perl script `siebrem.pl` available in your users PATH for execution.

It is recommended to run the script before starting Nagios configuration, specially to allow you to fine tune the command line parameters. The screen shot below shows the online help:

![http://siebel-monitoring-tools.googlecode.com/files/siebrem1.png](http://siebel-monitoring-tools.googlecode.com/files/siebrem1.png)

The parameter `--pending` defines the minimum amount of pending transactions to consider in the Siebel Remote tables. You problem won't care about something below 300 transactions, but this depends strongly on your Siebel environment.

The other two parameters `--warning` and `--critical` are the thresholds to help Nagios understanding which value should be considered only a warning (like 301, for example) or critical (like 1000).