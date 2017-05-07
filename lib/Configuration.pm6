unit module Configuration;

# max number of threads (16 by default)
%*ENV{'RAKUDO_MAX_THREADS'} = 50;

# current application path
our $current-dir is export = $*CWD;

# max size of http message received
our $max-size-bytes-http-entity is export = 104857600; # 100mb

# newlines and carriage returns
our $nl is export  = "\r\n";
our $nel is export = "\r\n\r\n";

# http responses
our $http-header_200 is export = "HTTP/1.1 200 OK" ~ $nl ~ "Content-Type: text/html;charset=utf-8" ~ $nel;

our $http-header_400 is export = "HTTP/1.1 400 Bad Request" ~ $nl ~ "Content-Type: text/html;charset=utf-8" ~ $nel ~ "<h3>Bad Request</h3>";

our $http-header_404 is export = "HTTP/1.1 404 Not Found" ~ $nl ~ "Content-Type: text/html;charset=utf-8" ~ $nel ~ "<h3>Not Found</h3>";

our $http-header_413 is export = "HTTP/1.1 413 Request Entity Too Large" ~ $nl ~ "Content-Type: text/html;charset=utf-8" ~ $nel ~ "<h3>Request Entity Too Large</h3>";
