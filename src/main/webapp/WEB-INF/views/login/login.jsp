<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- login.jsp-->
<jsp:include page="../header.jsp" />
<script type="text/javascript">
		function checkMember(){
			window.open('email.login', "�̸��� ����", "width=750, height=500")
		}	
		function findMember(){
			window.open('find.login', "���̵�/��й�ȣ ã��", "width=750, height=500")
		}	
		function login(){
			if(document.f.id.value==""){
				alert("���̵� �Է����ּ���!")
				return false
			}else if(document.f.passwd.value==""){
				alert("��й�ȣ�� �Է����ּ���!")
				return false
			}
			return true
		}
</script>
<html>
<head>
<title>�α���</title>
</head>
<body>
	<div class="content form-horizontal align-items-center">
	    <p th:if="${param.error}"class="text-danger">�α��� ������ ��ȿ���� �ʽ��ϴ�.</p>
	    <form action="login.login" method="post" name="f" onsubmit="return login()">
	        <div class="form-group">
	            <input type="text" name="id" class="form-control" placeholder="���̵� �Է����ּ���."/>
	            <input type="password" name="passwd" class="form-control" placeholder="��й�ȣ�� �Է����ּ���."/>
	        </div>
	        <div class="form-group">
	            <input type="submit" value="�α���" class="btn btn-primary btn-block">
	        </div>
	    </form>
	  	<a href="javascript:checkMember()">ȸ������</a>
		<a href="javascript:findMember()">���̵�|��й�ȣ ã��</a>
	</div>
<!-- 
	<div align="center">
	<b>�� �� ��</b>
	<form action="login.login" method="post" name="f" onsubmit="return login()">
	<input type="text" name="id" class="box" size="20" placeholder="���̵� �Է����ּ���."><br>
	<input type="password" name="passwd" class="box" size="20" placeholder="��й�ȣ�� �Է����ּ���."><br>
	<input type="submit" value="�α���">
	</form>
	<a href="javascript:checkMember()">ȸ������</a>
	<a href="javascript:findMember()">���̵�|��й�ȣ ã��</a>
	</div>
-->
</body>
	
</html>
<jsp:include page="../footer.jsp" />