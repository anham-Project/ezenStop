<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- certification.jsp -->
<script>
	function check(){
		if(f.file.value==""){
			alert("������ �������ּ���")
			return false
		}
		return true
	}
</script>
<div class="row">
<div class="i-am-centered">
	<div align="center">
            <p>���������� �����Ͻð�,<br>
            	������ ���� �� ������ ÷�����ּ���.</p>
        <hr/>
    </div>
<form name = "f" action="certification.login" method="post" onsubmit="return check()" enctype="multipart/form-data">
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="file" name="image" accept="image/gif,image/jpeg,image/png">
	</div>
	<input type="hidden" name="id" value="${sessionScope.userId}">
	<div align="center" style="padding-bottom:5px;">
		<select class="form-control" name="reviewAddr">
					<option selected value="">[������������]</option>
					<c:forEach var="list" items="${reviewAddr}">
					<option>[${list}]</option>
					</c:forEach>
		</select>
		<hr/>
		<input class="btn btn-outline-secondary btn-sm" type="submit" value="������û">
	</div>
</form>
</div>
</div>
<%@include file="myPage_bot.jsp"%>