package lib;

sub toHash{
 use strict;
 use Digest::SHA1;
 
 my $rowData = $_[0];

 my $sha1 = Digest::SHA1->new;
 $sha1->add($rowData);
 my $hashData = $sha1->b64digest;

  return ($hashData);
}

sub setDBH{
 my $DBuser = 'userhoge';
 my $DBpswd = 'himitu';
 my $DSN = 'DBI:mysql:dqn:localhost';
 my @array = ( $DSN, $DBuser, $DBpswd );
 return @array;
}

;1;
