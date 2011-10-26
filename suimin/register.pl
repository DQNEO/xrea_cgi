#!/usr/local/bin/perl
use CGI;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI::Cookie;	#ref:http://2php.jp/mysql/insert.html
use DBI;
require 'lib.pl';

$q = new CGI;
$user = $q->param('user');
$PW = $q->param('password');
$hashedPW = &lib::toHash($PW);

my ($DSN, $DBuser, $DBpswd) = &lib::setDBH();
$dbh = DBI->connect( $DSN, $DBuser, $DBpswd );

$sql1 = " INSERT INTO s_user VALUES (null,'$user','$hashedPW'); ";
$sql2 = "SELECT * FROM s_user WHERE user = '$user';	";

$r = $dbh->do($sql1);


if( $r == 1 ) {
$sth = $dbh->prepare($sql2);
$sth->execute;
my @data = $sth->fetchrow_array;
$u_id = $data[0];
$sth->finish;
$sth = $dbh->prepare("CREATE TABLE s_$u_id
     (
			record_id INT(10) NOT NULL AUTO_INCREMENT,
			ts TIMESTAMP NOT NULL,
			date DATE NOT NULL,
			kisho_time TIME,
			shushin_time TIME,
			sleep TIME,
			memo TEXT,
     PRIMARY KEY(record_id)
     );"
);
$sth->execute;
$sth->finish;
my $c = new CGI::Cookie(-name => 's_id',
                        -value=> "$user"."___$hashedPW" ,
			-expires=> "+10s"
 );

print <<EOF;
Set-Cookie: $c
Content-type: text/html

<meta http-equiv="Refresh" content="3; URL=./">
id=$u_id<br>
$userさんを登録しました。<br><br>
dbh->do("$sql1")の結果: $r<br><br>
<a href='./'>ホームへ</a>
EOF
$dbh->disconnect;

}else{ 
print <<EOF;
Content-type: text/html

登録に失敗しました。<p>
sql1:$sql1
EOF
$dbh->disconnect;
} 

exit;

