#!/usr/local/bin/perl -w
use strict;
use warnings;

# http://dev.mysql.com/doc/refman/4.1/ja/date-and-time-functions.html MySQL オフィシャルサイト： 日付と時刻関数
#
# ０．初期設定
# １．クッキーによる認証
# ２．フォームの値を読み込み
# ３．データベースに書き込み
# ４．indexにジャンプ

#========= ０．初期設定 ====================
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI;
use DBI;

#=========== １．クッキーによる認証 ========
require "auth.pl";
my ($u_id,$user,$dbh,$pw) = &auth::authorization();

#========== ２．フォームの値を読み込み ======
my $q = new CGI;
my $kisho   = $q->param('kisho');
my $year    = $q->param('year');
my $month   = $q->param('month');
my $day     = $q->param('day');
my $shushin = $q->param('shushin');
my $memo    = $q->param('memo');
$kisho .= "00" ;
$shushin.= "00"	;
# ここで各変数の整形をする必要あり。

# 時間差の調整
my $addTime = ($kisho < $shushin) ? "240000" : "000000" ;

#======== ３．データベースに書き込み =============
my $sql_test ="INSERT INTO `s_$u_id` ( `ts` , `date` , `kisho_time` , `shushin_time` , `sleep` , `memo` ) 
VALUES (NOW( ) , '$year-$month-$day', '$kisho', '$shushin', ADDTIME(TIMEDIFF($kisho,$shushin),$addTime) , '$memo');";

my $r = $dbh->do($sql_test);

#$sth->finish;
$dbh->disconnect;

#=========== ４．indexにジャンプ ================
print "Location: ./\n\n";
exit;