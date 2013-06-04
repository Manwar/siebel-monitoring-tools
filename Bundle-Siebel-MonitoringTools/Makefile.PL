use 5.016003;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Bundle::Siebel::MonitoringTools',
    VERSION_FROM => 'lib/Bundle/Siebel/MonitoringTools.pm',    # finds $VERSION
    PREREQ_PM => {},
    (
        $] >= 5.005
        ?               ## Add these new keywords supported since 5.005
          (
            ABSTRACT_FROM => 'lib/Bundle/Siebel/MonitoringTools.pm'
            ,           # retrieve abstract from module
            AUTHOR => 'Alceu Rodrigues de Freitas Junior <arfreitas@cpan.org>'
          )
        : ()
    ),
);