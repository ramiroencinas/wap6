unit module ResponseHeaders;

use Configuration;

sub response-headers($status-code, $content-type) is export {

  my %codes = (
    200 => 'HTTP/1.1 200 OK',
    400 => 'HTTP/1.1 400 Bad Request',
    404 => 'HTTP/1.1 404 Not Found',
    413 => 'HTTP/1.1 413 Request Entity Too Large',
    500 => 'HTTP/1.1 500 Internal Server Error'
  );

  my $response-headers = %codes{"$status-code"} ~ $nl ~ 'Content-Type: ' ~ $content-type ~ $nl;

  # add wap6-session cookie to response headers, with $current-session-id
  # if $session-mode-on
  # and
  # the session cookie not exists
  if $session-mode-on && !$session-cookie-exists {
    $response-headers ~= "Set-Cookie: $sessionidname=$current-session-id;Secure;HttpOnly" ~ $nl;
  }

  return $response-headers ~ $nl;
}
