# Introduction #

This Nagios plug-in is part of the current Siebel-Srvrmgr distribution as a proof of concept of implementing a application by using the API (see the examples directory of the distribution).

The plug-in works executing the following operations in sequence after is invoked by Nagios (directly or indirectly):

  1. read a XML configuration file;
  1. connect to the Siebel server with `srvrmgr` program;
  1. list all components configured in the Server;
  1. compare the components states with the expected ones read from the XML configuration file;
  1. return the comparison as a format understood by Nagios;

This plug-in also can be executed from a shell, but the features will be limited to print to STDOUT one of the options below:

  * Everything is OK
  * A warn level problem was detected
  * A critical level problem was detected
  * The plug-in could not be executed correctly, so Siebel components state is unknown.

Executing the plug-in from Nagios have much more features (all of them provided by Nagios). Please check the [Nagios web page for more details](http://www.nagios.org/).

## Installation ##

Regarding the OS platform requirements, since the Nagios plugin depends on the Nagios core, it will not be available on OS platforms where Nagios is not available **but** it is possible to use the plug-in installed in any OS that have a `srvrmgr` program available (for example, Microsoft Windows).

The Nagios plug-in needs to have the Siebel-Srvrmgr Perl distribution installed from CPAN to work and, of course, need to have installed Perl (any distribution should do it) with the minimum version being 5.16.

The plug-in can be executed by Nagios by using three methods:

  * Directly from the Nagios servers: this requires that the srvrmgr is available.
  * Using the NSC client to communicate with a Microsoft Windows computer/server where srvrmgr program is available.
  * Using NRPE client to to communicate with a Linux computer/server where srvrmgr program is available.

Considering the flexibility, the suggested setup is to use any other server that is not running the Siebel Enterprise: since communication is done by using SISNAPI, memory and CPU consumption should be negligible in the monitored Siebel Enterprise.

To setup the Siebel-Srvrmgr please check the wiki PerlDistroSetup.

After installing the Siebel-Srvrmgr, go to the _examples_ directory inside the distribution extracted files, and then _Siebel-Srvrmgr-Nagios_ directory. Inside of it, execute:

  1. perl Makefile.PL
  1. make
  1. make install

## Configuration ##

Beware that even that the XML and XML Schema files and the current API permits to configure multiple Siebel Servers, the program comp\_mon.pl expects to use a single Siebel Server in a Siebel Enterprise to monitor: the reason for this is to give at least some more detail if something goes bad in some components since at least the problem will be detected in a specific Siebel Server instead of identifying that there in a problem in a group of servers, but without indicating which one has a problem.

The XML configuration file looks like this:

```
<?xml version="1.0" encoding="UTF-8"?>
<ns1:siebelMonitor xmlns:ns1="http://code.google.com/p/siebel-monitoring-tools">
<ns1:connection>
  <ns1:siebelServer>foobar</ns1:siebelServer>
  <ns1:srvrmgrPath>C:/Siebel/8.1/Client/BIN</ns1:srvrmgrPath>
  <ns1:srvrmgrExec>srvrmgr.exe</ns1:srvrmgrExec>
  <ns1:siebelEnterprise>SIEBEL</ns1:siebelEnterprise>
  <ns1:siebelGateway>foobar</ns1:siebelGateway>
  <ns1:user>foo</ns1:user>
  <ns1:password>bar</ns1:password>
</ns1:connection>
<servers>
  <server name="foobar">
    <components>
      <component name="TxnProc" description="Transaction Processor" ComponentGroup="Remote" OKStatus="Executing" criticality="5"/>
      <component name="WorkActn" description="Workflow Action Agent" ComponentGroup="Workflow" criticality="1"/>
      <component name="WorkMon" description="Workflow Monitor Agent" ComponentGroup="Workflow" criticality="1"/>
      <component name="WfProcBatchMgr" description="Workflow Process Batch Manager" ComponentGroup="Workflow" criticality="1"/>
      <component name="WfProcMgr" description="Workflow Process Manager" ComponentGroup="Workflow" criticality="5"/>
    </components>
    <componentsGroups>
      <componentGroup name="Workflow" defaultOKStatus="Executing|Activated"/>
    </componentsGroups>
  </server>
</servers>
```

Each component description includes:

  * name: the component alias, as retrieve from `list comp` command on `srvrmgr`;
  * description: the description field from `list comp` command on `srvrmgr`;
  * OKStatus: the expected status for the component, as returned by the `list comp` command. It is possible to include multiple values, separated by a pipe character ("|");
  * ComponentGroup: the component group that the component is part of, as from `list comp` command on `srvrmgr`. This configuration is optional and may be used as a shortcut to identify globally which are the expected status for the component;
  * criticality: a integer value that identifies how much it is critical for the server if the component does not have the expected status. This value will be used to calculate the threshold of the plug-in to issue a _WARNING_ or a _CRITICAL_ in Nagios.

Basically, at the end of comparison of expected and current states of the components, each component that does not match the expected state will have it's _criticality_ property summed to others. If the result is zero, it means that all components are running as expected. If not, the thresholds defined when executing the plug-in will define which type of notification will be used.

You can create as many components definitions in the XML file as necessary.

### Running/testing the plug-in ###

The plug-in expects command lines parameter. This is the output if no argument is given:

```
jackal@yggdrasil$ perl comp_mon.pl
Usage: comp_mon.pl -w -c -f

Missing argument: warning
Missing argument: critical
Missing argument: configuration
```

These are the minimal command line options expected. The `--warning` and `--critical` are the thresholds to define how the plug-in should generated output to Nagios. In doubt, use as shown below:

```
perl comp_mon.pl --warning=0 --critical=4 --configuration=/etc/comp_mon.xml
```

There is a on-line help too, if the plug-in is invoked with `--help` argument:

```

jackal@yggdrasil$ perl comp_mon.pl --help
comp_mon.pl 0.1

This Nagios plug-in is free software, and comes with ABSOLUTELY NO WARRANTY.
It may be used, redistributed and/or modified under the terms of the GNU
General Public Licence (see http://www.fsf.org/licensing/licenses/gpl.txt).

Usage: comp_mon.pl -w -c -f

-?, --usage
Print usage information
-h, --help
Print detailed help screen
-V, --version
Print version information
--extra-opts=[section][@file]
Read options from an ini file. See http://nagiosplugins.org/extra-opts
for usage and examples.
-w, --warning=INTEGER. Warning if warning threshold is higher than INTEGER
-c, --critical=INTEGER. Critical if critical threshold is higher than INTEGER
-f, --configuration=PATH
-t, --timeout=INTEGER
Seconds before plugin times out (default: 15)
-v, --verbose
Show details for command-line debugging (can repeat up to 3 times)
```