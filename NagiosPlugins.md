# Introduction #

Nagios plug-ins are part of this project and they will be documented in this page.

## Siebel Components Monitoring ##

Currently there are two plug-ins for Nagios:

  * SiebelSrvrmgrNagios: a plug-in to monitor Siebel components status in a Siebel Server
  * NagiosPluginSiebelRemote: a plug-in to monitor Siebel Remote pending transactions threshold.

Both plug-ins must be integrated to Nagios using the default configuration methods. They can also be used as command lines tools, but using them with Nagios give much more features.

### Screen shots ###

Below there are some screen-shots taken from the Nagios screens showing information generated by the SiebelSrvrmgrNagios plug-in in action.

**Services being monitored in a server:**

![http://siebel-monitoring-tools.googlecode.com/files/Nagios%20Core%20-%20Mozilla%20Firefox_2012-06-26_12-32-58.png](http://siebel-monitoring-tools.googlecode.com/files/Nagios%20Core%20-%20Mozilla%20Firefox_2012-06-26_12-32-58.png)

**Service information (of the plug-in)**:

![http://siebel-monitoring-tools.googlecode.com/files/Nagios%20Core%20-%20Mozilla%20Firefox_2012-06-26_12-34-16.png](http://siebel-monitoring-tools.googlecode.com/files/Nagios%20Core%20-%20Mozilla%20Firefox_2012-06-26_12-34-16.png)

**Log of contact notifications for the plug-in:**

![http://siebel-monitoring-tools.googlecode.com/files/Nagios%20Core%20-%20Mozilla%20Firefox_2012-06-26_12-35-55.png](http://siebel-monitoring-tools.googlecode.com/files/Nagios%20Core%20-%20Mozilla%20Firefox_2012-06-26_12-35-55.png)

The NagiosPluginSiebelRemote plug-in should have the same behavior as shown in the screen-shots of SiebelSrvrmgrNagios.