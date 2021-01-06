<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- email.jsp -->
<html>
<head>
<title>이메일 인증</title>
</head>
<body>
	<div align="center">
	<b>이 메 일 인 증</b>
	<form action="email_confirm.login" method="post" name="f">
	<input type="text" id="email" name="email" class="box" size="20" placeholder="이메일을 입력해주세요"> 
	<input type="submit" value="인증번호 전송"> <br>
	<input type="reset" value="취소">
	</form>
	</div>
</body>
</html>