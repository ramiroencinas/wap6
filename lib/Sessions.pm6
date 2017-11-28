unit module Sessions;

use Configuration;

sub session-cookie (:$headers) is export {

  my $session-cookie = get-session-cookie (:$headers);

  # if no session cookie from client headers
  # creates a new one in $current-session-id global var
  # and add it to session file with current timestamp
  if ( $session-cookie eq 'no-wap6-session-cookie' ) {

    # new reg in $sessionsfile
    my $header = "Sessions file\n";

    # generate logline
    $current-session-id = 'new-token-here';

    my $line = DateTime.now ~ " $current-session-id\n";

    # check if sessions file exists. if not, spurt one!
    unless $sessionsfile.IO.e { spurt $sessionsfile, $header; }

    # append session line
    spurt $sessionsfile, $line, :append;

  } else {
    # the client has a session cookie
    # write it in $current-session-id global var
    $current-session-id = $session-cookie;

    # and write it in some log...
  }
}

# extract session cookie from headers if exists
sub get-session-cookie (:$headers) {

  if $headers ~~ m:g:i:s/Cookie: $session-id-name=(.*?)\;/ {
    return $/[0][0].Str;
  } else {
    return 'no-wap6-session-cookie';
  }
}
