<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- myInfo.jsp -->
<div class="info">
<h5>�̸���</h5>
<h6>${myPageDTO.email}</h6>
<h5>���̵�</h5>
<h6>${myPageDTO.id}</h6>
<h5>�̸�</h5>
<h6>${myPageDTO.name}</h6>
<h5>���</h5>
<h6>
	<c:choose>
	<c:when test="${myPageDTO.grade eq -1}"> ������ ȸ�� </c:when>
	<c:when test="${myPageDTO.grade eq 0}"> �Ϲ� ȸ�� </c:when>
	<c:when test="${myPageDTO.grade eq 1}"> ���� ȸ�� </c:when>
	<c:when test="${myPageDTO.grade eq 2}"> ������ </c:when>
	</c:choose>
</h6>
<h5>����</h5>
<h6>
	<c:choose>
	<c:when test="${myPageDTO.status eq 0}"> �̽�û</c:when>
	<c:when test="${myPageDTO.status eq 1}"> �������</c:when>
	<c:when test="${myPageDTO.status eq 2}"> �����Ϸ�</c:when>
	</c:choose>
</h6>
<h5>����(�̱���)</h5>
<h5>exp(�̱���)</h5>
</div>
<%@include file="myPage_bot.jsp"%>
