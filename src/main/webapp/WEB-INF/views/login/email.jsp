<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- email.jsp -->
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
function validate() {
	var re2 =  /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
    var email = document.getElementById("email");
    // ------------ �̸��� ���� -----------
    if(email.value=="") {
        alert("�̸����� �Է��� �ּ���");
        email.focus();
        return false;
    }
    if(!check(re2, email, "�������� ���� �̸��� �����Դϴ�.")) {
        return false;
    }
	return true
}
 </script>
<html>
<head>
<title>�̸��� ����</title>
</head>
<body>
	<div align="center">
	<b>�� �� �� �� ��</b>
	<form action="email_confirm.login" method="post" name="f" onsubmit="return validate()">
	<input type="text" id="email" name="email" class="box" size="20" placeholder="�̸����� �Է����ּ���"> 
	<input type="submit" value="������ȣ ����"> <br>
	<input type="reset" value="���">
	</form>
	</div>
</body>
</html>