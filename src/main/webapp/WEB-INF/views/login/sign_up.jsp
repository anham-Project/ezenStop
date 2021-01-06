<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- sign_up.jsp -->
<html>
<head>
<title>회 원 가 입</title>
</head>
<body>
	<form name="f" method="post" action="sign_up_ok.login">
		<input type="text" name="name" placeholder="이름"><br>
		<input type="text" name="id" placeholder="아이디"><br>
		<input type="password" name="passwd" placeholder="비밀번호"><br>
		<input type="hidden" name="email" value="${sessionScope.email}">
		<input type="submit" value="확인">
		<input type="button" value="취소" onclick="javascript:cancel()">
	</form>
</body>
</html>