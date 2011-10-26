#!/usr/bin/perl

print <<"EOF";
Content-type: text/html

<html><head>
<style>
body {
	width: 350px;
	margin: 10% auto;
	background: #fff;
	text-align: center;
	font-size: small;
	font-family: "Osaka ", "�ҥ饮�γѥ� Pro W3", "Hiragino Kaku Gothic Pro", "�ͣ� �Х����å�", "MS Gothic";
}
#loginBox {
	text-align: center;
	width: 330px;
	padding: 8px 9px;
	border: solid 1px #D3D3D3;
	background: #fff;
}
#logo {
	float: left;
	width: 200px;
	margin: 10px 0px 20px 30px;
	padding: 0px;
	color:#333;
}
#formBox {
	clear: both;
	padding: 10px 0px 0px 0px;
	text-align: center;
	width: 250px;
	margin: 0px auto;
}
dl {	margin: 0;	padding: 0;	}
dt {
	clear: both;
	float: left;
	width: 80px;
	margin: 0px 5px 0px 0px;
	padding: 0;
	text-align: right;
}
dd {
	float:left;
	width: 165px;
	margin: 0px;
	padding: 0px;
	text-align: left;
}
#register {	clear: both;	padding: 10px 0px 0px 0px;	}
#err			{	color:red;	}
</style></head>
<body>

<div id="loginBox">
	$errMsg
	<h1 id="logo">�����ߤ�Ͽ</h1>
	<!--br>ǧ�ڤ˼��Ԥ����Τǡ������󤷤Ƥ���������<br>
	�����������Ȥˡ����������å�����񤭹��ߤޤ���<br>
	<br-->
	<form action=do_login.pl method=get id="formBox">
		<dl>
			<dt>�桼��̾:</dt>
			<dd><input type=text name=user id="id" size=20></dd>
			<dt>�ѥ����:</dt>
			<dd><input type=password name=pw id="passwd" size=15> <br><input type="checkbox" name="sticky" value="on"> �ѥ���ɤ���¸ </dd>
		</dl>
		<input type=submit value="������">
	</form>
	<p id="register">�����桼����Ͽ��<a href="register.html">������</a></p>
</div>
$ENV{'HTTP_COOKIE'}<br>
</body></html>
EOF
