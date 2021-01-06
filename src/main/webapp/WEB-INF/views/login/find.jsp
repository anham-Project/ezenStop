<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- find.jsp -->
<html>
<head>
<title>아이디/비밀번호 찾기</title>
</head>
<body>
	<form name="f" method="post" action="find_id.login">
		<h1>아이디 찾기</h1><br>
		<input type="text" name="name" placeholder="이름"><br>
		<input type="text" name="email" placeholder="이메일"><br>
		<input type="submit" value="찾기">
	</form>
	<form name="f" method="post" action="find_passwd.login">
		<br><br><br>
		<h1>비밀번호 찾기</h1>
		<input type="text" name="name" placeholder="이름"><br>
		<input type="text" name="email" placeholder="이메일"><br>
		<input type="text" name="id" placeholder="아이디"><br>
		<input type="submit" value="찾기">
		<input type="button" value="취소" onclick="javascript:cancel()">
	</form>
</body>
</html>