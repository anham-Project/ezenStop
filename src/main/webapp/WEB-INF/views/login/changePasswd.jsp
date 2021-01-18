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

<div class="row">
<div class="i-am-centered">
	<form name="f" action="changePasswd.login" method="post" onsubmit="return check()">
	<input type="hidden" name="id" value="${sessionScope.userId}">
	<div class="input-group A" style="padding-bottom:5px;">
		<input class="form-control" type="password" name="passwd" size="30" placeholder="비밀번호">
	</div>
	<div class="input-group A" style="padding-bottom:10px;">
		<input class="form-control" type="password" name="passwdConfirm" size="30" placeholder="비밀번호 확인">
	</div>
	<div align="center" style="padding-bottom:5px;">
		<input class="btn btn-outline-secondary btn-sm" type="submit" value="비밀번호변경">&nbsp;
		<input class="btn btn-outline-secondary btn-sm" type="button" value="취소">
	</div>
	</form>
</div>
</div>
<%@include file="myPage_bot.jsp"%>