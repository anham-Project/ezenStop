<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- dropId.jsp -->
<script>
	function dropIdCheck(){
		if(f.passwd.value==""){
			alert("��й�ȣ�� �Է����ּ���!")
			return false	
		}
		return true
	}
</script>
<div class="info">
<h5>1. Ż�� �Ŀ� ���̵� '${userId}'�� �ٽ� ����� �� ������,</h5>
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���̵�� �����ʹ� ������ �� �����ϴ�.</h5><br>
<h5>2. ���� ���̵�� �ۼ��� �Խñ�, ��� �� ��� Ȱ�� ������ �����˴ϴ�.</h5><br>
<h5>3. �� ������ �����Ͽ� �����ϰ� �����غ��ð�,</h5>
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�Ʒ��� ��й�ȣ�� ���� Ȯ�� ��ư�� ������ ȸ��Ż�� �̷�����ϴ�.</h5><br>
<h5><font color="red">�� ������ ��Ұ� �Ұ��մϴ�.</font></h5><br>
</div>
<div class="row" style="padding-left:50px;">
<form name="f" action="dropId.login" method="post" onsubmit="return dropIdCheck()">
<input type="hidden" name="id" value="${sessionScope.userId}">
<div class="input-group A" style="padding-bottom:10px;">
<input class="form-control" type="password" name="passwd" placeholder="��й�ȣ">
<input class="btn btn-outline-secondary btn-sm" type="submit" value="ȸ��Ż��">
</div>
</form>
</div>
<%@include file="myPage_bot.jsp"%>


