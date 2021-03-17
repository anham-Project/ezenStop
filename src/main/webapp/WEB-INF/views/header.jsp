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
<title>이젠 그만...</title>

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
						result[i][0].value = '나';
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
								+ '</a>' + '<div class="media-body">'
								+ '<h4 class="media-heading">' + chatName
								+ '<span class="small pull-right">' + "    "+chatTime
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
		var popupWidth = 704;
		var popupHeight = 450;
		var popupX = (window.screen.width / 2) - (popupWidth / 2);
		var popupY= (window.screen.height / 2) - (popupHeight / 2);
		window.open('myInfo.login?id=${sessionScope.userId}', "이메일 인증", 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY)
	}
	function LoadingWithMask(){
		//화면 높이와 너비 구하기
		var maskHeight = $(document).height();
		var maskWidth = window.document.body.clientWidth;
		
		//화면에 출력할 마스크를 설정
		var mask = "<div id='mask' style='position:fixed; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
		var loadingImg = '';
		
		loadingImg += "<div id='loadingImg'>";
		loadingImg += "	<img src='resources/img/loading.gif' style='position:absolute;top:40%;left:40%;z-index:10000;opacity:0.4; margin:0px auto;'/>";
		loadingImg += "</div>";
		
		//화면에 레이어 추가
		$('body')
			.append(mask)
			.append(loadingImg)
		//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채우기
		$('#mask').css({
			'width' : maskWidth
			, 'height' : maskHeight
		});
		
		//마스크 표시
		$('#mask').show();
		
		//로딩중 이미지 표시
		$('#loadingImg').show();
		

	}
	//로딩중 표시 제거함수
	function closeLoadingWithMask(){
		$('#mask, #loadingImg').hide();
		$('#mask, #loadingImg').remove();
	}
	window.onbeforeunload = function(){
		setTimeout("LoadingWithMask()",2000);
	}
	$(window).on('load',function(){
		setTimeout("closeLoadingWithMask()",3000);
	})
	//쿠키저장 함수
function setCookie(name, value, expiredays){
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + expiredays*1000*60*60*24);
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toUTCString() + ";"
}

$(document).ready(function(){
	$('#promotionBanner .btnClose').click(function(){
		//오늘만 보기 체크박스의 체크여부를 확인 해서 체크되어 있으면 쿠키를 생성함
		if($("#chkday").is(':checked')){
			setCookie("topPop","done",1);
			alert("쿠키를 생성함!")
		}
		//팝업창을 위로 애니메이트시킨다
		$('#promotionBanner').slideUp(500);
	})
	cookiedata = document.cookie;
	if(cookiedata.indexOf("topPop=done") < 0 ){
		$('#promotionBanner').slideDown(500);
	}
	else{
		$('#promotionBanner').hide();
	}
})
$(window).scroll(function(){
	$('#leftBanner,#rightBanner').animate({
		top:$(window).scrollTop()+"px"},{queue: false, duration: 500});
});
</script>
</head>
<style>
.dropdown:hover>.dropdown-menu {
	display: block;
	margin-top: 0;
}

/*상단 슬라이드 배너를 위한 css설정*/
#promotionBanner {
	width: 100%;
	height: 110px;
	background-color: #cccccc;
	color: #f1f1f1;
	overflow: hidden;
}

.popContents {
	width: 1100px;
	margin: 0 auto;
	text-align: center;
	font-size: 9pt;
	padding: 0;
}

)
#chkday {
	color: #5a5a5a;
}

label[for=chkday] {
	cursor: pointer;
	color: #000000;
	padding-right: 10px;
}

.contents {
	width: 1100px;
	margin: 0 auto;
	height: 900px;
	background-color: #e0e0e0;
	overflow: hidden;
	padding: 20px;
}
</style>
<body>
	<!-- 탑 슬라이드 배너 코드 -->
	<div id="promotionBanner" style="display: none;">
		<div class="popContents">
			<img src="resources/img/topBanner.png" align="middle" style="width:60% ;">
			<div class="popClose">
				<input type="checkbox" value="checkbox" name="chkbox" id="chkday" /><label
					for="chkday">오늘 하루 그만보기</label> <a href="#none" class="btnClose">닫기</a>
			</div>
		</div>
	</div>

	<!-- -------------- -->
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="index.do"><h4>Ezen's Top</h4></a>
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
						aria-haspopup="true" aria-expanded="false"> 이젠's Top게시판 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="notice_list.board">공지사항</a> <a
								class="dropdown-item" href="info_list.board">정보 공유 게시판</a> <a
								class="dropdown-item" href="review_list.board">지역별 수강후기 게시판</a>
							<a class="dropdown-item" href="trade_list.board">사고팔고 게시판</a> <a
								class="dropdown-item" href="free_list.board">자유게시판</a>
						</div></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href=""
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 캠퍼스별 익명 게시판 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="campusBoardList.board?where=11">노원
								캠퍼스</a> <a class="dropdown-item"
								href="campusBoardList.board?where=12">종로 캠퍼스</a> <a
								class="dropdown-item" href="campusBoardList.board?where=13">신촌
								캠퍼스</a> <a class="dropdown-item"
								href="campusBoardList.board?where=14">상봉 캠퍼스</a> <a
								class="dropdown-item" href="campusBoardList.board?where=15">당산
								캠퍼스</a> <a class="dropdown-item"
								href="campusBoardList.board?where=16">송파 캠퍼스</a> <a
								class="dropdown-item" href="campusBoardList.board?where=17">강남
								캠퍼스</a> <a class="dropdown-item"
								href="campusBoardList.board?where=18">안양 캠퍼스</a> <a
								class="dropdown-item" href="campusBoardList.board?where=19">의정부
								캠퍼스</a> <a class="dropdown-item"
								href="campusBoardList.board?where=20">구리 캠퍼스</a> <a
								class="dropdown-item" href="campusBoardList.board?where=21">일산
								캠퍼스</a> <a class="dropdown-item"
								href="campusBoardList.board?where=22">안산 캠퍼스</a> <a
								class="dropdown-item" href="campusBoardList.board?where=23">성남
								분당 캠퍼스</a> <a class="dropdown-item"
								href="campusBoardList.board?where=24">성남 모란 캠퍼스</a> <a
								class="dropdown-item" href="campusBoardList.board?where=25">김포
								캠퍼스</a> <a class="dropdown-item"
								href="campusBoardList.board?where=26">전주 캠퍼스</a> <a
								class="dropdown-item" href="campusBoardList.board?where=27">이젠IT
								캠퍼스</a>
						</div></li>
					<c:if test="${sessionScope.userGrade == 2 }">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href=""
							id="navbarDropdownMenuLink" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false"> 관리자용 게시판 </a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
								<a class="dropdown-item" href="reportBoard.board">신고 게시판</a> <a
									class="dropdown-item" href="unvisible_list.board">비활성화 된
									게시판</a> <a class="dropdown-item" href="member_management.login">회원
									관리 게시판</a>
							</div></li>
					</c:if>
				</ul>
				<c:if test="${!empty sessionScope.userId }">
					<ul class="navbar-nav navbar-right">
						<li class="mr-3"><a href="findChatId.chat" class="whiteA">친구찾기</a></li>
						<li class="mr-3"><a href="moveChatBox.chat" class="whiteA">메세지함</a><span
							id="unread" class="badge badge-info"></span></li>
						<li class="dropdown"><a href="#"
							class="dropdown-toggle whiteA" data-toggle="dropdown"
							role="button" aria-haspopup="true" aria-expanded="false">
								${sessionScope.userId}</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
								<a class="dropdown-item"
									href="myBoard.login?id=${sessionScope.userId}">내 게시글</a> <a
									class="dropdown-item" href="javascript:myPage()">마이페이지</a> <a
									class="dropdown-item" href="logout.login">로그아웃</a>
							</div></li>
					</ul>
				</c:if>
				<c:if test="${empty sessionScope.userId }">
					<div class="align-right">
						<a class="btn btn-primary" href="login.login">로그인</a>
					</div>
				</c:if>
			</div>
		</div>
	</nav>
	<div class="row" style="margin-top:15px">
	<div class="col-1" id="leftBanner"
		style="position: relative; display: block; z-index: 100;padding-right: 0px;">
		<img src="resources/img/loading.gif" style="width:100%; margin-top: 50px; margin-bottom: 10px;">
		<h1>광고 배너 공간</h1>
	</div>

	<div class="container col-10"
		style="min-height: 600px; margin-top: 50px; margin-bottom: 10px;padding-left:5px; padding-right:5px;">
			