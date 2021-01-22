<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- changePasswd.jsp -->
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
	function passCheck(){
		 var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
		 var pw = document.getElementById("passwd");
		 if(!check(re,pw,"패스워드는 4~12자의 영문 대소문자와 숫자로만 입력하세요")) {
			 f.passwdConfirm.value="";
		     return false;
		 }
		if(f.passwdOriConfirm.value==""){
			alert("현재 비밀번호를 입력해주세요")
			f.passwdOriConfirm.focus()
			return false
		}
		if(f.passwd.value==""){
			alert("비밀번호를 입력해주세요")
			f.passwd.focus()
			return false
		}
		if(f.passwd.value!=f.passwdConfirm.value){
			alert("두 비밀번호가 일치하지 않습니다.");
			f.passwd.value="";
			f.passwdConfirm.value="";
			f.passwd.focus()
			return false
		}
		if(f.passwdOri.value!=f.passwdOriConfirm.value){
			alert("현재 비밀번호가 올바르지 않습니다.");
			f.passwdOriConfirm.value=""
			f.passwdOriConfirm.focus()
			return false
		}
		return true
	}
</script>

<div class="row">
<div class="i-am-centered">
	<form name="f" action="changePasswd.login" method="post" onsubmit="return passCheck()">
	<input type="hidden" name="id" value="${id}">
	<input type="hidden" name="passwdOri" value="${passwdOri}">
	<div class="input-group A" style="padding-bottom:5px;">
		<input class="form-control" type="password" name="passwdOriConfirm" size="30" placeholder="현재 비밀번호">
	</div>
	<div class="input-group A" style="padding-bottom:5px;">
		<input class="form-control" type="password" name="passwd" id="passwd"size="30" placeholder="변경할 비밀번호">
	</div>
	<div class="input-group A" style="padding-bottom:10px;">
		<input class="form-control" type="password" name="passwdConfirm" size="30" placeholder="변경할 비밀번호 확인">
	</div>
	<div align="center" style="padding-bottom:5px;">
		<input class="btn btn-outline-secondary btn-sm" type="submit" value="비밀번호변경">&nbsp;
		<input class="btn btn-outline-secondary btn-sm" type="button" value="취소">
	</div>
	</form>
</div>
</div>
<%@include file="myPage_bot.jsp"%>