<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- myPage_top.jsp -->
<html>
<head>
<meta charset="EUC-KR">
<title>����������</title>
</head>
<body>
<b>����������</b>
<a href="myInfo.login?id=${sessionScope.userId}">�� ����</a>|
<a href="changePasswd.login">��й�ȣ ���� </a>|
<a href="certification.login">�л� ���� ��û</a>|
<a href="dropId.login">ȸ��Ż�� </a>
<br>
<hr/>