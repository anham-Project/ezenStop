<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- email_ok.jsp -->
<html>
<script type="text/javascript">
function check(){
	if(document.f.hardNumber.value!=${hardNumber}){
		alert("인증번호가 올바르지 않습니다!")		
		return false
	}
	alert("인증되었습니다. \n회원가입으로 넘어갑니다!")
	return true
	}
</script>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
	<b>이 메 일 인 증 </b>

	<h1>${toEmail}</h1>
	<h1>${hardNumber}</h1>
	<form action="sign_up.login" method="post" name="f" onsubmit="return check()">
	<input type="text" name="hardNumber" class="box" size="20" placeholder="인증번호를 입력해주세요"> 
	<input type="submit" value="확인"> <br>
	<input type="reset" value="취소">
	</form>
	</div>
</body>
</html>