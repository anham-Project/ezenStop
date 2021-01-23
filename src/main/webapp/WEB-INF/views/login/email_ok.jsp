<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link href="resources/vendor/bootstrap/css/custom.css" rel="stylesheet">
<!-- email_ok.jsp -->
<html>
<script type="text/javascript">
function winclose(){
	self.close()
}
function check(){
	if(document.f.hardNumber.value!=${hardNumber}){
		alert("인증번호가 올바르지 않습니다!")		
		return false
	}
	alert("인증되었습니다. \n회원가입으로 넘어갑니다!")
	return true
	}
</script>
<html>
<head>
<title>이메일 인증</title>
</head>
<body>
<div style="margin-top:25%;">
	<div class ="lineBox shadow">
		<div class = "header">
       	<h4>이 메 일 인 증</h4>
            <h5>메일로 받은 인증번호를 입력해주세요.</h5>
        <hr/>
        </div>
        <div class="row">
        	<div class="i-am-centered">
      		<form action="sign_up.login" method="post" name="f" onsubmit="return check()">
	        <div class="col-12">	
	        	<div class="input-group">
					<input class="form-control" type="text" name="hardNumber" size="25" placeholder="인증번호를 입력해주세요"> 			
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="확인">	
				</div>
			</div>
			</form>
		<div align="center">
		<input class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:winclose()" value="닫기">
		</div>
		</div>
		</div>
	</div>
	</div>
</body>
</html>
<head>