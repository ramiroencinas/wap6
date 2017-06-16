unit module WriteErrorLog;

use Configuration;

# write access log to access.log
sub write-error-log ($errormessage) is export {

  my $header = "Wap6 Log error file\n";

  # generate logline
  my $logline = DateTime.now ~ " $errormessage\n";

  # check if error log file exists. if not, spurt one!
  unless $errorlogfile.IO.e { spurt $errorlogfile, $header; }

  # if error log file size > max then overwrite entire file
  if $errorlogfile.IO.s > $max-size-error-log {
    spurt $errorlogfile, $header;
  }

  # append error log line
  spurt $errorlogfile, $logline, :append;

}
