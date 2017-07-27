unit module Webservices;

# Webservice 1, returns the inconming data
sub ws1 ( :$get-params, :$body ) is export {
  if $get-params { return 'From ws1: ' ~ $get-params; }
  if $body { return 'From ws1: ' ~ $body; }
}

# Webservice 2, returns the inconming data in JSON
sub ws2 ( :$get-params, :$body ) is export {
  if $get-params { return '{"ws2":"From ws2: ' ~ $get-params ~ '"}'; }
  if $body { return '{"ws2":"From ws2: ' ~ $body ~ '"}'; }
}

# Webservice ws-fileops, read file or add elements to file
sub ws-fileops ( :$get-params, :$body ) is export {

  if $get-params ~~ /^read/ {
    return 'bbdd.txt'.IO.slurp;
  }

  if $get-params ~~ m:g/^'add='(.*?)$/ {
    spurt 'bbdd.txt', $/[0][0] ~ "\n", :append;
    return 'Done!';
  }

  return "Nothing to do.";

}
