<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- find.jsp -->
<html>
<head>
<title>아이디/비밀번호 찾기</title>
</head>
<body>
	<div class = "container" style="margin-top:10px; margin-bottom:10px">
		<div align="center">
       	<h4><b>아이디 찾기</b></h4>
        <hr/>
        </div>
        <div class="row">
      		<form action="find_id.login" method="post" name="f">
	        	<div class="input-group" style="padding-left:30px; padding-bottom:3px;">
					<input class="form-control" type="text" name="name" placeholder="이름"> 			
				</div>
				<div class="input-group" style="padding-left:30px; padding-bottom:10px;">
					<input class="form-control" type="text" name="email" placeholder="이메일">
				</div>
				<div class="input-group" style="padding-left:130px;">
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="찾기">	
				</div>
			</form>
		</div>
	</div>
	<hr/>
	<div class = "container" style="margin-top:10px; margin-bottom:10px">
		<div align="center">
       	<h4><b>비밀번호 찾기</b></h4>
        <hr/>
        </div>
        <div class="row">
      		<form action="find_passwd.login" method="post" name="f">
	        	<div class="input-group" style="padding-left:30px; padding-bottom:3px;">
					<input class="form-control" type="text" name="name" placeholder="이름">
				</div>
	        	<div class="input-group" style="padding-left:30px; padding-bottom:3px;">
					<input class="form-control" type="text" name="email" placeholder="이메일">
				</div>
	        	<div class="input-group" style="padding-left:30px; padding-bottom:10px;">
					<input class="form-control" type="text" name="id" placeholder="아이디">
				</div>		
				<div class="input-group" style="padding-left:100px;">
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="찾기">	
					<input class="btn btn-outline-secondary btn-sm" type="button" value="취소" onclick="javascript:cancel()">
				</div>
			</form>
		</div>
	</div>
</body>
</html>