#!/usr/local/bin/perl -w
use strict;
use warnings;

# �����������
# �������å����ˤ��ǧ��
# �����ե�������ͤ��ɤ߹���
# ����HTMLɽ��
# �����ǡ����١����˽񤭹���

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
my $date = $q->param('date');
my $kisho = $q->param('kisho');
my $shushin = $q->param('shushin');
my $sleep = $q->param('sleep');
my $memo = $q->param('memo');
#======== ����HTMLɽ�� =============
print <<"EOF";
Content-type: text/html

<h1>��������</h1>
<p>record_id:$record_id</p>
<form action="do_modify.pl">
<table>
<tr><td>����</td><td>����</td><td>����</td></tr>
<tr>
	<td><input type=text name=date value=$date></td>
	<td><input type=text name=shushin value=$shushin></td>
	<td><input type=text name=kisho value=$kisho></td>
</tr>
</table>
	<br>
	<input type=text name=memo value=$memo><br>
	<input type=hidden name=record_id value=$record_id>
	<input type=submit>
</form>

EOF
#======== �����ǡ����١����˽񤭹��� =============

#=========== ����index�˥����� ================
exit;