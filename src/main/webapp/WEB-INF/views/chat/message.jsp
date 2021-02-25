<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<jsp:include page="../header.jsp" />
<script type="text/javascript">
	
	var ws;
	var userId = '${sessionScope.userId}' //사용자의 아이디
	var toId = '${sessionScope.toId}'	//받는 회원의 아이디
	
	function connect(){
		//웹소켓 객체 생성
		//핸들러 등록(연결 생성, 메세지 수신, 연결 종료)
		
		//url 연결할 서버의 경로
		ws = new WebSocket('ws://localhost:8081/ezenStop/echo')
		
		ws.onopen = function(){
			console.log('연결 생성');
			register();
		};
		ws.onmessage = function(e){
			console.log('메세지 받음');
			var data = e.data;
			//alert("받은메세지 :" + data);
			addMsg(data);
		};
		ws.onclose = function(){
			console.log('연결 끊김');
		};
	}
	
	function addMsg(msg){ //원래 채팅 메세지에 방금 받은 메세지 더해서 설정하기
		//var chat = $('#msgArea').val();
		//chat = "\n상대방 : " + msg;
		var today = new Date();
		addChat('${sessionScope.toId}',msg,today.toLocaleString())
	}
	function register(){ //메세지 수신을 위한 서버에 id 등록하기
		var msg = {
				type : "register", //메세지 구분하는 구분자 - 상대방 아이디와 메세지 포함해서 보냄
				userId : userId
		};
		ws.send(JSON.stringify(msg));
	}
	function sendMsg(chat){
		//var msg = $("#chatMsg").val();
		//ws.send(userId + " : " + msg);
		var msg = {
				type : "chat", //메세지 구분하는 구분자 - 상대방 아이디와 메세지 포함해서 보냄
				target : toId,
				content : chat
		};
		ws.send(JSON.stringify(msg));
	}
	
	//페이지가 로딩되면 connect 실행
	$(document).ready(function(){
		connect();
	})
	
	function testsubmit(chat){
		//var chat = $("#msgArea").val();
		//chat = chat + "\n나 : "+$("#chatMsg").val();
		//$("#msgArea").append(chat);
		var today = new Date();
		addChat('나',chat,today.toLocaleString())
		sendMsg(chat);
		$("#chatContent").val("");
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
					testsubmit(chatContent)
				} else if (result = 0) {
					autoClosingAlert('#dangerMessage', 2000);
				} else {
					autoClosingAlert('#warningMessage', 2000);
				}
			}
		})
		$('#chatContent').val('');
	}
</script>
<div class="container bootstrap snippset mt-4">
	<div class="row">
		<div class="col-12">
			<div class="portlet portlet-default rounded-top">
				<div class="portlet-heading">
					<div class="portlet-title">
						<h4>
							<i class="fa fa-circle text-green"></i>실시간 채팅창
						</h4>
					</div>
					<div class="clearfix"></div>
				</div>
				<div id="chat" class="panel-collapse collapse-in">
					<div id="chatList" class="portlet-body chat-widget"
						style="overflow-y: auto; width: auto; height: 600px;"></div>
					<div class="portlet-footer">
						<div class="row" style="height: 90px; padding:5px">
							<div class="form-group col-11">
								<textarea style="height: 80px;" id="chatContent" name="chatContent"
									class="form-control" placeholder="메세지를 입력하세요." maxlength="100"></textarea>
							</div>
							<div class="form-group col-1">
								<button type="button" class="btn btn-warning btn-sm shadow"
								style="width:55px; height:40px; border:1px solid gray;"
									onclick="submitFunction()"><b>전송</b></button>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="alert alert-success" id="successMessage"
	style="display: none;">
	<strong>메세지 전송에 선공했습니다.</strong>
</div>
<div class="alert alert-danger" id="dangerMessage"
	style="display: none;">
	<strong>내용을 입력해 주세요.</strong>
</div>
<div class="alert alert-warning" id="warningMessage"
	style="display: none;">
	<strong>데이터베이스 오류가 발생했습니다.</strong>
</div>
<script type="text/javascript">
$(document).ready(function() {
	chatListFunction(0)
});
</script>
<jsp:include page="../footer.jsp" />