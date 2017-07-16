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
