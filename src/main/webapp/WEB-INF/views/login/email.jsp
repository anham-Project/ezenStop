<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
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
	//var re2 =  /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
    var email = document.getElementById("email");
    // ------------ 이메일 까지 -----------
    if(email.value=="") {
        alert("이메일을 입력해 주세요");
        email.focus();
        return false;
    }
    //if(!check(re2, email, "적합하지 않은 이메일 형식입니다.")) {
    //    return false;
    //}
    alert(email_check())
}
function email_check(){
	var email = $('#email').val();
	//var re2 =  /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
    // ------------ 이메일 까지 -----------
    if(f.email.value=="") {
        alert("이메일을 입력해 주세요");
        email.focus();
        return;
    }
    //if(!check(re2, email, "적합하지 않은 이메일 형식입니다.")) {
    //    return false;
    //}
	$.ajax({
		type : "POST",
		url : "email_check.login",
		contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
		data : {
			email : email,
		},
		datatype : 'text',
		success : function(result){
			if(result === '1'){
				alert('이미 사용중인 이메일 입니다.')
			}else{
				document.f.submit()
			}
		}
	})
}
 </script>
<html>
<head>
<title>이메일 인증</title>
</head>
<body>
	<div align="center">
	<b>이 메 일 인 증</b>
	<form action="email_confirm.login" method="post" name="f">
	<input type="email" id="email" name="email" placeholder="이메일을 입력해주세요"> 
	<input type="button" value="인증번호 전송" onclick="javascript:email_check()"> <br>
	<input type="reset" value="취소">
	</form>
	</div>
</body>
</html>