<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link href="resources/vendor/bootstrap/css/custom.css" rel="stylesheet">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<!-- sign_up.jsp -->
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
	function id_check(){
		var id = $('#id').val();
		$.ajax({
			type : "POST",
			url : "id_check.login",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data : {
				id : id,
			},
			datatype : 'text',
			success : function(result){
				if(result == '1'){
					alert('이미 사용중인 아이디입니다.')
					$('#idCheck').val('false')
					$('#addstr').html('<h5>다른 아이디로 중복체크를 해주세요.</h5>')
				}else if(result =='0') {
					alert('사용 가능한 아이디입니다.')
					$('#idCheck').val('true')
					$('#addstr').html('<h5>아이디 중복체크 완료!!</h5>')
				}else {
					alert('올바르지 않은 아이디 형식입니다.')
					$('#idCheck').val('false')
				}
			}
		})
	}
   function validate() {
       var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
       // 이메일이 적합한지 검사할 정규식
       var id = document.getElementById("id");
       var pw = document.getElementById("passwd");
       var name = document.getElementById("name");
       
       // ------------ 이메일 까지 -----------
       if(!check(re,id,"아이디는 4~12자의 영문 대소문자와 숫자로만 입력")) {
           return false;
       }
       if(!check(re,pw,"패스워드는 4~12자의 영문 대소문자와 숫자로만 입력")) {
           return false;
       }
       if(f.passwd.value != f.checkpasswd.value) {
           alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
           f.checkpasswd.value = "";
           f.checkpasswd.focus();
           return false;
       }
       if(f.idCheck.value == "false"){
    	   alert("아이디 중복체크를 해주세요.")
    	   return false;
       }
       return true
   }
</script>
<html>
<head>
<title>회 원 가 입</title>
</head>
<body>
	<div style="margin-top:10%;">
	<div class ="lineBox shadow">
		<div class = "header">
       		<h4>회 원 가 입</h4>
        <hr/>
        </div>
        <div class="row">
        	<div class="i-am-centered">
      		<form name="f" method="post" action="sign_up_ok.login" onsubmit="return validate()">
	        <div class="col-12">	
	        	<div class="input-group A">
					<input class="form-control" type="text" id="name" name="name" placeholder="이름">	
				</div>
				<div class="input-group A">
					<input class="form-control" type="text" id="id" name="id" placeholder="아이디">
					<input class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:id_check()" value="중복체크">
				</div>
				<div class="input-group B">
					<h6>※ 아이디는 4~12자의 영문 대소문자와 숫자로만 입력하세요.</h6>
				</div>
				<div class="input-group B">
					<div id="addstr"></div>
				</div>
				<input type="hidden" id="idCheck" name="idCheck" value="false">
				<input type="hidden" name="email" value="${sessionScope.email}">
				<div class="input-group A">
					<input class="form-control" type="password" id="passwd" name="passwd" placeholder="비밀번호">
				</div>
				<div class="input-group A">
					<input class="form-control" type="password" name="checkpasswd" placeholder="비밀번호 확인">
				</div>
				<div class="input-group B">
					<h6>※ 비밀번호를 한번 더 입력해 주세요.</h6>
				</div>
			</div>
			<div align="center">
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="확인">&nbsp;
					<input class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:winclose()" value="닫기">
			</div>
			</form>
			</div>
		</div>
		</div>
		</div>
</body>
</html>