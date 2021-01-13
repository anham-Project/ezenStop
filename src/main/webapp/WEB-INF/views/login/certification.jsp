<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- certification.jsp -->
<form name = "f" action="certification.login" method="post" onsubmit="return check()" enctype="multipart/form-data">
	<input type="file" name="image">
	<input type="hidden" name="id" value="${sessionScope.userId}">
	<input type="submit" value="È®ÀÎ">
</form>
<%@include file="myPage_bot.jsp"%>