<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- find.jsp -->
<html>
<head>
<title>���̵�/��й�ȣ ã��</title>
</head>
<body>
	<div class = "container" style="margin-top:10px; margin-bottom:10px">
		<div align="center">
       	<h4><b>���̵� ã��</b></h4>
        <hr/>
        </div>
        <div class="row">
      		<form action="find_id.login" method="post" name="f">
	        	<div class="input-group" style="padding-left:30px; padding-bottom:3px;">
					<input class="form-control" type="text" name="name" placeholder="�̸�"> 			
				</div>
				<div class="input-group" style="padding-left:30px; padding-bottom:10px;">
					<input class="form-control" type="text" name="email" placeholder="�̸���">
				</div>
				<div class="input-group" style="padding-left:130px;">
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="ã��">	
				</div>
			</form>
		</div>
	</div>
	<hr/>
	<div class = "container" style="margin-top:10px; margin-bottom:10px">
		<div align="center">
       	<h4><b>��й�ȣ ã��</b></h4>
        <hr/>
        </div>
        <div class="row">
      		<form action="find_passwd.login" method="post" name="f">
	        	<div class="input-group" style="padding-left:30px; padding-bottom:3px;">
					<input class="form-control" type="text" name="name" placeholder="�̸�">
				</div>
	        	<div class="input-group" style="padding-left:30px; padding-bottom:3px;">
					<input class="form-control" type="text" name="email" placeholder="�̸���">
				</div>
	        	<div class="input-group" style="padding-left:30px; padding-bottom:10px;">
					<input class="form-control" type="text" name="id" placeholder="���̵�">
				</div>		
				<div class="input-group" style="padding-left:100px;">
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="ã��">	
					<input class="btn btn-outline-secondary btn-sm" type="button" value="���" onclick="javascript:cancel()">
				</div>
			</form>
		</div>
	</div>
</body>
</html>