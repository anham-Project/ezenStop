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
<div class="row">
<div class="i-am-centered">
<form name = "f" action="certification.login" method="post" onsubmit="return check()" enctype="multipart/form-data">
	<input class="form-control" type="file" name="image" accept="image/gif,image/jpeg,image/png">
	<input type="hidden" name="id" value="${sessionScope.userId}">
	<div align="center" style="padding-bottom:5px;">
		<input class="btn btn-outline-secondary btn-sm" type="submit" value="인증신청">
	</div>
</form>
</div>
</div>
<%@include file="myPage_bot.jsp"%>