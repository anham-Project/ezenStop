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
	
	<h5><font size="3">이젠'sTop게시판 > <a href="trade_list.board">지역별 강의 후기게시판</a> > </font><b>게시글 수정</b></h5>
	<div class="container" style="margin-top:30px; margin-bottom:10px;">
	<form class="form-horizontal" name ="f" action="trade_edit.board" method="post" 
		onsubmit="return check()" enctype="multipart/form-data">
		<input type="hidden" name="article_num" value="${tradeDetail.article_num}">
	<div class="input-group" style="padding-bottom:5px">
		<label class="col-md-2 control-label">카테고리<font size="3" color="red">*</font></label>
		<div class="col-md-3">
			<select class="form-control" name="category"> 
					<option value="">[게시판 종류]</option>
					<option value="BUY" <c:if test="${noticeDetail.category == '사고'}">selected</c:if>>[사고]</option> 
					<option value="SELL" <c:if test="${noticeDetail.category == '팔고'}">selected</c:if>>[팔고]</option> 
			</select>
		</div>
		<label class="col-md control-label"><font size="2" color="red">*필수선택 사항</font></label>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="text" name="subject" value="${tradeDetail.subject}">
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<textarea class="form-control" rows="13" name="content">${tradeDetail.content}</textarea>
	</div>
    <div class="input-group" style="padding-bottom:5px">
    	<font color="gray">첨부된 파일 :</font>
    	<div id="delbefore">
    	<c:if test="${tradeDetail.filesize != 0}"><b>&nbsp;${tradeDetail.image}&nbsp;&nbsp;</b>
    		<input type="hidden" name="image0" value="${tradeDetail.image}">
    		<input type="hidden" name="filesize0" value="${tradeDetail.filesize}">
    		<button class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:deleteImage()">파일삭제</button>
    	</c:if>
    	</div>
    	<c:if test="${tradeDetail.filesize == 0}"><b>&nbsp;첨부파일이 없습니다.&nbsp;&nbsp;</b>
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
		<input class="btn btn-secondary btn-sm" type="button" value="목록으로" onclick="window.location='trade_list.board'">&nbsp;
		<input class="btn btn-secondary btn-sm" type="reset" value="원래대로">
	</div>
	</form>
	</div>
</div>
<jsp:include page="../footer.jsp" />