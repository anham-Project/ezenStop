<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- myInfo.jsp -->
<div class="info" style="line-height:120%;">
<h5>�̸���</h5>
<h6><b>&nbsp;&nbsp;${myPageDTO.email}</b></h6>
<h5>���̵�</h5>
<h6><b>&nbsp;&nbsp;${myPageDTO.id}</b></h6>
<h5>�̸�</h5>
<h6><b>&nbsp;&nbsp;${myPageDTO.name}</b></h6>
<h5>���</h5>
<h6><b>&nbsp;&nbsp;
	<c:choose>
	<c:when test="${myPageDTO.grade eq -1}"> ������ ȸ�� </c:when>
	<c:when test="${myPageDTO.grade eq 0}"> �Ϲ� ȸ�� </c:when>
	<c:when test="${myPageDTO.grade eq 1}"> ���� ȸ�� </c:when>
	<c:when test="${myPageDTO.grade eq 2}"> ������ </c:when>
	</c:choose>
</b></h6>
<h5>����</h5>
<h6><b>&nbsp;&nbsp;
	<c:choose>
	<c:when test="${myPageDTO.status eq 0}"> �̽�û</c:when>
	<c:when test="${myPageDTO.status eq 1}"> �������</c:when>
	<c:when test="${myPageDTO.status eq 2}"> �����Ϸ�</c:when>
	</c:choose>
</b></h6>
</div>
<%@include file="myPage_bot.jsp"%>
