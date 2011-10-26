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
	my $s_id = $q->cookie('s_id');							# ブラウザのHTTPリクエストヘッダのクッキーを取得
	my ($user,$PWfromCk) = ();							
	($user,$PWfromCk ) = split(/___/,$s_id);		# ユーザ名とパスワードを分割
	#========= 会員テーブルにその組み合わせが存在するかチェック ============
	#======== ほんとはここで会員テーブルと照合するべきではなく、セッションIDのバリデーションをすべき。===
	#--- DBに接続 ---
	my ($DSN, $DBuser, $DBpswd) = &lib::setDBH();
	my $dbh = DBI->connect($DSN, $DBuser, $DBpswd);
	#--- SQLを発行 ---
	my $sth = $dbh->prepare("SELECT * FROM s_user WHERE user = \"$user\";");
	$sth->execute;
	my $RowsCount = $sth->rows;					#	SELECのヒットレコード数
	my(@data) = $sth->fetchrow_array;
	my $u_id = $data[0];
	my $PWinDB = $data[2];
	$sth->finish;

	if($RowsCount && $PWfromCk eq $PWinDB ){
		return ( $u_id, $user, $dbh );		 # 認証に成功したらmainに戻る
	}else{
		&askLogin($user, $RowsCount, $PWfromCk, $PWinDB, $dbh);					# 認証に失敗したらログイン要求ページを吐き出す。
	}
}	#  END sub


sub askLogin{
my( $user, $RowsCount, $PWfromCk, $PWinDB,$dbh ) = @_ ;
my $errMsg = "";
#if( $RowsCount == 0 || $PWfromCk ne $PWinDB){ $errMsg = "ログインできませんでした。" ;}
#$errMsg = "<p id='err'>".$errMsg."</p>";

$dbh->disconnect;
print <<EOF;
Location: login.pl

EOF
exit;
}

;1;
