<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<c:if test="${!empty sessionScope.userId }">
	<c:set var="userId" value="${sessionScope.userId }" />
</c:if>
<head>

<meta charset="EUC-KR">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>���� �׸�...</title>

<!-- Bootstrap core JavaScript -->
<script src="resources/vendor/jquery/jquery.min.js"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap core CSS -->
<link
	href="<c:url value='resources/vendor/bootstrap/css/bootstrap.min.css'/>"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link href="<c:url value='resources/css/heroic-features.css'/>"
	rel="stylesheet">
<link href="resources/vendor/bootstrap/css/custom.css" rel="stylesheet">

<script type="text/javascript">
	function autoClosingAlert(selector, delay) {
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {
			alert.hide()
		}, delay);
	}
	function submitFunction() {
		var fromId = '${userId}';
		var toId = '${toId}';
		var chatContent = $('#chatContent').val();
		$.ajax({
			type : "POST",
			url : "chatSubmit.chat",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data : {
				fromId : encodeURIComponent(fromId),
				toId : encodeURIComponent(toId),
				chatContent : chatContent,
			},
			success : function(result) {
				if (result = 1) {
					autoClosingAlert('#successMessage', 2000);
				} else if (result = 0) {
					autoClosingAlert('#dangerMessage', 2000);
				} else {
					autoClosingAlert('#warningMessage', 2000);
				}
			}
		})
		$('#chatContent').val('');
	}
	var lastId = 0;
	function chatListFunction(type) {
		var fromId = '${userId}';
		var toId = '${toId}';
		$.ajax({
			type: "POST",
			url: "chatList.chat",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data: {
				fromId : encodeURIComponent(fromId),
				toId : encodeURIComponent(toId),
				listType : type
			},
			success : function(data) {
				if (data == "")
					return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for (var i = 0; i < result.length; i++) {
					if(result[i][0].value==fromId){
						result[i][0].value = '��';
					}
					addChat(result[i][0].value, result[i][2].value,
							result[i][3].value);
				}
				lastId = Number(parsed.last);
			}
		})
	}
	function addChat(chatName, chatContent, chatTime) {
		$('#chatList').append(
						'<div class="row">'
								+ '<div class="col-lg-12">'
								+ '<div class="media">'
								+ '<a class="pull-left" href="#">'
								+ '<img class="media-object img-circle" style = "width: 30px; height: 30px;"src="resources/img/ezen_jumbotron.jpg" alt="">'
								+ '</a>' + '<div class="media-body">'
								+ '<h4 class="media-heading">' + chatName
								+ '<span class="small pull-right">' + chatTime
								+ '</span>' + '</h4>' + '<p>' + chatContent
								+ '</p>' + '</div>' + '</div>' + '</div>'
								+ '</div>' + '<hr>');
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
	function getInfiniteChat() {
		setInterval(function() {
			chatListFunction(lastId);
		}, 3000);
	}
	function getUnread(){
		$.ajax({
			type: "POST",
			url: "countUnreadMessage.chat",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data: {
				userId: encodeURIComponent('${userId}'),
			},
			success: function(result){
				if(result>=1){
					showUnread(result);
				}else{
					showUnread('');
				}
			}
		});
	}
	function getInfiniteUnread(){
		setInterval(function(){
			getUnread();
		}, 4000);
	}
	function showUnread(result){
		$('#unread').html(result);
	}
	function chatBoxFunction(){
		var userId = '${sessionScope.userId}'
		$.ajax({
			type: "POST",
			url: "getMessageBox.chat",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data: {
				userId: encodeURIComponent(userId),
			},
			success: function(data){
				if(data=="") return;
				$('#boxTable').html('');
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for(var i = 0 ; i < result.length; i++){
					if(result[i][0].value == userId){
						result[i][0].value = result[i][1].value;
					}else{
						result[i][1].value = result[i][0].value;
					}
					addBox(result[i][0].value, result[i][1].value, result[i][2].value, result[i][3].value, result[i][4].value);
				}
			}
		});
	}
	function addBox(lastId, toId, chatContent, chatTime, unread){
		$('#boxTable').append('<tr onclick="location.href=\'moveChat.chat?toId='+encodeURIComponent(toId)+'\'">'+
				'<td style="width: 150px;"><h5>'+lastId+'</h5></td>'+
				'<td>' +
				'<h5>' + chatContent + 
				'<span class="badge badge-info">' + unread + '</span></h5>'+
				'<div class="pull-right">' + chatTime + '</div>' +
				'</td>' +
				'</tr>')
	}
	function getInfiniteBox(){
		setInterval(function(){
			chatBoxFunction();
		}, 3000);
	}
	function myPage(){
		window.open('myInfo.login?id=${sessionScope.userId}', "�̸��� ����", "width=750, height=500")
	}
</script>
</head>
<style>
.dropdown:hover>.dropdown-menu {
	display: block;
	margin-top: 0;
}
</style>
<body>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="#"><h4>EzenStop</h4></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="index.do"
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> ����'sTop�Խ��� </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">�α�� �Խ���</a> <a
								class="dropdown-item" href="#">�����Խ���</a> <a
								class="dropdown-item" href="#">�߰�å �ŷ� �Խ���</a> <a
								class="dropdown-item" href="review_list.board">������ ���� �ı� �Խ���</a> <a
								class="dropdown-item" href="#">���� ���� �Խ���</a>
						</div></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href=""
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> ķ�۽��� �Խ��� </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">��� ķ�۽�</a> <a
								class="dropdown-item" href="#">���� ķ�۽�</a> <a
								class="dropdown-item" href="#">���� ķ�۽�</a> <a
								class="dropdown-item" href="#">��� ķ�۽�</a> <a
								class="dropdown-item" href="#">��� ķ�۽�</a> <a
								class="dropdown-item" href="#">���� ķ�۽�</a> <a
								class="dropdown-item" href="#">���� ķ�۽�</a> <a
								class="dropdown-item" href="#">�Ⱦ� ķ�۽�</a> <a
								class="dropdown-item" href="#">������ ķ�۽�</a> <a
								class="dropdown-item" href="#">���� ķ�۽�</a> <a
								class="dropdown-item" href="#">�ϻ� ķ�۽�</a> <a
								class="dropdown-item" href="#">�Ȼ� ķ�۽�</a> <a
								class="dropdown-item" href="#">���� �д� ķ�۽�</a> <a
								class="dropdown-item" href="#">���� ��� ķ�۽�</a> <a
								class="dropdown-item" href="#">���� ķ�۽�</a> <a
								class="dropdown-item" href="#">���� ķ�۽�</a> <a
								class="dropdown-item" href="#">����IT ķ�۽�</a>
						</div></li>
					<c:if test="${sessionScope.userGrade == 2 }">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href=""
							id="navbarDropdownMenuLink" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false"> �����ڿ� �Խ��� </a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
								<a class="dropdown-item" href="reportBoard.board">�Ű� �Խ���</a> <a
									class="dropdown-item" href="#">���� ��� �Խ���</a> <a
									class="dropdown-item" href="member_management.login">ȸ�� ���� �Խ���</a>
							</div></li>
					</c:if>
				</ul>
				<c:if test="${!empty sessionScope.userId }">
					<ul class="navbar-nav navbar-right">
						<li class="mr-3"><a href="findChatId.chat">ģ��ã��</a></li>
						<li class="mr-3"><a href="moveChatBox.chat">�޼�����</a><span id="unread"
							class="badge badge-info"></span></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false"> ${sessionScope.userId }�α��εȼ��Ǿ��̵� </a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="myBoard.login?id=${sessionScope.userId}">�� �Խñ�</a>
							<a class="dropdown-item" href="javascript:myPage()">����������</a>
							<a class="dropdown-item" href="logout.login">�α׾ƿ�</a>
							</div></li>
					</ul>
				</c:if>
				<c:if test="${empty sessionScope.userId }">
					<div class="align-right">
						<a class="btn btn-primary" href="login.login">�α���</a>
					</div>
				</c:if>
			</div>
		</div>
	</nav>
<div class = "container" style="min-height: 600px; margin-top:30px; margin-bottom:10px">