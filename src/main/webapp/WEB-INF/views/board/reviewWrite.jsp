<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp" />
<script type="text/javascript">
	function check(){
		if (f.reviewAddr.value==""){
			alert("수강 지역을 선택해 주세요!!")
			f.reviewAddr.focus()
			return false
		}
		if (f.category.value==""){
			alert("수강 기간을 선택해 주세요!!")
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
		return true
	}
</script>
<div class="container" style="margin-top:30px; margin-bottom:10px;">
	
	<h5><font size="3">이젠'sTop게시판 > 지역별 강의 후기게시판 > </font><b>후기작성</b></h5>
	<div class="container" style="margin-top:30px; margin-bottom:10px;">
	<form class="form-horizontal" name ="f" action="review_write.board" method="post" 
		onsubmit="return check()" enctype="multipart/form-data">
		<input type="hidden" name="id" value="testUser1">
	<div class="input-group" style="padding-bottom:5px">
		<label class="col-md-2 control-label">수강지역<font size="3" color="red">*</font></label>
		<div class="col-md-3">
			<select class="form-control" name="reviewAddr"> 
					<option value="">[수강지역선택]</option>
					<option>[노원]</option> 
					<option>[종로]</option> 
			</select>
		</div>
		
		<label class="col-md-2 control-label">수강기간<font size="3" color="red">*</font></label>
		<div class="col-md-3">
			<select class="form-control" name="category"> 
					<option value="">[수강기간선택]</option>
					<option>[6개월 과정]</option> 
					<option>[3개월 과정]</option> 
					<option>[단기 과정]</option> 
					<option>[기타]</option>
			</select>
		</div>
		<label class="col-md control-label"><font size="2" color="red">*필수선택 사항</font></label>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="text" name="subject" placeholder="작성할 글의 제목을 적어주세요.">
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<textarea class="form-control" rows="13" name="content" placeholder="자유롭게 수강후기를 남겨주세요"></textarea>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="file" name="image">
	</div>
	<div class="input-group pull-right" style="padding-bottom:5px">
		<input class="btn btn-secondary btn-sm" type="submit" value="작성완료">&nbsp;
		<input class="btn btn-secondary btn-sm" type="button" value="목록으로" onclick="window.location='review_list.board'">&nbsp;
		<input class="btn btn-secondary btn-sm" type="reset" value="다시쓰기">
	</div>
	</form>
	</div>
</div>
<jsp:include page="../footer.jsp" />