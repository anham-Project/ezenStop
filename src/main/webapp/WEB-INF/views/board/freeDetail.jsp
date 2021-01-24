<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<script type="text/javascript">
	function check() {
		if (f.content.value == "") {
			alert("댓글 내용을 입력해 주세요!!")
			f.content.focus()
			return false
		}
		return true
	}
	function deleteReply(r_num, a_num) {
		location.href = "free_reply_delete.board?reply_num=" + r_num
				+ "&article_num=" + a_num;
	}
	function free_edit(a_num){
		location.href = "free_edit.board?article_num=" + a_num;
	}
	function free_delete(a_num){
		location.href = "free_delete.board?article_num=" + a_num;
	}
	function somethingDo(somethingDo){
		var article_num = '${freeDetail.article_num}';
		var userId = '${sessionScope.userId}';
		var table = "ezen_free_board";
		$.ajax({
			type : "POST",
			url : "commonUpdownPro.board",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data : {
				article_num : article_num,
				userId : userId,
				table : table,
				somethingDo : somethingDo
			},
			datatype : 'text',
			success : function(result){
				if(result === '-2'){
					alert('이미 추천/비추천/신고 행동을 하였습니다.')
				}else if(result === '1'){
					if(somethingDo === 'up'){
						alert('추천되었습니다.')
						$('#upcount').html(${freeDetail.upCount}+1);
					}else{
						alert('비추천되었습니다.')
						$('#downcount').html(${freeDetail.downCount}+1);
					}
				}else{
					alert('추천/비추천 중 오류가 발생했습니다. 관리자에게 문의하세요.')
				}
				
			}
		})
	}
	function changeVisibleStatus(){
		var article_num = '${freeDetail.article_num}';
		var table = "ezen_free_board";
		$.ajax({
			type: "POST",
			url: "A_changeVisibleStatus.board",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data: {
				article_num: article_num ,
				table : table
			},
			datatype: 'text',
			success: function(result){
				alert("처리되었습니다.")
				window.location.reload();
			}
		})
	}
</script>
<jsp:include page="../header.jsp" />
<div class="container" style="margin-top: 30px; margin-bottom: 10px;">
	<h5>
		<font size="3">이젠'sTop게시판 > <a href="free_list.board" class="blackA">자유게시판</a> >
		</font><b>게시글보기</b>
	</h5>
	<div class="row"
		style="padding-left: 10px; padding-top: 10px; padding-bottom: 10px; background-color: #EFF7EA;">
		<div class="col-md-3">
			<c:if test="${freeDetail.grade == 1 }">
				<img class="media-object img-circle"
					style="width: 30px; height: 30px;"
					src="resources/img/${freeDetail.academyLocation }.png">
			</c:if>
			<c:if test="${freeDetail.grade != 1 }">
				<img class="media-object img-circle"
					style="width: 30px; height: 30px;"
					src="resources/img/${freeDetail.grade }.png">
			</c:if>
			<c:choose>
			<c:when test="${freeDetail.grade==2}"><font style="color:#FF0000;  font-weight:bold;">${freeDetail.id}</font></c:when>
			<c:otherwise>${freeDetail.id}</c:otherwise>
		</c:choose>
		</div>
		<div class="col-md-6 text-center">
			<b>${freeDetail.subject}</b>
		</div>
		<div class="col-md-3" align="right">조회 ${freeDetail.readCount}
			| 추천수 ${freeDetail.upCount}</div>
	</div>
	<div class="row" style="padding-top: 10px;">
		<div class="col-md-12" align="right">
			<font color="gray">${freeDetail.regdate}
				${freeDetail.regdate_time}</font>&nbsp;댓글[${freeDetail.replyCount}]
		</div>
	</div>
	<hr />
	<div class="row"
		style="padding: 0px 10px 20px 20px; min-height: 300px;">
		<div class="col-md-12">${freeDetail.content}</div>
	</div>
	<c:if test="${freeDetail.filesize != 0}">
		<div class="row">
			<div class="col-md-12">
				첨부된 파일 : <img src="<spring:url value='/image/${freeDetail.image}'/>" border="0"
					style="max-width: 300px; max-height: 300px;">
			</div>
		</div>
	</c:if>
	<c:if test="${sessionScope.userId == freeDetail.id}">
		<div class="row">
			<div class="col-md-12" align="center">
				<button class="btn btn-info btn-sm" type="button"
					onclick="free_edit('${freeDetail.article_num}')">글수정</button>
				<button class="btn btn-warning btn-sm" type="button"
					onclick="free_delete('${freeDetail.article_num}')">글삭제</button>
			</div>
		</div>
	</c:if>
	<c:if test="${sessionScope.userGrade ==2 }">
		<br>
		<div align="center">
			<button class="btn btn-danger btn-sm" type="button"
				onclick="javascript:changeVisibleStatus()" id="visibleStatus">
				<c:if test="${freeDetail.visible == 1 }">비활성화</c:if>
				<c:if test="${freeDetail.visible == -1 }">활성화</c:if>
			</button>
		</div>
	</c:if>

	<c:if
		test="${!empty sessionScope.userId && sessionScope.userId != freeDetail.id}">
		<div class="row">
			<div class="col-md-12" align="center">
				<button class="btn btn-info btn-sm" type="button"
					onclick="javascript:somethingDo('up')" id="boardUp">
					<h5 id="upcount">${freeDetail.upCount}</h5>
					추천
				</button>
				<button class="btn btn-secondary btn-sm" type="button"
					onclick="javascript:somethingDo('down')" id="boardDown">
					<h5 id="downcount">${freeDetail.downCount}</h5>
					비추천
				</button>
				<a class="btn btn-warning btn-sm" data-target="#reportModal"
					data-toggle="modal">신고하기</a>
			</div>
		</div>
	</c:if>

	<hr />
	<form class="form-horizontal" name="f" method="post"
		action="free_reply_write.board" onsubmit="return check()">
		<input type="hidden" name="id" value="${sessionScope.userId}">
		<input type="hidden" name="article_num"
			value="${freeDetail.article_num}">
		<c:if test="${freeDetail.replyCount != 0}">
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
								src="resources/img/${dto.academyLocation }.png">
								${dto.academyLocation}
						</c:if>
						<c:if test="${dto.grade != 1 }">
							<img class="media-object img-circle"
								style="width: 30px; height: 30px;"
								src="resources/img/${dto.grade }.png">
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
								href="javascript:deleteReply('${dto.reply_num}','${freeDetail.article_num}');">[삭제]</a>
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
						<input type="button" class="btn btn-info btn-sm" value="답글쓰기"
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
						+ "<textarea class='form-control' rows='2' name='content' placeholder='댓글을 남겨주세요'"
						+ "<c:if test='${empty sessionScope.userId}'>disabled</c:if>></textarea>"
						+ "<input class='btn btn-secondary btn-sm' type='submit' value='댓글달기'>"
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
						+ "<textarea class='form-control' rows='2' name='content' placeholder='댓글을 남겨주세요'"
						+ "<c:if test='${empty sessionScope.userId}'>disabled</c:if>></textarea>"
						+ "<input class='btn btn-secondary btn-sm' type='submit' value='댓글달기'>"
						+ "</div>"
			}
		</script>
		<div id="inputReply">
			<div class="input-group"
				style="padding: 5px 5px 5px 5px; border: 1; border-color: #F7F7F7;">
				<textarea class="form-control" rows="2" name="content"
					placeholder="댓글을 남겨주세요" <c:if test="${empty sessionScope.userId}">disabled</c:if>></textarea>
				<input class="btn btn-secondary btn-sm" type="submit" value="댓글달기">
			</div>
		</div>
	</form>
</div>
<div class="row">
	<div class="modal" id="reportModal" tabindex="-1">
		<script type="text/javascript">
	function reportBoard(){
		var reportContent = $('#reportContent').val();
		var table = "ezen_free_board";
		if(reportContent == null || reportContent ===""){
			alert("신고내용을 입력하지않아 취소됩니다.");
			return;
		}
		$.ajax({
			type: "POST",
			url: "reportPro.board",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data : {
				reportContent: reportContent,
				userId : '${sessionScope.userId}',
				article_num : '${freeDetail.article_num}',
				table : table
			},
			datatype : 'text',
			success: function(result){
				if(result === '-2'){
					alert('중복신고는 불가합니다. 신고글 수정사항이나 취소는 관리자에게 문의하세요.')
				}else if(result === '1'){
					alert('신고처리 되었습니다.')
				}else{
					alert('신고처리 도중 에러가 발생했습니다. 관리자에게 문의하세요')
				}
			}
		})
	}
	</script>
		<div class="modal-dialog">
			<div class="modal-content" style="background-color:#F8D7DA;">
				<div class="lingBox rounded bg-light shadow" style="margin:15px;">
				<div class="modal-header" style="margin:5px 15px 5px 15px; padding:5px;">
					<h4><b>게시물 신고하기</b></h4>
					<button class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div class="form-group" style="margin:5px; padding:5px;">
					<h5><b>신고 사유</b></h5>
					<textarea class="form-control" rows="2" id="reportContent" placeholder="신고내역을 입력해주세요."
						style="resize: none;"></textarea>
					</div>
					<hr/>
					<div align="right">
					<button class="btn btn-danger" data-dismiss="modal"
						onclick="javascript:reportBoard()">신고하기</button>
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../footer.jsp" />