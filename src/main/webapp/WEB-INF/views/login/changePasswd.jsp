<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- changePasswd.jsp -->
<form name="f" action="changePasswd_ok.login" method="post">
<input type="password" name="passwd" placeholder="��й�ȣ">
<input type="password" name="passwdConfirm" placeholder="��й�ȣ Ȯ��">
<input type="button" value="Ȯ��">
<input type="reset" value="���">
</form>
<%@include file="myPage_bot.jsp"%>