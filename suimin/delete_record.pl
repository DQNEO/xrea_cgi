#!/usr/local/bin/perl -w
use strict;
use warnings;

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
my $record_id   = $q->param('record_id');


#======== �R�D�f�[�^�x�[�X�ɏ������� =============
my $sqlSentence ="
 DELETE FROM s_$u_id WHERE record_id=$record_id LIMIT 1;
";
my $r = $dbh->do($sqlSentence);

#$sth->finish;
$dbh->disconnect;

#=========== �S�Dindex�ɃW�����v ================
print "Location: ./\n\n";
exit;