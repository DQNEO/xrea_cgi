#!/usr/local/bin/perl
use strict;
use warnings;
# FROMの値をセッションIDに変換して、クッキーを送りつけるとindexにジャンプ。

use CGI;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI::Cookie;
require "lib.pl";

my $q = new CGI;
my $user = $q->param('user');
my $PW = $q->param('pw');
my $sticky = $q->param('sticky');
my $hashedPW = &lib::toHash($PW);

#==== FORMから来たユーザ名とパスワードをDBと照合。マッチしなければ、エラー画面を返す ====


#==== マッチしたらセッションIDクッキーを発行 =====
if ($sticky eq "on"){
	my $c = new CGI::Cookie( -name => "s_id", -value=> "$user"."___$hashedPW", -expires=>"+1M"); #
	print "Set-Cookie: $c\n";
}else{
	my $c = new CGI::Cookie( -name => "s_id", -value=> "$user"."___$hashedPW"); #
	print "Set-Cookie: $c\n";

}

print "Location: ./\n\n";

# debug
#print <<"EOF";
#Content-type: text/html
#
#Set-Cookie: $c
#EOF


exit;