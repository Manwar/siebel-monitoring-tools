# Introduction #

The parsers available from the API were tested against the several versions of Siebel. To see all of them, check the output directory inside the test directory.

The more different versions output that we have, the more reliable will be the parsers.

Providing the output from your Siebel Enterprise using the `srvrmgr` program is really simple. Please check the detail by reading the next content.

# Details #

First, it is necessary to setup correctly the output from the _list_ _component_ command. Type in the command below in the `srvrmgr` program prompt:

```
set ColumnWidth true
```

Then type:

```
﻿configure list components show SV_NAME(31) , CC_ALIAS(31) , CC_NAME(76) , CT_ALIAS(31) , CG_ALIAS(31) , CC_RUNMODE(31) , CP_DISP_RUN_STATE(61) , CP_NUM_RUN_TASKS(16) , CP_MAX_TASKS(12) , CP_ACTV_MTS_PROCS(17) , CP_MAX_MTS_PROCS(16) , CP_START_TIME(21) , CP_END_TIME(21) , CP_STATUS(251) , CC_INCARN_NO(23) , CC_DESC_TEXT(251)
```

This command should be executed from a single line inside of `srvrmgr` prompt (and indeed is a very long line). For convenience, this command is also available as a ".Siebel\_svrmgr.pref" file (the dot is part of the filename) in every distribution of the API (see the _examples_ directory after unpacking the tarball). This file is known as a srvrmgr preferences files and may include any customization desired since the login at any Siebel Enterprise. Please check the Siebel documentation for more details about personalization.

The reason for having this configuration is fully explained [here](http://search.cpan.org/~arfreitas/Siebel-Srvrmgr/lib/Siebel/Srvrmgr/ListParser/Output/ListComp.pm).

Once this is done, it is just a matter to execute the following commands:

  1. save preferences
  1. load preferences
  1. list comp
  1. list comp types
  1. list params
  1. list params for component SRProc
  1. list comp def SRProc
  1. list tasks
  1. list tasks for component SRProc

Order **is** important is this case, so please keep it.

Typing all those commands are also boring, so there is a text file available for download with all of those commands. This text file can be used like the command line below shows:

```
srvrmgr /g <GATEWAY> /s <SERVER> /e <ENTERPRISE> /o <PATH><OUTPUT>.txt /i <PATH>lists_cmd.txt /b /u <USER>
```

where:

  * `<`GATEWAY`>`: is the host name of the Siebel Gateway of the Enterprise.
  * `<`SERVER`>`: is the Siebel server name of the Enterprise. Be **ABSOLUTELY** sure to include this to get fixed width output: even forcing the output width with `set` command, it might be changed from one server to another.
  * `<`ENTERPRISE`<`: is the name of Siebel Enterprise.
  * `<`OUTPUT`>`: is the filename to be used as the generated output from srvrmgr. It should have the format `<`SIEBEL VERSION NUMBER`>``_``<`PATCH NUMBER`>`.txt.
  * `<`PATH`>`: the complete path to the files.
  * `<`USER`>` the login to be used for authentication. Should be **sadmin** or any other login with the same responsibility of sadmin.

Both files, .Siebel\_svrmgr and list\_cmd.txt, are available at the _examples_ directory at the [SVN repository](http://code.google.com/p/siebel-monitoring-tools/source/browse/#svn%2Ftrunk%2Fexamples).

Once you have the file, please create a new [Issue](http://code.google.com/p/siebel-monitoring-tools/issues/list) and attach the output file. Be sure to identify yourself so I can give you the proper credits for helping out.