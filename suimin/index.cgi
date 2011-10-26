#!/usr/local/bin/perl -w
use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use DBI;
#========== ���å����ˤ��ǧ�� ====================
require "auth.pl";
my ($u_id,$user,$dbh) = &auth::authorization();
#============ Settings ========================
my (undef, $min, $hour, $day, $month, $year, $wday) = localtime(time());
$year += 1900;
$month += 1;
my $CurTime=sprintf("%02d%02d",$hour,$min);
my %kisho;
my @tr = ();
#=======  DB���ɤ߽Ф����ѿ��˳�Ǽ ===============
my $sth = $dbh->prepare("SELECT * FROM s_$u_id ORDER BY date DESC;");
$sth->execute;
my $CountRows = $sth->rows;
for (my $i=0; $i<$CountRows; $i++) {
	my @data = $sth->fetchrow_array;
	$kisho{"$data[2]"} = substr($data[3],0,5);
	my $shushin = substr($data[4],0,5);
	my $sleep = substr($data[5],0,5);
	my $yyyymmdd = $data[2];
	$yyyymmdd =~ s/-/\//ig; 

	$tr[$i] = "<tr><td class='usuku'>$data[0]</td><td>$data[2]</td><td>$shushin</td><td>��</td><td>$kisho{$data[2]}</td><td>$sleep</td><td>$data[6]</td>";
	$tr[$i] .="<td><a href='delete_record.pl?record_id=$data[0]'>���</a></td>";
	$tr[$i] .="<td><a href=modify_view.pl?record_id=$data[0]&date=$data[2]&kisho=$data[3]&shushin=$data[4]&sleep=$data[5]&memo=$data[6]>����</a></td>";
	$tr[$i] .="</tr>\n";
}


$sth->finish;
#============ HTML �إå���ɽ��  ========================
print <<"EOF";
Content-type: text/html; charset=euc-jp

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-jp">
<!--��-->
<title>$user�Τ����ߤ�Ͽ</title>
<style type="text/css">
 .weekend { background:pink; }
 .usuku { color:silver; }
</style>
</head>
<body><center>
<h1 style='color:blue;'>�����ߤ�Ͽ</h1>
<div align='right'><b>$user����</b>|$u_id|<a href='logout.pl'>��������</a></div>

EOF
#============  ����Υ���������ɽ��  ==================
&show_calender();	
#========= FORM��ʬ��ɽ�� ===============================
print <<"EOF";

    <form name=f1 method=post action='add_record.pl'>
<table>
<tr>
	<td>ǯ</td>
	<td>��</td>
	<td>��</td>
</tr>
<tr>
	<td><input type=text name=year value="$year" size=4></td>
	<td><input type=text name=month value="$month" size=2></td>
	<td><input type=text name=day value="$day" size=2  istyle=4></td>
</tr>
<tf>
	<td>����</td>
	<td>����</td>
	<td>���</td><br>
</tr>
<tr>
	<td><input type=text name=shushin value="" size=4  istyle=4></td>
	<td><input type=text name=kisho value="$CurTime" size=4  istyle=4></td>
	<td><input type=text name=memo size=14><td>
</tr>
</table>
<br>
<input type=submit value=����>
   </form>
EOF

#=========================================================

#============= �쥳���ɤ�ɽ�� ===================
print "<br>�쥳��������:$CountRows<br>\n";
print "<table><tr><td class='usuku'>record_id</td><td>����</td><td>����</td><td></td><td>����</td><td>��̲</td><td>���</td></tr>\n";
foreach (@tr) {
	print;
}
print "</table>\n";



print <<EOF;

    <hr width=300>
    <font size=-1>&copy;2006 DQN</font><br>
$ENV{'HTTP_COOKIE'};
 </center>
 </body>
</html>
EOF
$dbh->disconnect;
#================ END ========================
exit;
#============ FUNCTION ====================
#	����������ɽ��
sub show_calender{
	require '../lib/mylib.pl';

	#Settings
	my @youbi = ("��","��","��","��","��","��","��");
	my $class = "";
	my($sec,$min,$hour,$tday,$mon,$year,$wdy,$ydy,$isdst) = localtime();
	$year += 1900;	$mon++;
	my $eom = &mylib::GetEom($year,$mon);
	my $syoubi = &mylib::youbi_n($year,$mon,1);   


	# print HTML
#	print "Content-type: text/html\n\n";

	print "<table border=1>\n";
	print "<tr><td colspan=7 align=center>$yearǯ$mon��</td></tr>\n";
	print "<tr>";
		for(my $i=0;$i<7;$i++){ print "<td>$youbi[$i]</td>"; }
	print "</tr>\n";

	print "<tr>";
	my $col = 0;
	for(my $i=0;$i<$syoubi;$i++){
		print "<td></td>";
		$col++;
	}
	for(my $i=1;$i<=$eom;$i++){
	#	$str = "<b>".$i."</b>";
	#	$str = $i;
		if($col == 6 or $col == 0){
			 $class = "weekend"; 
		}else{
			$class = "weekday";
		}						
		my $str = ($i==$tday) ? "<b>".$i."</b>": $i ;		#	���黻��
		my $kishotime = sprintf("%04d-%02d-%02d",$year,$mon,$i);
		print "<td class=$class>$str<br> $kisho{$kishotime}</td>";
		$col++;
		if($col==7){
			print "</tr>\n<tr>";
			$col = 0;
		}
	}
	print "</tr></table>\n";
}