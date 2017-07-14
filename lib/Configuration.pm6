unit module Configuration;

# current application path
our $current-dir is export = $*CWD;

# max size of http message received
our $max-size-bytes-http-entity is export = 100000000; # 100mb

# max size of access log
our $max-size-access-log is export = 1000000; # 1mb

# access.log file
our $accesslogfile is export = $current-dir ~ '/access.log';

# error.log file
our $errorlogfile is export = $current-dir ~ '/error.log';

# max size of error log
our $max-size-error-log is export = 1000000; # 1mb

# newlines and carriage returns
our $nl is export  = "\r\n";
our $nel is export = "\r\n\r\n";

# http responses
our $http-header_200 is export = "HTTP/1.1 200 OK" ~ $nl ~ "Content-Type: text/html;charset=utf-8" ~ $nel;

our $http-header_400 is export = "HTTP/1.1 400 Bad Request" ~ $nl ~ "Content-Type: text/html;charset=utf-8" ~ $nel ~ "<h3>Bad Request</h3>";

our $http-header_404 is export = "HTTP/1.1 404 Not Found" ~ $nl ~ "Content-Type: text/html;charset=utf-8" ~ $nel ~ "<h3>Not Found</h3>";

our $http-header_413 is export = "HTTP/1.1 413 Request Entity Too Large" ~ $nl ~ "Content-Type: text/html;charset=utf-8" ~ $nel ~ "<h3>Request Entity Too Large</h3>";

our $http-header_500 is export = "HTTP/1.1 500 Internal Server Error" ~ $nl ~ "Content-Type: text/html;charset=utf-8" ~ $nel ~ "<h3>Internal Server Error</h3>";
