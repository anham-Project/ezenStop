<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- myInfo.jsp -->
<h2>�̸��� : ${myPageDTO.email}</h2>
<h2>���̵� : ${myPageDTO.id}</h2>
<h2>�̸� : ${myPageDTO.name}</h2>
<h2>��� : 
	<c:choose>
	<c:when test="${myPageDTO.grade eq -1}"> ������ ȸ�� </c:when>
	<c:when test="${myPageDTO.grade eq 0}"> �Ϲ� ȸ�� </c:when>
	<c:when test="${myPageDTO.grade eq 1}"> ���� ȸ�� </c:when>
	<c:when test="${myPageDTO.grade eq 2}"> ������ </c:when>
	</c:choose>
</h2>
<h2>���� :
	<c:choose>
	<c:when test="${myPageDTO.status eq 0}"> �̽�û</c:when>
	<c:when test="${myPageDTO.status eq 1}"> �������</c:when>
	<c:when test="${myPageDTO.status eq 2}"> �����Ϸ�</c:when>
	</c:choose>
</h2>

(�̱���)
<h2>
	���� :
	exp :
</h2>
<%@include file="myPage_bot.jsp"%>
