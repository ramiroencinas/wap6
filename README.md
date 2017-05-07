# Wap6
A Perl 6 concurrent web application framework module

## Features:

- Public folder to host front-end structure (html, js, css and text based files).
- Routes with the corresponding webservices using Perl6 Modules.
- GET and POST HTTP methods.
- 200, 400, 404 and 413 HTTP status response codes.
- Concurrent tranfers with IO::Socket::Async
- UTF-8 by default.

## Required Perl 6 modules:

- URI;
- URI::Escape;

## Example:

```Perl6
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
```

## How to use

- Set `$server-ip` and `$server-port` variables like the example.
- Set `$default-html` variable with the name of the default html file located in the `/public` folder.
- Use the `/public` folder to host the front-end structure.
- Use the `/webservices/Webservices.pm6` module file to write your webservices (a sub per webservice).
- Add the route for each webservice sub in the `%webservices` hash like the example.
- Sets the max number of threads in `/lib/Configuration.pm6`
- Run, for example, with: `perl6 wap6.pl6`
- Run web-client in http://localhost:3000
