<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- login.jsp-->
<script type="text/javascript">
		function checkMember(){
			window.open('email.login', "이메일 인증", "width=750, height=500")
		}	
</script>
<html>
<head>
<title>로그인</title>
</head>
<body>
	<div align="center">
	<b>로 그 인</b>
	<form action="login.login" method="post" name="f">
	<input type="text" name="id" class="box" size="20" placeholder="아이디를 입력해주세요."><br>
	<input type="text" name="passwd" class="box" size="20" placeholder="비밀번호를 입력해주세요."><br>
	<input type="submit" value="로그인">
	</form>
	<a href="javascript:checkMember()">회원가입</a>
	<a href="find.login">아이디|비밀번호 찾기</a>
	</div>
</body>
	
</html>