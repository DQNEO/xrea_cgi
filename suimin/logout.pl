#!/usr/local/bin/perl
# ���å����ID���å���������Ĥ��ơ�./ (index.*)�˥�����쥯�Ȥ��롣
use strict;
use warnings;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);

use CGI;
use CGI::Cookie;

my $q = new CGI;
#my $s_id = $q->cookie('s_id');		# �桼���Υ��å������ɤ߹��ࡣɬ�פϤʤ����⡩

my $c = new CGI::Cookie( -name=>"s_id", -value=>"" , -expires=>"-10y"  );		# ���δ����Υ��å�����ȯ�ԡʾõ��

print "Set-Cookie: $c\n";
print "Location: ./\n\n";
exit;