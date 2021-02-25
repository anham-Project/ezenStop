<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link href="resources/vendor/bootstrap/css/custom.css" rel="stylesheet">
<!-- myPage_top.jsp -->
<script>
	function cancel(){
		self.close()		
	}
</script>
<html>
<head>
<meta charset="EUC-KR">
<title>마이페이지</title>
</head>
<body>
<div class ="lineBox shadow">
<div align="center">
<h2>차단 아이디</h2><b>${blockId}</b>
	<div class="row">
<div class="i-am-centered">
	<div align="center">
            <p></p>
        <hr/>
    </div>
    <form name="f" action="addBlock_ok.login" method="post">
    	<p>차단된 유저의 글은 노출되지 않습니다.<br>
            	차단된 유저의 댓글은 "차단된 유저의 유저의 댓글 입니다"로 표기됩니다.</p>
		<textarea class="form-control" rows="4" name="memo" placeholder="메모"></textarea>
		<br>
		<input type="hidden" name="id" value="${sessionScope.id}">
		<input type="hidden" name="blockId" value="${blockId}">
		<input class="btn btn-outline-secondary btn-sm" type="submit" value="차단">
		<input class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:cancel()" value="취소">
	</form>
</div>
</div>
</div>
</div>
</body>
</html>

