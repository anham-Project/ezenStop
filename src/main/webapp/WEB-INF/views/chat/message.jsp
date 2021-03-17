<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<jsp:include page="../header.jsp" />
<script type="text/javascript">
	
	var ws;
	var userId = '${sessionScope.userId}' //������� ���̵�
	var toId = '${sessionScope.toId}'	//�޴� ȸ���� ���̵�
	
	function connect(){
		//������ ��ü ����
		//�ڵ鷯 ���(���� ����, �޼��� ����, ���� ����)
		
		//url ������ ������ ���
		ws = new WebSocket('ws://localhost:8081/ezenStop/echo')
		
		ws.onopen = function(){
			console.log('���� ����');
			register();
		};
		ws.onmessage = function(e){
			console.log('�޼��� ����');
			var data = e.data;
			//alert("�����޼��� :" + data);
			addMsg(data);
		};
		ws.onclose = function(){
			console.log('���� ����');
		};
	}
	
	function addMsg(msg){ //���� ä�� �޼����� ��� ���� �޼��� ���ؼ� �����ϱ�
		//var chat = $('#msgArea').val();
		//chat = "\n���� : " + msg;
		var today = new Date();
		addChat('${sessionScope.toId}',msg,today.toLocaleString())
	}
	function register(){ //�޼��� ������ ���� ������ id ����ϱ�
		var msg = {
				type : "register", //�޼��� �����ϴ� ������ - ���� ���̵�� �޼��� �����ؼ� ����
				userId : userId
		};
		ws.send(JSON.stringify(msg));
	}
	function sendMsg(chat){
		//var msg = $("#chatMsg").val();
		//ws.send(userId + " : " + msg);
		var msg = {
				type : "chat", //�޼��� �����ϴ� ������ - ���� ���̵�� �޼��� �����ؼ� ����
				target : toId,
				content : chat
		};
		ws.send(JSON.stringify(msg));
	}
	
	//�������� �ε��Ǹ� connect ����
	$(document).ready(function(){
		connect();
	})
	
	function testsubmit(chat){
		//var chat = $("#msgArea").val();
		//chat = chat + "\n�� : "+$("#chatMsg").val();
		//$("#msgArea").append(chat);
		var today = new Date();
		addChat('��',chat,today.toLocaleString())
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
							<i class="fa fa-circle text-green"></i>�ǽð� ä��â
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
									class="form-control" placeholder="�޼����� �Է��ϼ���." maxlength="100"></textarea>
							</div>
							<div class="form-group col-1">
								<button type="button" class="btn btn-warning btn-sm shadow"
								style="width:55px; height:40px; border:1px solid gray;"
									onclick="submitFunction()"><b>����</b></button>
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
	<strong>�޼��� ���ۿ� �����߽��ϴ�.</strong>
</div>
<div class="alert alert-danger" id="dangerMessage"
	style="display: none;">
	<strong>������ �Է��� �ּ���.</strong>
</div>
<div class="alert alert-warning" id="warningMessage"
	style="display: none;">
	<strong>�����ͺ��̽� ������ �߻��߽��ϴ�.</strong>
</div>
<script type="text/javascript">
$(document).ready(function() {
	chatListFunction(0)
});
</script>
<jsp:include page="../footer.jsp" />