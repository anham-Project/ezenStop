<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
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
<html>
<head>
<title>�̸��� ����</title>
</head>
<body>
	<div class = "container" style="margin-top:10px; margin-bottom:10px">
		<div align="center">
       	<h4><b>�� �� �� �� ��</b></h4>
            <font color="gray" size="2px">�ߺ����� ���� �̸����� �Է����ּ���.</font>
        <hr/>
        </div>
        <div class="row">
      		<form action="sign_up.login" method="post" name="f" onsubmit="return check()">
        	<div class="col-12">
	        	<div class="input-group" style="padding-left:10px;">
					<input class="form-control" type="text" name="hardNumber" class="box" size="20" placeholder="������ȣ�� �Է����ּ���"> 			
					<input class="btn btn-outline-secondary btn-sm" type="reset" value="���">
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="Ȯ��">	
				</div>
			</div>
			</form>
		</div>
	</div>
</body>
</html>