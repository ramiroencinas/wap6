use lib '../lib';
use Wap6;

use lib 'webservices';
use Webservices;

# max number of threads (16 by default)
%*ENV{'RAKUDO_MAX_THREADS'} = 50;

my $server-ip = "0.0.0.0";
my $server-port = 3000;
my $default-html = "index.html";

my %webservices;
# key = route, value = corresponding sub of the Webservices module
%webservices{'/ws1'} = &ws1;
%webservices{'/ws2'} = &ws2;
%webservices{'/ws-fileops'} = &ws-fileops;

wap(:$server-ip, :$server-port, :$default-html, :%webservices);
