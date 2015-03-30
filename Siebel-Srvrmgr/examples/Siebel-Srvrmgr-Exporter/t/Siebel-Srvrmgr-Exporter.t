use strict;
use warnings;
use Test::More tests => 2;
use Digest::MD5;
use Config;
use File::Spec;

BEGIN { use_ok('Siebel::Srvrmgr::Exporter') }

# calculated with:
# -for Linux
# perl -MDigest::MD5 -e '$filename = shift; open($fh, "<", $filename) or die $!; binmode($fh); print Digest::MD5->new->addfile($fh)->hexdigest, "\n"' test.txt
# - for Windows
#
my $expected_digest;

# the differences below are due the line end character differences
if ( $Config{osname} eq 'MSWin32' ) {

    $expected_digest = 'c6a7031cb1edafbe090a98b0e181befe';

}
else {    # else is for UNIX-line OS

    $expected_digest = '304772202cd96622032689da6b179a69';

}

my $filename = 'test.txt';

# srvrmgr-mock.pl ignores all parameters
my $dummy = 'foobar';

die "Cannot find srvrmgr-mock.pl for execution"
  unless ( -e ( File::Spec->catfile( $Config{sitebin}, 'srvrmgr-mock.pl' ) ) );

note('Fetching values, this can take some seconds');

system(
    'perl', '-Ilib', 'export_comps.pl',
    '-s', $dummy, '-g', $dummy,
    '-e', $dummy, '-u', $dummy,
    '-p', $dummy, '-b',
    File::Spec->catfile( $Config{sitebin}, 'srvrmgr-mock.pl' ),
    '-r',      'SRProc', '-x', '-o',
    $filename, '-q'
  ) == 0
  or die "failed to execute export_comps.pl: $!\n";

open( my $fh, '<', $filename ) or die "Can't open '$filename': $!";
binmode($fh);
is( Digest::MD5->new->addfile($fh)->hexdigest(),
    $expected_digest, 'got expected output from srvrmgr-mock' );

close($fh);

unlink($filename) or die "Cannot remove $filename: $!\n";
