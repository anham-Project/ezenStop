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

<div class="row">
<div class="i-am-centered">
	<form name="f" action="changePasswd.login" method="post" onsubmit="return check()">
	<input type="hidden" name="id" value="${sessionScope.userId}">
	<div class="input-group A" style="padding-bottom:5px;">
		<input class="form-control" type="password" name="passwd" size="30" placeholder="��й�ȣ">
	</div>
	<div class="input-group A" style="padding-bottom:10px;">
		<input class="form-control" type="password" name="passwdConfirm" size="30" placeholder="��й�ȣ Ȯ��">
	</div>
	<div align="center" style="padding-bottom:5px;">
		<input class="btn btn-outline-secondary btn-sm" type="submit" value="��й�ȣ����">&nbsp;
		<input class="btn btn-outline-secondary btn-sm" type="button" value="���">
	</div>
	</form>
</div>
</div>
<%@include file="myPage_bot.jsp"%>