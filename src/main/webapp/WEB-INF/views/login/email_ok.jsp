<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- email_ok.jsp -->
<html>
<script type="text/javascript">
function check(){
	if(document.f.hardNumber.value!=${hardNumber}){
		alert("������ȣ�� �ùٸ��� �ʽ��ϴ�!")		
		return false
	}
	alert("�����Ǿ����ϴ�. \nȸ���������� �Ѿ�ϴ�!")
	return true
	}
</script>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
	<b>�� �� �� �� �� </b>

	<h1>${toEmail}</h1>
	<h1>${hardNumber}</h1>
	<form action="sign_up.login" method="post" name="f" onsubmit="return check()">
	<input type="text" name="hardNumber" class="box" size="20" placeholder="������ȣ�� �Է����ּ���"> 
	<input type="submit" value="Ȯ��"> <br>
	<input type="reset" value="���">
	</form>
	</div>
</body>
</html>