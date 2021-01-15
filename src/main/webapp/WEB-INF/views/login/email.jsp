<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- email.jsp -->
<script>
function check(re, what, message) {
    if(re.test(what.value)) {
        return true;
    }
    alert(message);
    what.value = "";
    what.focus();
    //return false;
}
function validate() {
	var re2 =  /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
    var email = document.getElementById("email");
    // ------------ 이메일 까지 -----------
    if(email.value=="") {
        alert("이메일을 입력해 주세요");
        email.focus();
        return false;
    }
    if(!check(re2, email, "적합하지 않은 이메일 형식입니다.")) {
        return false;
    }
	return true
}
 </script>
<html>
<head>
<title>이메일 인증</title>
</head>
<body>
	<div align="center">
	<b>이 메 일 인 증</b>
	<form action="email_confirm.login" method="post" name="f" onsubmit="return validate()">
	<input type="text" id="email" name="email" class="box" size="20" placeholder="이메일을 입력해주세요"> 
	<input type="submit" value="인증번호 전송"> <br>
	<input type="reset" value="취소">
	</form>
	</div>
</body>
</html>