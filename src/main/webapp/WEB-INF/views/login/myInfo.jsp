<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- myInfo.jsp -->
<h2>�̸��� : ${dto.email}</h2>
<h2>���̵� : ${dto.id}</h2>
<h2>�̸� : ${dto.name}</h2>
<h2>��� : 
	<c:choose>
	<c:when test="${dto.grade eq -1}"> ������ ȸ�� </c:when>
	<c:when test="${dto.grade eq 0}"> ������ ȸ�� </c:when>
	<c:when test="${dto.grade eq 1}"> ���� ȸ�� </c:when>
	<c:when test="${dto.grade eq 2}"> ������ </c:when>
	</c:choose>
</h2>

(�̱���)
<h2>
	���� :
	exp :
</h2>
<%@include file="myPage_bot.jsp"%>
