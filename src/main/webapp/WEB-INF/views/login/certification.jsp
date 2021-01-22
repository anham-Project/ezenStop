<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- certification.jsp -->
<script>
	function check(){
		if(f.image.value==""){
			alert("파일을 선택해주세요")
			return false
		}
		if(f.academy.value==""){
			alert("학원 지점을 선택해주세요")
			return false
		}
		return true
	}
</script>
<div class="row">
<div class="i-am-centered">
	<div align="center">
            <p>수강지역을 선택하시고,<br>
            	수강증 사진 파일을 첨부해주세요.</p>
        <hr/>
    </div>
<form name = "f" action="certification.login" method="post" onsubmit="return check()" enctype="multipart/form-data">
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="file" name="image" accept="image/gif,image/jpeg,image/png">
	</div>
	<input type="hidden" name="id" value="${sessionScope.userId}">
	<div align="center" style="padding-bottom:5px;">
		<select class="form-control" name="academy">
				<option selected value="">[인증지역선택]</option>
				<c:forEach var="list" items="${locationList}">
				[<option <c:if test="${dto.academyLocation==list}">selected</c:if>>${list}</option>]
				</c:forEach>
		</select>
		<hr/>
		<input class="btn btn-outline-secondary btn-sm" type="submit" value="인증신청">
	</div>
</form>
</div>
</div>
<%@include file="myPage_bot.jsp"%>