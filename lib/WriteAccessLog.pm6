unit module WriteAccessLog;

use Configuration;

# write access log to access.log
sub write-access-log (:$method, :$path, :$get-params) is export {

  my $header = "Wap6 Log access file\n";

  # generate logline
  my $logline = DateTime.now ~ " $method $path $get-params\n";

  # check if access log file exists. if not, spurt one!
  unless $accesslogfile.IO.e { spurt $accesslogfile, $header; }

  # if access log file size > max then overwrite entire file
  if $accesslogfile.IO.s > $max-size-access-log {
    spurt $accesslogfile, $header;
  }

  # append access log line
  spurt $accesslogfile, $logline, :append;

}
