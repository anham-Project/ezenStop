<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<jsp:include page="header.jsp" />
<div class="container bootstrap snippset mt-4">
	<div class="row">
		<div class ="col-12">
			<div class="portlet portlet-default">
				<div class="portlet-heading">
					<div class="portlet-title">
						<h4><i class="fa fa-circle text-green"></i>실시간 채팅창</h4>
					</div>
					<div class="clearfix"></div>
				</div>
				<div id="chat" class="panel-collapse collapse-in">
					<div id="chatlist" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 600px;">
					</div>
					<div class="portlet-footer">
						<div class="row">
							<div class="form-group col-4">
								<input style="height: 40px;" type="text" id="chatName" class="form-control" placeholder="이름" maxlength="8">
							</div>
						</div>
						<div class="row" style="height: 90px;">
							<div class="form-group col-10">
								<textarea style="height: 80px;" id="chatContent" class="form-control" placeholder="메세지를 입력하세요." maxlength="100"></textarea>
							</div>
							<div class="form-group col-2">
								<button type="button" class="btn btn-default pull-right" onclick="submitFunction();">전송</button>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="alert alert-success" id="successMessage" style="display: none;">
	<strong>메세지 전송에 선공했습니다.</strong>
</div>
<div class="alert alert-danger" id="dangerMessage" style="display: none;">
	<strong>이름과 내용을 모두 입력해 주세요.</strong>
</div><div class="alert alert-warning" id="warningMessage" style="display: none;">
	<strong>데이터베이스 오류가 발생했습니다.</strong>
</div>
<jsp:include page="footer.jsp" />