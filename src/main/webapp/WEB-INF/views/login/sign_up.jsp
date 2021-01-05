<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- sign_up.jsp -->
<html>
<head>
<title>회 원 가 입</title>
</head>
<body>
	<form name="f" method="post" action="sign_up_ok.login">
	<h1>${email}</h1>
	<h1>${hardNumber}</h1>
	<%System.out.println(request.getAttribute("email")); %>
		<input type="text" name="name" placeholder="이름"><br>
		<input type="text" name="id" placeholder="아이디"><br>
		<input type="text" name="passwd" placeholder="비밀번호"><br>
		<input type="hidden" name="email" value="${email}">
		
	</form>
</body>
</html>