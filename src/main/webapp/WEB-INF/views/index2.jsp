<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- index2.jsp -->
<html>
<head>
 <title>index</title>
</head>
<body>
	<h1>spring���� �غ���  ���α׷�</h1>
	<h1>���缼��</h1><br>
	<b>${sessionScope.userId} , ${sessionScope.userGrade }</b>
	
	<ul>
		<li><a href="login.login">�α������� ����</a></li>
		<li><a href="naver_mail.do">���̹� ���� ����</a>
		<li><a href="gmail.do">gmail ����</a>
		
	</ul>
</body>
</html>