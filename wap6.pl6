use lib 'lib';
use Wap6;

use lib 'webservices';
use Webservices;

my $server-ip = "0.0.0.0";
my $server-port = 3000;
my $default-html = "index.html";

my %webservices;
# key = route, value = corresponding sub of the Webservices module
%webservices{'/ws1'} = &ws1;
%webservices{'/ws2'} = &ws2;

wap(:$server-ip, :$server-port, :$default-html, :%webservices);
