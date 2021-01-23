<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<html>
<body>
	<div class = "lineBox shadow" style="margin-bottom:0px">
		<div align="center">
	       	<font style="font-weight: bold;font-size: 2em;">학원 지점  <br> [${CMDTO.academyLocation}]</font>
	       	<hr/>
        <div class="row" style="margin-top:0px;">
        	<div class="i-am-centered">
				<img src="<spring:url value='/image/${CMDTO.image}'/>" style="max-width: 100%; height: auto;"/>
			</div>
		</div>
		</div>
	</div>
</body>
</html>