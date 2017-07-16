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

  return %codes{"$status-code"} ~ $nl ~ 'Content-Type: ' ~ $content-type ~ $nel;
}
