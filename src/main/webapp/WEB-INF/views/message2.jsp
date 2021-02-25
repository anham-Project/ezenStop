<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- message.jsp -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script>
	if("${url}"=="cancel"){
		alert("${msg}")
		self.close()
	}else if("${fun}"=="release_block"){
		alert("${msg}")
		opener.location.reload();
		location.href="${url}"
	}
	else if("${url}"=="confirm"){
		alert("${msg}")
		location.href="email_ok.login?hardNumber="+"${hardNumber}"
	}else if("${url}"=="dropId"){
		alert("${msg}")
		opener.location.href="index.do"
		self.close()
	}else if("${url}"=="addBlock"){
		alert("${msg}")
		opener.location.reload();  
		self.close();  
	}else if("${url}"=="reload"){
		location.reload();
	}else{
         alert("${msg}")
         location.href="${url}"
         }
</script>