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
<h2>
1. Ż�� �Ŀ� ���̵� '${userId}'�� �ٽ� ����� �� ������ ���̵�� �����ʹ� ������ �� �����ϴ�.<br>
2. ���� ���̵�� �ۼ��� �Խñ�, ��۵� ��� Ȱ�� ������ �����˴ϴ�. <br>
3. �� ���׵��� �а� �����ϰ� �����غ��ð� �Ʒ�ĭ�� ȸ���� ��й�ȣ�� ���� Ȯ�� ��ư�� ������ ȸ��Ż�� �̷�����ϴ�.<br>
</h2>
<form name="f" action="dropId.login" method="post" onsubmit="return dropIdCheck()">
<input type="password" name="passwd" placeholder="��й�ȣ">
<input type="hidden" name="id" value="${sessionScope.userId}">
<input type="submit" value="ȸ��Ż��">
</form>
<%@include file="myPage_bot.jsp"%>


