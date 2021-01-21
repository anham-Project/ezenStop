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
		if (f.category.value==""){
			alert("카테고리를 선택해 주세요!!")
			f.category.focus()
			return false
		}
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
	
	<h5><font size="3">이젠'sTop게시판 > <a href="notice_list.board">공지사항</a> > </font><b>공지 수정</b></h5>
	<div class="container" style="margin-top:30px; margin-bottom:10px;">
	<form class="form-horizontal" name ="f" action="notice_edit.board" method="post" 
		onsubmit="return check()" enctype="multipart/form-data">
		<input type="hidden" name="article_num" value="${noticeDetail.article_num}">
	<div class="input-group" style="padding-bottom:5px">
		<label class="col-md-2 control-label">카테고리<font size="3" color="red">*</font></label>
		<div class="col-md-3">
			<select class="form-control" name="category"> 
					<option value="">[게시판 종류]</option>
					<option value="ALL" <c:if test="${noticeDetail.category == 'ALL'}">selected</c:if>>[공통]</option> 
					<option value="REVIEW" <c:if test="${noticeDetail.category == 'REVIEW'}">selected</c:if>>[리뷰 게시판]</option> 
					<option value="FREE" <c:if test="${noticeDetail.category == 'FREE'}">selected</c:if>>[자유 게시판]</option> 
					<option value="TRADE" <c:if test="${noticeDetail.category == 'TRADE'}">selected</c:if>>[사고팔고 게시판]</option> 
					<option value="INFO" <c:if test="${noticeDetail.category == 'INFO'}">selected</c:if>>[정보공유 게시판]</option> 
					<option value="ETC" <c:if test="${noticeDetail.category == 'ETC'}">selected</c:if>>[기타]</option>
			</select>
		</div>
		<label class="col-md control-label"><font size="2" color="red">*필수선택 사항</font></label>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="text" name="subject" value="${noticeDetail.subject}">
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<textarea class="form-control" rows="13" name="content">${noticeDetail.content}</textarea>
	</div>
    <div class="input-group" style="padding-bottom:5px">
    	<font color="gray">첨부된 파일 :</font>
    	<div id="delbefore">
    	<c:if test="${noticeDetail.filesize != 0}"><b>&nbsp;${noticeDetail.image}&nbsp;&nbsp;</b>
    		<input type="hidden" name="image0" value="${noticeDetail.image}">
    		<input type="hidden" name="filesize0" value="${noticeDetail.filesize}">
    		<button class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:deleteImage()">파일삭제</button>
    	</c:if>
    	</div>
    	<c:if test="${noticeDetail.filesize == 0}"><b>&nbsp;첨부파일이 없습니다.&nbsp;&nbsp;</b>
    		<input type="hidden" name="image0" value="파일없음">
    		<input type="hidden" name="filesize0" value="0">
    	</c:if>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="file" id="fileInput"onchange="fileCheck(this)"name="image" accept="image/gif,image/jpeg,image/png">
	</div>
	<div class="input-group" style="padding-bottom:5px">
	<font color="gray">이미지 파일만 첨부 가능합니다. jpeg, png, gif</font>
	</div>
	<div class="input-group pull-right" style="padding-bottom:5px">
		<input class="btn btn-secondary btn-sm" type="submit" value="수정하기">&nbsp;
		<input class="btn btn-secondary btn-sm" type="button" value="목록으로" onclick="window.location='notice_list.board'">&nbsp;
		<input class="btn btn-secondary btn-sm" type="reset" value="원래대로">
	</div>
	</form>
	</div>
</div>
<jsp:include page="../footer.jsp" />