#!/usr/local/bin/perl
use strict;
use warnings;
# FROM�̒l���Z�b�V����ID�ɕϊ����āA�N�b�L�[�𑗂�����index�ɃW�����v�B

use CGI;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI::Cookie;
require "lib.pl";

my $q = new CGI;
my $user = $q->param('user');
my $PW = $q->param('pw');
my $sticky = $q->param('sticky');
my $hashedPW = &lib::toHash($PW);

#==== FORM���痈�����[�U���ƃp�X���[�h��DB�Əƍ��B�}�b�`���Ȃ���΁A�G���[��ʂ�Ԃ� ====


#==== �}�b�`������Z�b�V����ID�N�b�L�[�𔭍s =====
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