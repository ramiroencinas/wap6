unit module ContentType;

sub content-type(:$filepath) is export {

  my %hash = (
    css  => 'text/css',
    gif  => 'image/gif',
    htm  => 'text/html;charset=UTF-8',
    html => 'text/html;charset=UTF-8',
    ico  => 'image/x-icon',
    jpeg => 'image/jpeg',
    jpg  => 'image/jpeg',
    js   => 'application/javascript',
    json => 'application/json;charset=UTF-8',
    pdf  => 'application/pdf',
    png  => 'image/png',
    xml  => 'application/xml',
    zip  => 'application/zip'
  );


  if %hash{$filepath.IO.extension.lc}:exists {
    return %hash{$filepath.IO.extension.lc}
  }

  return 'text/plain;charset=UTF-8';

}
