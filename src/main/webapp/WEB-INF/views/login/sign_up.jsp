<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- sign_up.jsp -->
<html>
<head>
<title>ȸ �� �� ��</title>
</head>
<body>
	<form name="f" method="post" action="sign_up_ok.login">
		<input type="text" name="name" placeholder="�̸�"><br>
		<input type="text" name="id" placeholder="���̵�"><br>
		<input type="password" name="passwd" placeholder="��й�ȣ"><br>
		<input type="hidden" name="email" value="${sessionScope.email}">
		<input type="submit" value="Ȯ��">
		<input type="button" value="���" onclick="javascript:cancel()">
	</form>
</body>
</html>