<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- changePasswd.jsp -->
<script>
	function check(){
		if(f.passwd.value==""){
			alert("��й�ȣ�� �Է����ּ���")
			f.passwd.focus()
			return false
		}
		if(f.passwd.value!=f.passwdConfirm.value){
			alert("�� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			return false
		}
		return true
	}
</script>
<form name="f" action="changePasswd.login" method="post" onsubmit="return check()">
<input type="hidden" name="id" value="${sessionScope.userId}">
<input type="password" name="passwd" placeholder="��й�ȣ">
<input type="password" name="passwdConfirm" placeholder="��й�ȣ Ȯ��">
<input type="submit" value="��й�ȣ ����">
<input type="reset" value="���">
</form>
<%@include file="myPage_bot.jsp"%>