<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- login.jsp-->
<script type="text/javascript">
		function checkMember(){
			window.open('email.login', "�̸��� ����", "width=750, height=500")
		}	
</script>
<html>
<head>
<title>�α���</title>
</head>
<body>
	<div align="center">
	<b>�� �� ��</b>
	<form action="login.login" method="post" name="f">
	<input type="text" name="id" class="box" size="20" placeholder="���̵� �Է����ּ���."><br>
	<input type="text" name="passwd" class="box" size="20" placeholder="��й�ȣ�� �Է����ּ���."><br>
	<input type="submit" value="�α���">
	</form>
	<a href="javascript:checkMember()">ȸ������</a>
	<a href="find.login">���̵�|��й�ȣ ã��</a>
	</div>
</body>
	
</html>