<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link href="resources/vendor/bootstrap/css/custom.css" rel="stylesheet">
<!-- myPage_top.jsp -->
<html>
<head>
<meta charset="EUC-KR">
<title>마이페이지</title>
</head>
<div class ="lineBox shadow">
<body>
<div align="center">
<h4>마이페이지</h4>
<ul class="nav nav-tabs justify-content-center">
  <li class="nav-item">
    <div id="myIn"><a class="nav-link" data-toggle="tab" href="myInfo.login?id=${sessionScope.userId}">내 정보</a></div>
  </li>
  <li class="nav-item">
    <div id="myPass"><a class="nav-link" data-toggle="tab" href="changePasswd.login?id=${sessionScope.userId}">비밀번호 변경</a></div>
  </li>
  <li class="nav-item">
    <div id="mycer"><a class="nav-link" data-toggle="tab" href="certification.login">학생 인증 신청</a></div>
  </li>
  <li class="nav-item">
    <div id="mydrop"><a class="nav-link" data-toggle="tab" href="blockList.login">차단 목록</a></div>
  </li>
   <li class="nav-item">
    <div id="mydrop"><a class="nav-link" data-toggle="tab" href="dropId.login">회원탈퇴</a></div>
  </li>
</ul>
</div>
<br>

