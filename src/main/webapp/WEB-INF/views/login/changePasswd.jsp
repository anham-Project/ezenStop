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
		 var re = /^[a-zA-Z0-9]{4,12}$/ // ���̵�� �н����尡 �������� �˻��� ���Խ�
		 var pw = document.getElementById("passwd");
		 if(!check(re,pw,"�н������ 4~12���� ���� ��ҹ��ڿ� ���ڷθ� �Է��ϼ���")) {
			 f.passwdConfirm.value="";
		     return false;
		 }
		if(f.passwdOriConfirm.value==""){
			alert("���� ��й�ȣ�� �Է����ּ���")
			f.passwdOriConfirm.focus()
			return false
		}
		if(f.passwd.value==""){
			alert("��й�ȣ�� �Է����ּ���")
			f.passwd.focus()
			return false
		}
		if(f.passwd.value!=f.passwdConfirm.value){
			alert("�� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			f.passwd.value="";
			f.passwdConfirm.value="";
			f.passwd.focus()
			return false
		}
		if(f.passwdOri.value!=f.passwdOriConfirm.value){
			alert("���� ��й�ȣ�� �ùٸ��� �ʽ��ϴ�.");
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
		<input class="form-control" type="password" name="passwdOriConfirm" size="30" placeholder="���� ��й�ȣ">
	</div>
	<div class="input-group A" style="padding-bottom:5px;">
		<input class="form-control" type="password" name="passwd" id="passwd"size="30" placeholder="������ ��й�ȣ">
	</div>
	<div class="input-group A" style="padding-bottom:10px;">
		<input class="form-control" type="password" name="passwdConfirm" size="30" placeholder="������ ��й�ȣ Ȯ��">
	</div>
	<div align="center" style="padding-bottom:5px;">
		<input class="btn btn-outline-secondary btn-sm" type="submit" value="��й�ȣ����">&nbsp;
		<input class="btn btn-outline-secondary btn-sm" type="button" value="���">
	</div>
	</form>
</div>
</div>
<%@include file="myPage_bot.jsp"%>