<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- myInfo.jsp -->
<h2>이메일 : ${myPagetDTO.email}</h2>
<h2>아이디 : ${myPagetDTO.id}</h2>
<h2>이름 : ${myPagetDTO.name}</h2>
<h2>등급 : 
	<c:choose>
	<c:when test="${myPagetDTO.grade eq -1}"> 정지된 회원 </c:when>
	<c:when test="${myPagetDTO.grade eq 0}"> 미인증 회원 </c:when>
	<c:when test="${myPagetDTO.grade eq 1}"> 인증 회원 </c:when>
	<c:when test="${myPagetDTO.grade eq 2}"> 관리자 </c:when>
	</c:choose>
</h2>

(미구현)
<h2>
	레벨 :
	exp :
</h2>
<%@include file="myPage_bot.jsp"%>
