<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- email_ok.jsp -->
<html>
<script type="text/javascript">
function winclose(){
	self.close()
}
function check(){
	if(document.f.hardNumber.value!=${hardNumber}){
		alert("������ȣ�� �ùٸ��� �ʽ��ϴ�!")		
		return false
	}
	alert("�����Ǿ����ϴ�. \nȸ���������� �Ѿ�ϴ�!")
	return true
	}
</script>
<html>
<head>
<title>�̸��� ����</title>
</head>
<body>
	<div class = "container" style="margin-top:10px; margin-bottom:10px">
		<div align="center">
       	<h4><b>�� �� �� �� ��</b></h4>
        <hr/>
        </div>
        <div class="row" style="padding-left:40px">
      		<form action="sign_up.login" method="post" name="f" onsubmit="return check()">
	        	<div class="input-group" style="padding-left:30px;">
					<input class="form-control" type="text" name="hardNumber" class="box" size="30" placeholder="������ȣ�� �Է����ּ���"> 			
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="Ȯ��">	
			</div>
			</form>
		</div>
		<br>
		<div align="center">
		<input class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:winclose()" value="�ݱ�">
		</div>
	</div>
</body>
</html>
<head>