use lib '../lib';
use Wap6;

use lib 'webservices';
use Webservices;

# max number of threads (16 by default)
%*ENV{'RAKUDO_MAX_THREADS'} = 50;

my $server-ip = "0.0.0.0";
my $server-port = 4433;
my $default-html = "index.html";

my %ssl-config =
        certificate-file => 'server.crt',
        private-key-file => 'server.key';

my %webservices;
# key = route, value = ( corresponding sub of the Webservices module, content-type )
%webservices{'/ws1'}        = ( &ws1, 'html' );
%webservices{'/ws2'}        = ( &ws2, 'json' );
%webservices{'/ws-fileops'} = ( &ws-fileops, 'html' );

wap-ssl(:$server-ip, :$server-port, :$default-html, :%webservices, :%ssl-config);
