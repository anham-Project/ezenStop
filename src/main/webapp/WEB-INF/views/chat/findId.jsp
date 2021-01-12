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
			'<th><h4>검색 결과</h4></th>' +
			'</tr>' +
			'</thead>' +
			'<tbody>' +
			'<tr>' +
			'<td style="text-align: center;"><h3>'+ findId + '</h3><a href="moveChat.chat?toId=' + encodeURIComponent(findId) +'" class="btn btn-primary pull-right">' + '메세지 보내기</a></td>' +
			'</tr>' +
			'</tbody>'
		);
	}
	function failFriend(){
		$('#friendResult').html('친구를 찾을수 없습니다.');
	}
	function cantFindMyId(){
		$('#friendResult').html('나 자신은 검색할 수 없습니다.');
	}
</script>
<jsp:include page="../header.jsp" />
<div class="container" style="min-height: 600px">
	<table class="table table-bordered table-hover"
		style="text-align: center; border: 1px solid #dddddd">
		<thead>
			<tr>
				<th colspan="2"><h4>검색으로 친구찾기</h4></th>
			</tr>
		<tbody>
			<tr>
				<td style="width: 110px;"><h5>친구 아이디</h5></td>
				<td><input class="form-control" type="text" id="findId"
					maxlength="20" placeholder="찾을 아이디를 입력하세요."></td>
			</tr>
			<tr>
				<td colspan="2"><button class="btn btn-primary pull-right"
						onclick="findFunction();">검색</button></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="container">
	<table id="friendResult" class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd;">
		
	</table>
</div>

<jsp:include page="../footer.jsp" />