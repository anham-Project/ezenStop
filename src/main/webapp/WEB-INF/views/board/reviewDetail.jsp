<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<script type="text/javascript">
	function check() {
		if (f.content.value == "") {
			alert("��� ������ �Է��� �ּ���!!")
			f.content.focus()
			return false
		}
		return true
	}
	function deleteReply(r_num, a_num) {
		location.href = "review_reply_delete.board?reply_num=" + r_num
				+ "&article_num=" + a_num;
	}
	function review_edit(a_num){
		location.href = "review_edit.board?article_num=" + a_num;
	}
	function review_delete(a_num){
		location.href = "review_delete.board?article_num=" + a_num;
	}
	function somethingDo(somethingDo){
		var article_num = '${reviewDetail.article_num}';
		var userId = '${sessionScope.userId}';
		$.ajax({
			type : "POST",
			url : "updownPro.board",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data : {
				article_num : article_num,
				userId : userId,
				somethingDo : somethingDo
			},
			datatype : 'text',
			success : function(result){
				if(result === '-2'){
					alert('�̹� ��õ/����õ/�Ű� �ൿ�� �Ͽ����ϴ�.')
				}else if(result === '1'){
					if(somethingDo === 'up'){
						alert('��õ�Ǿ����ϴ�.')
						$('#upcount').html(${reviewDetail.upCount}+1);
					}else{
						alert('����õ�Ǿ����ϴ�.')
						$('#downcount').html(${reviewDetail.downCount}+1);
					}
				}else{
					alert('��õ/����õ �� ������ �߻��߽��ϴ�. �����ڿ��� �����ϼ���.')
				}
				
			}
		})
	}
	function changeVisibleStatus(){
		var article_num = '${reviewDetail.article_num}';
		$.ajax({
			type: "POST",
			url: "changeVisibleStatus.board",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data: {
				article_num: article_num
			},
			datatype: 'text',
			success: function(result){
				alert("ó���Ǿ����ϴ�.")
				window.location.reload();
			}
		})
	}
</script>
<jsp:include page="../header.jsp" />
<div class="container" style="margin-top: 30px; margin-bottom: 10px;">
	<h5>
		<font size="3">����'sTop�Խ��� > <a href="review_list.board" class="blackA">������
				�����ı� �Խ���</a> >
		</font><b>�Խñۺ���</b>
	</h5>
	<div class="row"
		style="padding-left: 10px; padding-top: 10px; padding-bottom: 10px; background-color: #EFF7EA;">
		<div class="col-md-3">
			<c:if test="${reviewDetail.grade == 1 }">
				<img class="media-object img-circle"
					style="width: 30px; height: 30px;"
					src="resources/img/${reviewDetail.academyLocation }.jpg">
			</c:if>
			<c:if test="${reviewDetail.grade != 1 }">
				<img class="media-object img-circle"
					style="width: 30px; height: 30px;"
					src="resources/img/${reviewDetail.grade }.jpg">
			</c:if>
			<c:choose>
			<c:when test="${reviewDetail.grade==2}"><font style="color:#FF0000;  font-weight:bold;">${reviewDetail.id}</font></c:when>
			<c:otherwise>${reviewDetail.id}</c:otherwise>
		</c:choose>
		</div>
		<div class="col-md-6 text-center">
			<b>${reviewDetail.subject}</b>
		</div>
		<div class="col-md-3" align="right">��ȸ ${reviewDetail.readCount}
			| ��õ�� ${reviewDetail.upCount}</div>
	</div>
	<div class="row" style="padding-top: 10px;">
		<div class="col-md-12" align="right">
			<font color="gray">${reviewDetail.regdate}
				${reviewDetail.regdate_time}</font>&nbsp;���[${reviewDetail.replyCount}]
		</div>
	</div>
	<hr />
	<div class="row"
		style="padding: 0px 10px 20px 20px; min-height: 300px;">
		<div class="col-md-12">${reviewDetail.content}</div>
	</div>
	<c:if test="${reviewDetail.filesize != 0}">
		<div class="row">
			<div class="col-md-12">
				÷�ε� ���� : <img src="<spring:url value='/image/${reviewDetail.image}'/>" border="0"
					style="max-width: 300px; max-height: 300px;">
			</div>
		</div>
	</c:if>
	<c:if test="${sessionScope.userId == reviewDetail.id}">
		<div class="row">
			<div class="col-md-12" align="center">
				<button class="btn btn-info btn-sm" type="button"
					onclick="review_edit('${reviewDetail.article_num}')">�ۼ���</button>
				<button class="btn btn-warning btn-sm" type="button"
					onclick="review_delete('${reviewDetail.article_num}')">�ۻ���</button>
			</div>
		</div>
	</c:if>
	<c:if test="${sessionScope.userGrade ==2 }">
		<br>
		<div align="center">
			<button class="btn btn-danger btn-sm" type="button"
				onclick="javascript:changeVisibleStatus()" id="visibleStatus">
				<c:if test="${reviewDetail.visible == 1 }">��Ȱ��ȭ</c:if>
				<c:if test="${reviewDetail.visible == -1 }">Ȱ��ȭ</c:if>
			</button>
		</div>
	</c:if>

	<c:if
		test="${!empty sessionScope.userId && sessionScope.userId != reviewDetail.id}">
		<div class="row">
			<div class="col-md-12" align="center">
				<button class="btn btn-info btn-sm" type="button"
					onclick="javascript:somethingDo('up')" id="boardUp">
					<h5 id="upcount">${reviewDetail.upCount}</h5>
					��õ
				</button>
				<button class="btn btn-secondary btn-sm" type="button"
					onclick="javascript:somethingDo('down')" id="boardDown">
					<h5 id="downcount">${reviewDetail.downCount}</h5>
					����õ
				</button>
				<a class="btn btn-warning btn-sm" data-target="#reportModal"
					data-toggle="modal">�Ű��ϱ�</a>
			</div>
		</div>
	</c:if>

	<hr />
	<form class="form-horizontal" name="f" method="post"
		action="review_reply_write.board" onsubmit="return check()">
		<input type="hidden" name="id" value="${sessionScope.userId}">
		<input type="hidden" name="article_num"
			value="${reviewDetail.article_num}">
		<c:if test="${reviewDetail.replyCount != 0}">
			<c:forEach var="dto" items="${replyList}">
				<div class="row"
					style="padding: 5px 5px 5px ${5+dto.re_level*13}px; background-color: #F7F7F7;">
					<div class="col-md-12" align="left">
						<c:if test="${dto.re_level>0}">
					&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
						<c:if test="${dto.grade == 1 }">
							<img class="media-object img-circle"
								style="width: 30px; height: 30px;"
								src="resources/img/${dto.academyLocation }.jpg">
								${dto.academyLocation}
						</c:if>
						<c:if test="${dto.grade != 1 }">
							<img class="media-object img-circle"
								style="width: 30px; height: 30px;"
								src="resources/img/${dto.grade }.jpg">
						</c:if>
						<c:choose>
						<c:when test="${dto.grade==2}"><font style="color:#FF0000;  font-weight:bold;">${dto.id}</font></c:when>
						<c:otherwise>${dto.id}</c:otherwise>
					</c:choose>
					 <font color="gray">${dto.regdate}
							${dto.regdate_time} | </font>
						<c:if
							test="${sessionScope.userId == dto.id || sessionScope.userGrade == 2}">
							<a
								href="javascript:deleteReply('${dto.reply_num}','${reviewDetail.article_num}');">[����]</a>
						</c:if>
					</div>
					<div class="col-md-12" align="left">
						<c:if test="${dto.re_level>0}">
							<img class="media-object img-circle"
								style="width: 20px; height: 20px;" src="resources/img/reply.png">
						</c:if>
						${dto.content}
					</div>
					<div class="col-md-12" align="right" id="buttontype">
						<input type="button" class="btn btn-info btn-sm" value="��۾���"
							onclick="addInput('${dto.reply_num}','${dto.id}');" />
					</div>
				</div>
			</c:forEach>
		</c:if>
		<script>
			var reReply_open = new Array(0);

			function addInput(num, id) {
				reReply_open.push(reReply_open.length);
				reReInput(num, id);
				f.content.focus();
			}
			function reReInput(num, id) {
				document.getElementById('inputReply').innerHTML = "<div class='input-group' style='padding:5px 5px 5px 5px; border:1; border-color:#F7F7F7;'>"
						+ "<input type='hidden' name='reply_num' value='"+num+"'>"
						+ "<input type='button' class='btn btn-info btn-sm' value='@"+id+"' readonly>"
						+ "<input type='button' class='btn btn-info btn-sm' value='X' onclick='deleteTag()'>"
						+ "<textarea class='form-control' rows='2' name='content' placeholder='����� �����ּ���'></textarea>"
						+ "<input class='btn btn-secondary btn-sm' type='submit' value='��۴ޱ�'>"
						+ "</div>"
			}
			function deleteTag() {
				if (reReply_open.length > 0) {
					reReply_open.pop();
				}
				originReply();
			}
			function originReply() {
				document.getElementById('inputReply').innerHTML = "<div class='input-group' style='padding:5px 5px 5px 5px; border:1; border-color:#F7F7F7;'>"
						+ "<textarea class='form-control' rows='2' name='content' placeholder='����� �����ּ���'></textarea>"
						+ "<input class='btn btn-secondary btn-sm' type='submit' value='��۴ޱ�'>"
						+ "</div>"
			}
		</script>
		<div id="inputReply">
			<div class="input-group"
				style="padding: 5px 5px 5px 5px; border: 1; border-color: #F7F7F7;">
				<textarea class="form-control" rows="2" name="content"
					placeholder="����� �����ּ���"></textarea>
				<input class="btn btn-secondary btn-sm" type="submit" value="��۴ޱ�">
			</div>
		</div>
	</form>
</div>
<div class="row">
	<div class="modal" id="reportModal" tabindex="-1">
		<script type="text/javascript">
	function reportBoard(){
		var reportContent = $('#reportContent').val();
		var table = "ezen_notice_board";
		if(reportContent == null || reportContent ===""){
			alert("�Ű����� �Է������ʾ� ��ҵ˴ϴ�.");
			return;
		}
		$.ajax({
			type: "POST",
			url: "reportPro.board",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data : {
				reportContent: reportContent,
				userId : '${sessionScope.userId}',
				article_num : '${reviewDetail.article_num}',
				table : table
			},
			datatype : 'text',
			success: function(result){
				if(result === '-2'){
					alert('�ߺ��Ű�� �Ұ��մϴ�. �Ű�� ���������̳� ��Ҵ� �����ڿ��� �����ϼ���.')
				}else if(result === '1'){
					alert('�Ű�ó�� �Ǿ����ϴ�.')
				}else{
					alert('�Ű�ó�� ���� ������ �߻��߽��ϴ�. �����ڿ��� �����ϼ���')
				}
			}
		})
	}
	</script>
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					�Խù� �Ű��ϱ�
					<button class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body" style="text-align: center;">
					�Ű� ����<br>
					<textarea id="reportContent" placeholder="�Ű����� �Է����ּ���."
						style="resize: none;"></textarea>
					<hr>
					<button class="close btn-danger" data-dismiss="modal"
						onclick="javascript:reportBoard()">�Ű��ϱ�</button>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../footer.jsp" />