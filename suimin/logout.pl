#!/usr/local/bin/perl
# セッションIDクッキーを送りつけて、./ (index.*)にリダイレクトする。
use strict;
use warnings;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);

use CGI;
use CGI::Cookie;

my $q = new CGI;
#my $s_id = $q->cookie('s_id');		# ユーザのクッキーを読み込む。必要はないかも？

my $c = new CGI::Cookie( -name=>"s_id", -value=>"" , -expires=>"-10y"  );		# 過去の期日のクッキーを発行（消去）

print "Set-Cookie: $c\n";
print "Location: ./\n\n";
exit;