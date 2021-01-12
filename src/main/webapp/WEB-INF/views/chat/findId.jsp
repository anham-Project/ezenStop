<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	function findFunction(){
		var userId = $('#findId').val();
		$.ajax({
			type: "POST",
			url: 'userCheck.chat',
			data: {userId: userId},
			success: function(result){
				if(result == 1){
					getFriend(userId);
				}else if(result == -1){
					cantFindMyId();
				}else{
					failFriend();
				}
			}
		});
	}
	function getFriend(findId){
		$('#friendResult').html('<thead>' +
			'<tr>'+
			'<th><h4>�˻� ���</h4></th>' +
			'</tr>' +
			'</thead>' +
			'<tbody>' +
			'<tr>' +
			'<td style="text-align: center;"><h3>'+ findId + '</h3><a href="moveChat.chat?toId=' + encodeURIComponent(findId) +'" class="btn btn-primary pull-right">' + '�޼��� ������</a></td>' +
			'</tr>' +
			'</tbody>'
		);
	}
	function failFriend(){
		$('#friendResult').html('ģ���� ã���� �����ϴ�.');
	}
	function cantFindMyId(){
		$('#friendResult').html('�� �ڽ��� �˻��� �� �����ϴ�.');
	}
</script>
<jsp:include page="../header.jsp" />
<div class="container" style="min-height: 600px">
	<table class="table table-bordered table-hover"
		style="text-align: center; border: 1px solid #dddddd">
		<thead>
			<tr>
				<th colspan="2"><h4>�˻����� ģ��ã��</h4></th>
			</tr>
		<tbody>
			<tr>
				<td style="width: 110px;"><h5>ģ�� ���̵�</h5></td>
				<td><input class="form-control" type="text" id="findId"
					maxlength="20" placeholder="ã�� ���̵� �Է��ϼ���."></td>
			</tr>
			<tr>
				<td colspan="2"><button class="btn btn-primary pull-right"
						onclick="findFunction();">�˻�</button></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="container">
	<table id="friendResult" class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd;">
		
	</table>
</div>

<jsp:include page="../footer.jsp" />