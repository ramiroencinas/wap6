# Wap6
A Perl 6 concurrent web application framework module

## Features:

- Public folder to host front-end structure (html, js, css and text based files).
- Routes with the corresponding webservices using Perl6 Modules.
- GET and POST HTTP methods.
- 200, 400, 404 and 413 HTTP status response codes.
- Concurrent tranfers with IO::Socket::Async Class.
- UTF-8 by default.

## Required Perl 6 modules:

- URI;
- URI::Escape;

## Example:
(Go to demo folder for a full example)
```Perl6
use lib '../lib';
use Wap6;

use lib 'webservices';
use Webservices;

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
```

## How to use

- Creates a folder to hold the web solution and within it...
- Creates `public` and `webservices` folders.
- Creates the main server Perl6 script like the example above, and name it: `wap6.pl6` (for example).
- In `wap6.pl6`:
  - Set the max number of threads in `%*ENV{'RAKUDO_MAX_THREADS'}`
  - Set `$server-ip` and `$server-port` variables like the example.
  - Set `$default-html` variable with the name of the default html file located in the `/public` folder.
  - Add the route for each webservice sub reference in the `%webservices` hash, like the example. Each sub reference have have its corresponding sub in the `/webservices/Webservices.pm6` module.
- Use the `/public` folder to host the front-end structure (html, js, css, etc.)
- Use the `/webservices/Webservices.pm6` module to write your webservices (a sub per webservice).

- Run with: `perl6 wap6.pl6`
- Run web-client in http://localhost:3000
- Enjoy!
