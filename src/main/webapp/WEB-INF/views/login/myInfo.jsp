<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- myInfo.jsp -->
<h2>�̸��� : ${myPagetDTO.email}</h2>
<h2>���̵� : ${myPagetDTO.id}</h2>
<h2>�̸� : ${myPagetDTO.name}</h2>
<h2>��� : 
	<c:choose>
	<c:when test="${myPagetDTO.grade eq -1}"> ������ ȸ�� </c:when>
	<c:when test="${myPagetDTO.grade eq 0}"> ������ ȸ�� </c:when>
	<c:when test="${myPagetDTO.grade eq 1}"> ���� ȸ�� </c:when>
	<c:when test="${myPagetDTO.grade eq 2}"> ������ </c:when>
	</c:choose>
</h2>

(�̱���)
<h2>
	���� :
	exp :
</h2>
<%@include file="myPage_bot.jsp"%>
