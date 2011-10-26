#!/usr/local/bin/perl -w
use strict;
use warnings;

# http://dev.mysql.com/doc/refman/4.1/ja/date-and-time-functions.html MySQL �I�t�B�V�����T�C�g�F ���t�Ǝ����֐�
#
# �O�D�����ݒ�
# �P�D�N�b�L�[�ɂ��F��
# �Q�D�t�H�[���̒l��ǂݍ���
# �R�D�f�[�^�x�[�X�ɏ�������
# �S�Dindex�ɃW�����v

#========= �O�D�����ݒ� ====================
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI;
use DBI;

#=========== �P�D�N�b�L�[�ɂ��F�� ========
require "auth.pl";
my ($u_id,$user,$dbh,$pw) = &auth::authorization();

#========== �Q�D�t�H�[���̒l��ǂݍ��� ======
my $q = new CGI;
my $kisho   = $q->param('kisho');
my $year    = $q->param('year');
my $month   = $q->param('month');
my $day     = $q->param('day');
my $shushin = $q->param('shushin');
my $memo    = $q->param('memo');
$kisho .= "00" ;
$shushin.= "00"	;
# �����Ŋe�ϐ��̐��`������K�v����B

# ���ԍ��̒���
my $addTime = ($kisho < $shushin) ? "240000" : "000000" ;

#======== �R�D�f�[�^�x�[�X�ɏ������� =============
my $sql_test ="INSERT INTO `s_$u_id` ( `ts` , `date` , `kisho_time` , `shushin_time` , `sleep` , `memo` ) 
VALUES (NOW( ) , '$year-$month-$day', '$kisho', '$shushin', ADDTIME(TIMEDIFF($kisho,$shushin),$addTime) , '$memo');";

my $r = $dbh->do($sql_test);

#$sth->finish;
$dbh->disconnect;

#=========== �S�Dindex�ɃW�����v ================
print "Location: ./\n\n";
exit;