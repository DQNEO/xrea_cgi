#!/usr/local/bin/perl
open(OUT,">>log.txt");
print OUT localtime()."\n";
open(IN,"log.txt");
print "Content-type: text/html\n\n";
print "<pre>",(reverse <IN>),"</pre>";
