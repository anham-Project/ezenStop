<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<!-- sign_up.jsp -->
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
					$('#str').html('<h6>사용불가</h6>')
				}else {
					alert('사용 가능한 아이디입니다.')
					$('#idCheck').val('true')
					$('#str').html('<h6>사용가능</h6>')
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
           join.checkpasswd.value = "";
           join.checkpasswd.focus();
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
	<form name="f" method="post" action="sign_up_ok.login" onsubmit="return validate()">
		<input type="text" id="name" name="name" placeholder="이름"><br>
		<input type="text" id="id" name="id" placeholder="아이디"> <h6>※ 아이디는 4~12자의 영문 대소문자와 숫자로만 입력하세요</h6>
		<input type="button" onclick="javascript:id_check()" value="중복체크"><div id="str"><font style=>사용불가</font></div><br>
		<input type="hidden" id="idCheck" name="idCheck" value="false">
		<input type="password" id="passwd" name="passwd" placeholder="비밀번호"><br>
		<input type="password" name="checkpasswd" placeholder="비밀번호 확인"><br>
		<input type="hidden" name="email" value="${sessionScope.email}">
		<input type="submit" value="확인">
		<input type="button" value="취소">
	</form>
</body>
</html>