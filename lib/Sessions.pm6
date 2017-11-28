unit module Sessions;

use Configuration;

sub session-cookie ($headers) is export {

  # extract session cookie from headers if exists
  my $session-cookie = '';

  if $headers ~~ m:g:i:s/^^Cookie\: $sessionidname\=(.*?)$$/ {
    $session-cookie = $/[0][0].Str;
  } else {
    $session-cookie = 'no-wap6-session-cookie';
  }

  # if no session cookie from client headers
  # creates a new one in $current-session-id global var
  # and add it to session file with current timestamp
  if ( $session-cookie eq 'no-wap6-session-cookie' ) {

    # new reg in $sessionsfile
    my $header = "Sessions file\n";

    # generate new session id
    $current-session-id = 'new-token-here';

    # with this the response headers will include the set-cookie
    $session-cookie-exists = False;

    my $line = DateTime.now ~ " $current-session-id\n";

    # check if sessions file exists. if not, spurt one!
    unless $sessionsfile.IO.e { spurt $sessionsfile, $header; }

    # append session line
    spurt $sessionsfile, $line, :append;

  } else {
    # the client has a session cookie

    ####### check if received $session-cookie exists in the server ... ######
    # if not exists set new one in the client with $session-cookie-exists = False;
    # if the $session-cookie received exists, it is ok:
    $session-cookie-exists = True;

    # write it in $current-session-id global var
    $current-session-id = $session-cookie;

    # and write it in some log...
  }
}
