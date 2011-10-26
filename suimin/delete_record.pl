#!/usr/local/bin/perl -w
use strict;
use warnings;

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
my $record_id   = $q->param('record_id');


#======== ３．データベースに書き込み =============
my $sqlSentence ="
 DELETE FROM s_$u_id WHERE record_id=$record_id LIMIT 1;
";
my $r = $dbh->do($sqlSentence);

#$sth->finish;
$dbh->disconnect;

#=========== ４．indexにジャンプ ================
print "Location: ./\n\n";
exit;