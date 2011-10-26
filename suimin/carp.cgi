#!/usr/local/bin/perl -w
# CGI::Carp‚Ì‚Ð‚È‚ª‚½
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);

print "Content-type: text/html;\n\n";
warningsToBrowser(1);
print <<EOM;
<html>
<head><title>sample</title></head>
<body>
ƒTƒ“ƒvƒ‹ = $sample<br>
</body>
</html>
EOM

exit;