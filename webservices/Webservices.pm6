unit module Webservices;

# Webservice 1, returns the inconming data
sub ws1 ( :$get-params, :$body ) is export {
  if $get-params { return 'From ws1: ' ~ $get-params; }
  if $body { return 'From ws1: ' ~ $body; }
}

# Webservice 2, returns the inconming data
sub ws2 ( :$get-params, :$body ) is export {
  if $get-params { return 'From ws2: ' ~ $get-params; }
  if $body { return 'From ws2: ' ~ $body; }
}
