<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
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
	//var re2 =  /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
    var email = document.getElementById("email");
    // ------------ �̸��� ���� -----------
    if(email.value=="") {
        alert("�̸����� �Է��� �ּ���");
        email.focus();
        return false;
    }
    //if(!check(re2, email, "�������� ���� �̸��� �����Դϴ�.")) {
    //    return false;
    //}
    alert(email_check())
}
function email_check(){
	var email = $('#email').val();
	//var re2 =  /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
    // ------------ �̸��� ���� -----------
    if(f.email.value=="") {
        alert("�̸����� �Է��� �ּ���");
        email.focus();
        return;
    }
    //if(!check(re2, email, "�������� ���� �̸��� �����Դϴ�.")) {
    //    return false;
    //}
	$.ajax({
		type : "POST",
		url : "email_check.login",
		contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
		data : {
			email : email,
		},
		datatype : 'text',
		success : function(result){
			if(result === '1'){
				alert('�̹� ������� �̸��� �Դϴ�.')
			}else{
				document.f.submit()
			}
		}
	})
}
 </script>
<html>
<head>
<title>�̸��� ����</title>
</head>
<body>
	<div align="center">
	<b>�� �� �� �� ��</b>
	<form action="email_confirm.login" method="post" name="f">
	<input type="email" id="email" name="email" placeholder="�̸����� �Է����ּ���"> 
	<input type="button" value="������ȣ ����" onclick="javascript:email_check()"> <br>
	<input type="reset" value="���">
	</form>
	</div>
</body>
</html>