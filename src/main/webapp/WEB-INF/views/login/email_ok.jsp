<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link href="resources/vendor/bootstrap/css/custom.css" rel="stylesheet">
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
<div style="margin-top:25%;">
	<div class ="lineBox shadow">
		<div class = "header">
       	<h4>�� �� �� �� ��</h4>
            <h5>���Ϸ� ���� ������ȣ�� �Է����ּ���.</h5>
        <hr/>
        </div>
        <div class="row">
        	<div class="i-am-centered">
      		<form action="sign_up.login" method="post" name="f" onsubmit="return check()">
	        <div class="col-12">	
	        	<div class="input-group">
					<input class="form-control" type="text" name="hardNumber" size="25" placeholder="������ȣ�� �Է����ּ���"> 			
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="Ȯ��">	
				</div>
			</div>
			</form>
		<div align="center">
		<input class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:winclose()" value="�ݱ�">
		</div>
		</div>
		</div>
	</div>
	</div>
</body>
</html>
<head>