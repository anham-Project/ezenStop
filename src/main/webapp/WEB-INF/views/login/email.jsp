<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link href="resources/vendor/bootstrap/css/custom.css" rel="stylesheet">
<!-- email.jsp -->  
<script>
function winclose(){
	self.close()
}
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
				alert('인증번호를 발송하였습니다.')
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
	<div class ="lineBox">
		<div class = "header">
       	<h4>이 메 일 인 증</h4>
            <h5>중복되지 않은 이메일을 입력해주세요.</h5>
        <hr/>
        </div>
        <div class="row">
        <div class="i-am-centered">
      		<form class="form" action="email_confirm.login" method="post" name="f">
        	<div class="col-12">
	        	<div class="input-group">
					<input class="form-control" type="email" id="email" name="email" size="30" placeholder="이메일을 입력해주세요"> 			
					<input class="btn btn-outline-secondary btn-sm" type="button" value="인증번호 전송" onclick="javascript:email_check()">
				</div>
				<br>
			</div>
			<div align="center">
				<input class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:winclose()" value="닫기">
			</div>
			</form>
		</div>
		</div>
	</div>
</body>
</html>