#!/usr/local/bin/perl -w
use strict;
use warnings;

# ０．初期設定
# １．クッキーによる認証
# ２．フォームの値を読み込み
# ３．HTML表示
# ４．データベースに書き込み

#========= ０．初期設定 ====================
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI;
use DBI;

#=========== １．クッキーによる認証 ========
require "auth.pl";
my ($u_id,$user,$dbh,$pw) = &auth::authorization();

#========== ２．フォームの値を読み込み ======
my $q = new CGI;
my $record_id = $q->param('record_id');
my $date = $q->param('date');
my $kisho = $q->param('kisho');
my $shushin = $q->param('shushin');
my $sleep = $q->param('sleep');
my $memo = $q->param('memo');
#======== ３．HTML表示 =============
print <<"EOF";
Content-type: text/html

<h1>修正画面</h1>
<p>record_id:$record_id</p>
<form action="do_modify.pl">
<table>
<tr><td>日付</td><td>就寝</td><td>起床</td></tr>
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
#======== ４．データベースに書き込み =============

#=========== ４．indexにジャンプ ================
exit;