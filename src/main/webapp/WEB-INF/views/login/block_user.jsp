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
<title>����������</title>
</head>
<body>
<div class ="lineBox shadow">
<div align="center">
<h2>���� ���̵�</h2><b>${blockId}</b>
	<div class="row">
<div class="i-am-centered">
	<div align="center">
            <p></p>
        <hr/>
    </div>
    <form name="f" action="addBlock_ok.login" method="post">
    	<p>���ܵ� ������ ���� ������� �ʽ��ϴ�.<br>
            	���ܵ� ������ ����� "���ܵ� ������ ������ ��� �Դϴ�"�� ǥ��˴ϴ�.</p>
		<textarea class="form-control" rows="4" name="memo" placeholder="�޸�"></textarea>
		<br>
		<input type="hidden" name="id" value="${sessionScope.id}">
		<input type="hidden" name="blockId" value="${blockId}">
		<input class="btn btn-outline-secondary btn-sm" type="submit" value="����">
		<input class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:cancel()" value="���">
	</form>
</div>
</div>
</div>
</div>
</body>
</html>

