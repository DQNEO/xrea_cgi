package auth;

use strict;
use warnings;
#use Data::Dumper;
#==================== SUB ROUTINE =======================================
sub authorization{
	require 'lib.pl';
	#use DBI;
	#http://perldoc.jp/docs/modules/CGI.pm-2.89/CGI/Cookie.pod
	my $q = new CGI;
	my $s_id = $q->cookie('s_id');							# �֥饦����HTTP�ꥯ�����ȥإå��Υ��å��������
	my ($user,$PWfromCk) = ();							
	($user,$PWfromCk ) = split(/___/,$s_id);		# �桼��̾�ȥѥ���ɤ�ʬ��
	#========= ����ơ��֥�ˤ����Ȥ߹�碌��¸�ߤ��뤫�����å� ============
	#======== �ۤ�ȤϤ����ǲ���ơ��֥�Ⱦȹ礹��٤��ǤϤʤ������å����ID�ΥХ�ǡ������򤹤٤���===
	#--- DB����³ ---
	my ($DSN, $DBuser, $DBpswd) = &lib::setDBH();
	my $dbh = DBI->connect($DSN, $DBuser, $DBpswd);
	#--- SQL��ȯ�� ---
	my $sth = $dbh->prepare("SELECT * FROM s_user WHERE user = \"$user\";");
	$sth->execute;
	my $RowsCount = $sth->rows;					#	SELEC�Υҥåȥ쥳���ɿ�
	my(@data) = $sth->fetchrow_array;
	my $u_id = $data[0];
	my $PWinDB = $data[2];
	$sth->finish;

	if($RowsCount && $PWfromCk eq $PWinDB ){
		return ( $u_id, $user, $dbh );		 # ǧ�ڤ�����������main�����
	}else{
		&askLogin($user, $RowsCount, $PWfromCk, $PWinDB, $dbh);					# ǧ�ڤ˼��Ԥ�����������׵�ڡ������Ǥ��Ф���
	}
}	#  END sub


sub askLogin{
my( $user, $RowsCount, $PWfromCk, $PWinDB,$dbh ) = @_ ;
my $errMsg = "";
#if( $RowsCount == 0 || $PWfromCk ne $PWinDB){ $errMsg = "������Ǥ��ޤ���Ǥ�����" ;}
#$errMsg = "<p id='err'>".$errMsg."</p>";

$dbh->disconnect;
print <<EOF;
Location: login.pl

EOF
exit;
}

;1;
