<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp" />
<style>
.file-input:lang(ko) ~ .file-label::after {
	  content: "파일수정";
	}
</style>
<script type="text/javascript">
	function check(){
		if (f.subject.value==""){
			alert("제목를 입력해 주세요!!")
			f.subject.focus()
			return false
		}
		if (f.content.value==""){
			alert("내용을 입력해 주세요!!")
			f.content.focus()
			return false
		}
		if (f.image.value!=""){
			if (confirm("기존 파일이 첨부한 파일로 변경되어 저장됩니다.") == true){
			}else{
			   return false;
			}
		}
		return true
	}
	function deleteImage(){
		document.getElementById('delbefore').innerHTML = 
			"<input type='hidden' name='image0' value='0'>"+
			"<input type='hidden' name='filesize0' value='0'>"+
			"<b>&nbsp;첨부파일이 없습니다.&nbsp;&nbsp;</b>"
	}
	function fileCheck(obj){
		pathpoint = obj.value.lastIndexOf('.');
		filepoint = obj.value.substring(pathpoint+1,obj.length);
		filetype=filepoint.toLowerCase();
		if(filetype=='jpg'||filetype=='gif'||filetype=='jpeg'||filetype=='png'){
			return true
		}else{
			alert('이미지 파일만 선택할 수 있습니다.');
			if (/(MSIE|Trident)/.test(navigator.userAgent)) {//브라우저 구분
				// ie 일때 input[type=file] init.
				$("#fileInput").replaceWith( $("#board_fname1").clone(true) );
			} else {
				 // other browser 일때 input[type=file] init.
				$("#fileInput").val("");
			}
			return false
		}
	}
</script>

<div class="container" style="margin-top:30px; margin-bottom:10px;">
	
	<h5><font size="3">이젠'sTop게시판 > <a href="campusBoardList.board?where=${reviewAddr }" class="blackA">${reviewAddr }캠퍼스 게시판 ></a> </font><b>게시글 수정</b></h5>
	<div class="container" style="margin-top:30px; margin-bottom:10px;">
	<form class="form-horizontal" name ="f" action="campus_editPro.board" method="post" 
		onsubmit="return check()" enctype="multipart/form-data">
		<input type="hidden" name="article_num" value="${reviewDetail.article_num}">
		<input type="hidden" name="where" value="${whereCode }">
		<input type="hidden" name="id" value="${sessionScope.userId}">
		<input type="hidden" name="randomId" value="${sessionScope.randomId }">
	<div class="input-group" style="padding-bottom:5px">
		<label class="col-md-2 control-label">수강지역<font size="3" color="red">*</font></label>
		<div class="col-md-3">
			<select class="form-control" name="reviewAddr"> 
			<c:forEach var="list" items="${reviewAddrList}">
			<option <c:if test="${reviewAddr == list}">selected</c:if>>[${list}]</option>
			</c:forEach> 
			</select>
		</div>
		<label class="col-md control-label"><font size="2" color="red">*필수선택 사항</font></label>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="text" name="subject" value="${reviewDetail.subject}">
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<textarea class="form-control" rows="13" name="content">${reviewDetail.content}</textarea>
	</div>
    <div class="input-group" style="padding-bottom:5px">
    	<font color="gray">첨부된 파일 :</font>
    	<div id="delbefore">
    	<c:if test="${reviewDetail.filesize != 0}"><b>&nbsp;${reviewDetail.image}&nbsp;&nbsp;</b>
    		<input type="hidden" name="image0" value="${reviewDetail.image}">
    		<input type="hidden" name="filesize0" value="${reviewDetail.filesize}">
    		<button class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:deleteImage()">파일삭제</button>
    	</c:if>
    	</div>
    	<c:if test="${reviewDetail.filesize == 0}"><b>&nbsp;첨부파일이 없습니다.&nbsp;&nbsp;</b>
    		<input type="hidden" name="image0" value="파일없음">
    		<input type="hidden" name="filesize0" value="0">
    	</c:if>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="file" id="fileInput" onchange="fileCheck(this)"name="image" accept="image/gif,image/jpeg,image/png">
	</div>
	<div class="input-group" style="padding-bottom:5px">
	<font color="gray">이미지 파일만 첨부 가능합니다. jpeg, png, gif, jpg</font>
	</div>
	<div class="input-group pull-right" style="padding-bottom:5px">
		<input class="btn btn-secondary btn-sm" type="submit" value="수정하기">&nbsp;
		<input class="btn btn-secondary btn-sm" type="button" value="목록으로" onclick="window.location='campusBoardList.board?where=${whereCode}'">&nbsp;
		<input class="btn btn-secondary btn-sm" type="reset" value="원래대로">
	</div>
	</form>
	</div>
</div>
<jsp:include page="../footer.jsp" />