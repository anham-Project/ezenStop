<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<head>

<meta charset="utf-8">
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
			data : {
				fromId : encodeURIComponent(fromId),
				toId : encodeURIComponent(toId),
				chatContent : encodeURIComponent(chatContent),
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
			type : "POST",
			url : "chatList.chat",
			data : {
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
	$(document).ready(function() {
		chatListFunction('ten');
		getInfiniteChat();
	});
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
						class="nav-link dropdown-toggle" href=""
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> ����'sTop�Խ��� </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">�α�� �Խ���</a> <a
								class="dropdown-item" href="#">�����Խ���</a> <a
								class="dropdown-item" href="#">�߰�å �ŷ� �Խ���</a> <a
								class="dropdown-item" href="#">������ ���� �ı� �Խ���</a> <a
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
					<c:if test="${empty sessionScope.userId }">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href=""
							id="navbarDropdownMenuLink" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false"> �����ڿ� �Խ��� </a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
								<a class="dropdown-item" href="#">�Ű� �Խ���</a> <a
									class="dropdown-item" href="#">���� ��� �Խ���</a> <a
									class="dropdown-item" href="#">ȸ�� ���� �Խ���</a>
							</div></li>
					</c:if>
				</ul>
			</div>
			<div class="align-right">
				<a class="btn btn-primary">�α���</a>
			</div>
		</div>
	</nav>