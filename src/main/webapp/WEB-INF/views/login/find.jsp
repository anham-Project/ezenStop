<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link href="resources/vendor/bootstrap/css/custom.css" rel="stylesheet">
<!-- find.jsp -->
<html>
<head>
<title>아이디/비밀번호 찾기</title>
</head>
<body>
	<div class = "lineBox shadow" style="margin-top:10px; margin-bottom:0px">
		<div align="center">
       	<h4><b>아이디 찾기</b></h4>
        <hr/>
        </div>
        <div class="row">
        	<div class="i-am-centered">
      		<form action="find_id.login" method="post" name="f">
	        	<div class="input-group" >
					<input class="form-control" type="text" name="name" size="30" placeholder="이름"> 			
				</div>
				<div class="input-group" style="margin-bottom:10px">
					<input class="form-control" type="text" name="email" size="30"placeholder="이메일">
				</div>
				<div align="right" >
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="찾기">	
				</div>
			</form>
			</div>
		</div>
		<div align="center">
       	<h4><b>비밀번호 찾기</b></h4>
        <hr/>
        </div>
        <div class="row">
        <div class="i-am-centered">
      		<form action="find_passwd.login" method="post" name="f">
	        	<div class="input-group">
					<input class="form-control" type="text" name="name" size="30" placeholder="이름">
				</div>
	        	<div class="input-group">
					<input class="form-control" type="text" name="email" size="30" placeholder="이메일">
				</div>
	        	<div class="input-group" style="margin-bottom:10px">
					<input class="form-control" type="text" name="id" size="30" placeholder="아이디">
				</div>		
				<div align="right">
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="찾기">	
					<input class="btn btn-outline-secondary btn-sm" type="button" value="취소" onclick="javascript:cancel()">
				</div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>