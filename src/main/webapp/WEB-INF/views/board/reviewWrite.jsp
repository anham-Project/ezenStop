<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp" />
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
</script>
<div class="container" style="margin-top:30px; margin-bottom:10px;">
	
	<h5><font size="3">����'sTop�Խ��� > ������ ���� �ı�Խ��� > </font><b>�ı��ۼ�</b></h5>
	<div class="container" style="margin-top:30px; margin-bottom:10px;">
	<form class="form-horizontal" name ="f" action="review_write.board" method="post" 
		onsubmit="return check()" enctype="multipart/form-data">
		<input type="hidden" name="id" value="testUser1">
	<div class="input-group" style="padding-bottom:5px">
		<label class="col-md-2 control-label">��������<font size="3" color="red">*</font></label>
		<div class="col-md-3">
			<select class="form-control" name="reviewAddr"> 
					<option value="">[������������]</option>
					<option>[���]</option> 
					<option>[����]</option> 
			</select>
		</div>
		
		<label class="col-md-2 control-label">�����Ⱓ<font size="3" color="red">*</font></label>
		<div class="col-md-3">
			<select class="form-control" name="category"> 
					<option value="">[�����Ⱓ����]</option>
					<option>[6���� ����]</option> 
					<option>[3���� ����]</option> 
					<option>[�ܱ� ����]</option> 
					<option>[��Ÿ]</option>
			</select>
		</div>
		<label class="col-md control-label"><font size="2" color="red">*�ʼ����� ����</font></label>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="text" name="subject" placeholder="�ۼ��� ���� ������ �����ּ���.">
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<textarea class="form-control" rows="13" name="content" placeholder="�����Ӱ� �����ı⸦ �����ּ���"></textarea>
	</div>
	<div class="input-group" style="padding-bottom:5px">
		<input class="form-control" type="file" name="image">
	</div>
	<div class="input-group pull-right" style="padding-bottom:5px">
		<input class="btn btn-secondary btn-sm" type="submit" value="�ۼ��Ϸ�">&nbsp;
		<input class="btn btn-secondary btn-sm" type="button" value="�������" onclick="window.location='review_list.board'">&nbsp;
		<input class="btn btn-secondary btn-sm" type="reset" value="�ٽþ���">
	</div>
	</form>
	</div>
</div>
<jsp:include page="../footer.jsp" />