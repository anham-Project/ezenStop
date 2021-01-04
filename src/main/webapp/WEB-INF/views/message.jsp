<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<jsp:include page="header.jsp" />
<div class="container bootstrap snippset mt-4">
	<div class="row">
		<div class ="col-12">
			<div class="portlet portlet-default">
				<div class="portlet-heading">
					<div class="portlet-title">
						<h4><i class="fa fa-circle text-green"></i>�ǽð� ä��â</h4>
					</div>
					<div class="clearfix"></div>
				</div>
				<div id="chat" class="panel-collapse collapse-in">
					<div id="chatlist" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 600px;">
					</div>
					<div class="portlet-footer">
						<div class="row">
							<div class="form-group col-4">
								<input style="height: 40px;" type="text" id="chatName" class="form-control" placeholder="�̸�" maxlength="8">
							</div>
						</div>
						<div class="row" style="height: 90px;">
							<div class="form-group col-10">
								<textarea style="height: 80px;" id="chatContent" class="form-control" placeholder="�޼����� �Է��ϼ���." maxlength="100"></textarea>
							</div>
							<div class="form-group col-2">
								<button type="button" class="btn btn-default pull-right" onclick="submitFunction();">����</button>
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
	<strong>�޼��� ���ۿ� �����߽��ϴ�.</strong>
</div>
<div class="alert alert-danger" id="dangerMessage" style="display: none;">
	<strong>�̸��� ������ ��� �Է��� �ּ���.</strong>
</div><div class="alert alert-warning" id="warningMessage" style="display: none;">
	<strong>�����ͺ��̽� ������ �߻��߽��ϴ�.</strong>
</div>
<jsp:include page="footer.jsp" />