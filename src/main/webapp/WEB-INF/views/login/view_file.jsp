<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<html>
<body>
<h1>학원 지점  : [${CMDTO.academyLocation}]</h1>
<img src="<spring:url value='/image/${CMDTO.image}'/>"/>
</body>
</html>