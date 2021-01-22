<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp" />
<script type="text/javascript">
	function check(){
		if (f.category.value==""){
			alert("ī�װ��� ������ �ּ���!!")
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
	}
	function fileCheck(obj){
		pathpoint = obj.value.lastIndexOf('.');
		filepoint = obj.value.substring(pathpoint+1,obj.length);
		filetype=filepoint.toLowerCase();
		if(filetype=='jpg'||filetype=='gif'||filetype=='jpeg'||filetype=='png'){
			return true
		}else{
			alert('�̹��� ���ϸ� ������ �� �ֽ��ϴ�.');
			if (/(MSIE|Trident)/.test(navigator.userAgent)) {//������ ����
				// ie �϶� input[type=file] init.
				$("#fileInput").replaceWith( $("#board_fname1").clone(true) );
			} else {
				 // other browser �϶� input[type=file] init.
				$("#fileInput").val("");
			}
			return false
		}
	}
</script>
<div class="container" style="margin-top:30px; margin-bottom:10px;">
	
	<h5><font size="3">����'sTop�Խ��� > <a href="info_list.board" class="blackA">�������� �Խ���</a> > </font><b>�Խñ� �ۼ�</b></h5>
	<div class="container" style="margin-top:30px; margin-bottom:10px;">
	<form class="form-horizontal" name ="f" action="info_write.board" method="post" 
		onsubmit="return check()" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${sessionScope.userId}">
	<div class="input-group" style="padding-bottom:5px">
		<label class="col-md-2 control-label">ī�װ�<font size="3" color="red">*</font></label>
		<div class="col-md-3">
			<select class="form-control" name="category"> 
					<option value="">[�Խ��� ����]</option>
					<option value="���">[���]</option> 
					<option value="�ڰ���">[�ڰ���]</option>
					<option value="��Ÿ">[��Ÿ]</option>
			</select>
		</div>
		<label class="col-md control-label"><font size="2" color="red">*�ʼ����� ����</font></label>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="text" name="subject" placeholder="�ۼ��� ���� ������ �����ּ���.">
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<textarea class="form-control" rows="13" name="content" placeholder="�������� ������ �����ּ���."></textarea>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="file" id="fileInput" onchange="fileCheck(this)"name="image" accept="image/gif,image/jpeg,image/png">
	</div>
	<div class="input-group" style="padding-bottom:5px">
	<font color="gray">�̹��� ���ϸ� ÷�� �����մϴ�. jpeg, png, gif</font>
	</div>
	<div class="input-group pull-right" style="padding-bottom:5px">
		<input class="btn btn-secondary btn-sm" type="submit" value="�ۼ��Ϸ�">&nbsp;
		<input class="btn btn-secondary btn-sm" type="button" value="�������" onclick="window.location='info_list.board'">&nbsp;
		<input class="btn btn-secondary btn-sm" type="reset" value="�ٽþ���">
	</div>
	</form>
	</div>
</div>
<jsp:include page="../footer.jsp" />