<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- changePasswd.jsp -->
<form name="f" action="changePasswd_ok.login" method="post">
<input type="password" name="passwd" placeholder="비밀번호">
<input type="password" name="passwdConfirm" placeholder="비밀번호 확인">
<input type="button" value="확인">
<input type="reset" value="취소">
</form>
<%@include file="myPage_bot.jsp"%>