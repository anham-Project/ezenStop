<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- find.jsp -->
<html>
<head>
<title>���̵�/��й�ȣ ã��</title>
</head>
<body>
	<form name="f" method="post" action="find_id.login">
		<h1>���̵� ã��</h1><br>
		<input type="text" name="name" placeholder="�̸�"><br>
		<input type="text" name="email" placeholder="�̸���"><br>
		<input type="submit" value="ã��">
	</form>
	<form name="f" method="post" action="find_passwd.login">
		<br><br><br>
		<h1>��й�ȣ ã��</h1>
		<input type="text" name="name" placeholder="�̸�"><br>
		<input type="text" name="email" placeholder="�̸���"><br>
		<input type="text" name="id" placeholder="���̵�"><br>
		<input type="submit" value="ã��">
		<input type="button" value="���" onclick="javascript:cancel()">
	</form>
</body>
</html>