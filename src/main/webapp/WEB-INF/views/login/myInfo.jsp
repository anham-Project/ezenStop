<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- myInfo.jsp -->
<h2>이메일 : ${myPageDTO.email}</h2>
<h2>아이디 : ${myPageDTO.id}</h2>
<h2>이름 : ${myPageDTO.name}</h2>
<h2>등급 : 
	<c:choose>
	<c:when test="${myPageDTO.grade eq -1}"> 정지된 회원 </c:when>
	<c:when test="${myPageDTO.grade eq 0}"> 일반 회원 </c:when>
	<c:when test="${myPageDTO.grade eq 1}"> 인증 회원 </c:when>
	<c:when test="${myPageDTO.grade eq 2}"> 관리자 </c:when>
	</c:choose>
</h2>
<h2>상태 :
	<c:choose>
	<c:when test="${myPageDTO.status eq 0}"> 미신청</c:when>
	<c:when test="${myPageDTO.status eq 1}"> 인증대기</c:when>
	<c:when test="${myPageDTO.status eq 2}"> 인증완료</c:when>
	</c:choose>
</h2>

(미구현)
<h2>
	레벨 :
	exp :
</h2>
<%@include file="myPage_bot.jsp"%>
