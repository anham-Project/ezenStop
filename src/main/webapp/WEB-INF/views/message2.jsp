<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- message.jsp -->
<script type="text/javascript">
if("${url}"=="cancel"){
	alert("${msg}")
	self.close()
}else if("${url}"==""){
	
}else if("${url}"=="confirm"){
		alert("${msg}")
		location.href="email_ok.login?hardNumber=${hardNumber}"
}else{
         alert("${msg}")
         location.href="${url}"
         }
</script>