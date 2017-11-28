unit module Response;

use Configuration;
use URI;
use URI::Escape;
use WriteAccessLog;
use WriteErrorLog;
use ContentType;
use ResponseHeaders;

sub response(:$buf, :$current-dir, :$default-html, :%webservices) is export {

  # get generic exceptions, write them in error.log and return HTTP 500 error
  CATCH {
    default {
      write-error-log $_;
      return response-headers(500,'text/html') ~ '<h3>Internal Server Error</h3>';
    }
  }

  # validations
  # check http entity max size
  if $buf.elems > $max-size-bytes-http-entity {
    # too long, return 413 error
    return response-headers(413,'text/html') ~ '<h3>Request Entity Too Large</h3>';
  }

  # processing received http headers
  my Int $i = 0;
  # iterate $buf increasing $i and matching \r\n\r\n via dec code
  until ($buf[$i] == 13) && ($buf[$i+1] == 10) && ($buf[$i+2] == 13) && ($buf[$i+3] == 10) { $i++; }
  # extract headers, body and decoding to utf-8
  my $headers = $buf.subbuf(0, ($i-1)).decode('UTF-8');
  my $body = $buf.subbuf(($i+4), $buf.elems).decode('UTF-8');

  # initialize method, uri and protocol info from headers
  my ($method, $uri-full, $protocol) = "";

  # assign http method, full uri and http protocol version
  if $headers ~~ m:g:i:s/(GET|POST) (\/.*?) (HTTP\/.*?)/ {
    $method   = $/[0][0].Str;
    $uri-full = $/[0][1].Str;
    $protocol = $/[0][2].Str;
  } else {
      # incorrect headers, return 400 Bad Request
      write-log 'Bad Request';
      return response-headers(400,'text/html') ~ '<h3>Bad Request</h3>';
  }

  # session control if True
  if $session-mode-on {
    use Sessions;
    session-cookie $headers;
  }

  # extract uri path and GET params
  my URI $uri .= new($uri-full);
  my $path = uri-unescape($uri.path);
  my $get-params = uri-unescape($uri.query);

  # shows processed incoming data, for debugging purposes
  # use WriteLog;
  # write-log :$method, :$path, :$get-params, :$body;

  # write access log
  write-access-log :$method, :$path, :$get-params;

  # preparing response from given path
  given $path {

    # if there are webservices
    when %webservices{"$_"}:exists {
      my ( &ws, $direct-type ) = %webservices{"$_"};
      my $type = content-type(:$direct-type);
      return response-headers(200, $type) ~ &ws(:$get-params, :$body);
    }

    # file in path not exists, returns 404 http code
    when !("$current-dir/public/$_").IO.e {
      return response-headers(404,'text/html') ~ '<h3>Not Found</h3>';
    }

    # the path is the public root dir, returns default public file
    when $_ eq "\/" {
      return response-headers(200,'text/html') ~ slurp "$current-dir/public/$default-html";
    }

    # the path is another file, returns it!
    # with the corresponding content-type
    default {
      my $filepath = "$current-dir/public/$path";
      my $type = content-type(:$filepath);
      return response-headers(200, $type) ~ slurp "$current-dir/public/$path";
    }
  }
}
