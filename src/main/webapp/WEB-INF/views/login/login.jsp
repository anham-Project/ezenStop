<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- login.jsp-->
<jsp:include page="../header.jsp" />
<script type="text/javascript">
		function checkMember(){
			window.open('email.login', "이메일 인증", "width=750, height=500")
		}	
		function findMember(){
			window.open('find.login', "아이디/비밀번호 찾기", "width=750, height=500")
		}	
		function login(){
			if(document.f.id.value==""){
				alert("아이디를 입력해주세요!")
				return false
			}else if(document.f.passwd.value==""){
				alert("비밀번호를 입력해주세요!")
				return false
			}
			return true
		}
</script>
<html>
<head>
<title>로그인</title>
</head>
<body>
	<div align="center">
	<b>로 그 인</b>
	<form action="login.login" method="post" name="f" onsubmit="return login()">
	<input type="text" name="id" class="box" size="20" placeholder="아이디를 입력해주세요."><br>
	<input type="password" name="passwd" class="box" size="20" placeholder="비밀번호를 입력해주세요."><br>
	<input type="submit" value="로그인">
	</form>
	<a href="javascript:checkMember()">회원가입</a>
	<a href="javascript:findMember()">아이디|비밀번호 찾기</a>
	</div>
</body>
	
</html>
<jsp:include page="../footer.jsp" />