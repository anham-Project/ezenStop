<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp" />
<style>
.file-input:lang(ko) ~ .file-label::after {
	  content: "���ϼ���";
	}
</style>
<script type="text/javascript">
	function check(){
		if (f.reviewAddr.value==""){
			alert("���� ������ ������ �ּ���!!")
			f.reviewAddr.focus()
			return false
		}
		if (f.category.value==""){
			alert("���� �Ⱓ�� ������ �ּ���!!")
			f.category.focus()
			return false
		}
		if (f.subject.value==""){
			alert("���� �Է��� �ּ���!!")
			f.subject.focus()
			return false
		}
		if (f.content.value==""){
			alert("������ �Է��� �ּ���!!")
			f.content.focus()
			return false
		}
		return true
	}
	function deleteImage(){
		document.getElementById('fileNameChange').innerHTML = 
			"<div class='input-group mb-3' style='padding-bottom:5px'>"+
			"<div class='custom-file'>"+ 
			"<input type='file' class='custom-file-input' name='image'>"+
			"<label class='custom-file-label'>"+
			"</label>"+
			"</div>"+
			"</div>"
	}
</script>

<div class="container" style="margin-top:30px; margin-bottom:10px;">
	
	<h5><font size="3">����'sTop�Խ��� > <a href="review_list.board">������ ���� �ı�Խ���</a> > </font><b>�Խñ� ����</b></h5>
	<div class="container" style="margin-top:30px; margin-bottom:10px;">
	<form class="form-horizontal" name ="f" action="review_write.board" method="post" 
		onsubmit="return check()" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${sessionScope.userId}">
	<div class="input-group" style="padding-bottom:5px">
		<label class="col-md-2 control-label">��������<font size="3" color="red">*</font></label>
		<div class="col-md-3">
			<select class="form-control" name="reviewAddr"> 
			<c:forEach var="list" items="${reviewAddrList}">
			<option <c:if test="${reviewAddr == list}">selected</c:if>>${list}</option>
			</c:forEach> 
			</select>
		</div>
		
		<label class="col-md-2 control-label">�����Ⱓ<font size="3" color="red">*</font></label>
		<div class="col-md-3">
			<select class="form-control" name="category">
			<c:forEach var="list" items="${categoryList}">
			<option <c:if test="${reviewDetail.category == list}">selected</c:if>>${list}</option>
			</c:forEach>
			</select>
			
		</div>
		<label class="col-md control-label"><font size="2" color="red">*�ʼ����� ����</font></label>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="text" name="subject" value="${reviewDetail.subject}">
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<textarea class="form-control" rows="13" name="content">${reviewDetail.content}</textarea>
	</div>
	<div class="row">
    <c:if test="${reviewDetail.filesize == 0}"><font color="gray">÷�ε� ���� : </font><b>${reviewDetail.image}</b>
    <button class="input-group-text pull-right" type="button" onclick="javascript:deleteImage()">���ϻ���</button>
    </c:if>
    </div>
	<div class="input-group" style="padding-bottom:5px"> 
		<input type="file" class="file-input" name="image"> 
	</div>
	<div class="input-group pull-right" style="padding-bottom:5px">
		<input class="btn btn-secondary btn-sm" type="submit" value="�ۼ��Ϸ�">&nbsp;
		<input class="btn btn-secondary btn-sm" type="button" value="�������" onclick="window.location='review_list.board'">&nbsp;
		<input class="btn btn-secondary btn-sm" type="reset" value="�������">
	</div>
	</form>
	</div>
</div>
<jsp:include page="../footer.jsp" />