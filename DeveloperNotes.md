

# Introduction #

The intention of this page is give more details for developers (and people that would like to contribute with code for the project) and general guidelines about how to contribute of code for this project.

# Details #

To provide monitoring of Siebel environments, this project considers obtaining (but no limited to) information from the program `srvrmgr`, which can connect to a Siebel Enterprise and gather several details from the `list` commands available.

To be able to work with the `srvrmgr` program and parsing its output, a general usage API was developed for this end. There are several packages/classes available in the [Siebel::Srvrmgr](http://search.cpan.org/perldoc?Siebel::Srvrmgr) namespace.

The main parser of this API is the [Siebel::Srvrmgr::ListParser](http://search.cpan.org/perldoc?Siebel::Srvrmgr::ListParser) class, which identify the commands and their respective output as read from default output from `srvrmgr` program. This class is a state machine parser and it's different states can be checked below:

![http://siebel-monitoring-tools.googlecode.com/files/pretty.png](http://siebel-monitoring-tools.googlecode.com/files/pretty.png)

The supported commands can be checked by seen the subclasses of [Siebel::Srvrmgr::ListParser::Output](http://search.cpan.org/perldoc?Siebel::Srvrmgr::ListParser::Output) superclass.

# Rules of thumb for developing #

These are very general rules and are open for discussion: having bad definitions are better then none.

This is a Perl project, so any developer should be comfortable dealing with:
  * Perl objects ([Moose](http://moose.iinteractive.com/) specifically);
  * Parsers;
  * Siebel concepts;

Regarding code style, the default configuration of the of the Perl-Support vim plug-in should work just fine. Of course, I'm not trying to say that is obligatory to use Vim or any other text editor: just try to stick with one code style helps a lot about code quality. Perl-Support can be reached at http://vim.sourceforge.net/scripts/script.php?script_id=556.

Do comment your code when committing to SVN: this helps a lot.

Perl does not enforces practices and programming style ([TMTOWTDI](http://en.wikipedia.org/wiki/There%27s_more_than_one_way_to_do_it)), but this does not means that every way is useful besides obfuscate code contests. The book "Perl Best Practices" is a very good reference and quite recommended. The [Perltidy](http://perltidy.sourceforge.net/) plug-in for Vim helps a lot too.

# Mailing list #

There are too few people in the project that justifies the creation of a developer mailing list. If necessary, just send a e-mail to the project owner for feedback or help.

In the future a mailing list may be created.