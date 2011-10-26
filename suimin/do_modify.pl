#!/usr/local/bin/perl -w
use strict;
use warnings;

# http://dev.mysql.com/doc/refman/4.1/ja/date-and-time-functions.html MySQL ���ե�����륵���ȡ� ���դȻ���ؿ�
#
# �����������
# �������å����ˤ��ǧ��
# �����ե�������ͤ��ɤ߹���
# �����ǡ����١����˽񤭹���
# ����index�˥�����

#========= ����������� ====================
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI;
use DBI;

#=========== �������å����ˤ��ǧ�� ========
require "auth.pl";
my ($u_id,$user,$dbh,$pw) = &auth::authorization();

#========== �����ե�������ͤ��ɤ߹��� ======
my $q = new CGI;
my $record_id = $q->param('record_id');
my $date     = $q->param('date');
my $kisho   = $q->param('kisho');
my $shushin = $q->param('shushin');
my $memo    = $q->param('memo');
$kisho .= "00" ;
$shushin.= "00"	;
# �����ǳ��ѿ��������򤹤�ɬ�פ��ꡣ

# ���ֺ���Ĵ��
my $addTime = ($kisho < $shushin) ? "240000" : "000000" ;

#======== �����ǡ����١����˽񤭹��� =============
my $sql_test = "
UPDATE s_$u_id SET
 date = '$date',
 kisho_time = '$kisho',
 shushin_time = '$shushin',
 sleep = ADDTIME(TIMEDIFF('$kisho','$shushin'),'$addTime'),
 memo = '$memo'

 where record_id=$record_id
";

my $r = $dbh->do($sql_test);

$dbh->disconnect;

#=========== ����index�˥����� ================
print "Location: ./\n\n";
exit;