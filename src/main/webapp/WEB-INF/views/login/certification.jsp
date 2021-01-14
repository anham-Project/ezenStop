<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- certification.jsp -->
<script>
	function check(){
		if(f.file.value==""){
			alert("파일을 선택해주세요")
			return false
		}
		return true
	}
</script>
<form name = "f" action="certification.login" method="post" onsubmit="return check()" enctype="multipart/form-data">
	<input type="file" name="image">
	<input type="hidden" name="id" value="${sessionScope.userId}">
	<input type="submit" value="확인">
</form>
<%@include file="myPage_bot.jsp"%>