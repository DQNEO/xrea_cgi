#!/usr/local/bin/perl -w
# CGI::Carp�̂ЂȂ���
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);

print "Content-type: text/html;\n\n";
warningsToBrowser(1);
print <<EOM;
<html>
<head><title>sample</title></head>
<body>
�T���v�� = $sample<br>
</body>
</html>
EOM

exit;