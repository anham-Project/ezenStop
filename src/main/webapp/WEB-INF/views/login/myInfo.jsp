<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- myInfo.jsp -->
<div class="info">
<h5>이메일</h5>
<h6>${myPageDTO.email}</h6>
<h5>아이디</h5>
<h6>${myPageDTO.id}</h6>
<h5>이름</h5>
<h6>${myPageDTO.name}</h6>
<h5>등급</h5>
<h6>
	<c:choose>
	<c:when test="${myPageDTO.grade eq -1}"> 정지된 회원 </c:when>
	<c:when test="${myPageDTO.grade eq 0}"> 일반 회원 </c:when>
	<c:when test="${myPageDTO.grade eq 1}"> 인증 회원 </c:when>
	<c:when test="${myPageDTO.grade eq 2}"> 관리자 </c:when>
	</c:choose>
</h6>
<h5>상태</h5>
<h6>
	<c:choose>
	<c:when test="${myPageDTO.status eq 0}"> 미신청</c:when>
	<c:when test="${myPageDTO.status eq 1}"> 인증대기</c:when>
	<c:when test="${myPageDTO.status eq 2}"> 인증완료</c:when>
	</c:choose>
</h6>
<h5>레벨(미구현)</h5>
<h5>exp(미구현)</h5>
</div>
<%@include file="myPage_bot.jsp"%>
