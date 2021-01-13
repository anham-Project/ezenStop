<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- changePasswd.jsp -->
<script>
	function check(){
		if(f.passwd.value==""){
			alert("비밀번호를 입력해주세요")
			f.passwd.focus()
			return false
		}
		if(f.passwd.value!=f.passwdConfirm.value){
			alert("두 비밀번호가 일치하지 않습니다.");
			return false
		}
		return true
	}
</script>
<form name="f" action="changePasswd.login" method="post" onsubmit="return check()">
<input type="hidden" name="id" value="${sessionScope.userId}">
<input type="password" name="passwd" placeholder="비밀번호">
<input type="password" name="passwdConfirm" placeholder="비밀번호 확인">
<input type="submit" value="비밀번호 변경">
<input type="reset" value="취소">
</form>
<%@include file="myPage_bot.jsp"%>