#!/usr/bin/perl

use DBI;
use CGI::Carp qw( fatalsToBrowser );
use CGI;

#=========== �������å����ˤ��ǧ�� ========
require "auth.pl";
my ($u_id,$user,$dbh,$pw) = &auth::authorization();
#======== �����ǡ����١����˽񤭹��� =============
my $sql_test = "
UPDATE s_24 SET
 date = '2001-01-01',
 kisho_time = '13:54:00',
 shushin_time = '4:00:00',
 sleep = '8:0:00',
 memo = 'amema'

 where record_id=24
";

$r = $dbh->do($sql_test);

$dbh->disconnect;

#=========== ����index�˥����� ================
print "Content-type: text/html\n\n";
print "$sql_test";
exit;