<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		location.href = "review_reply_delete.board?reply_num=" + r_num
				+ "&article_num=" + a_num;
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
				alert(result);
				if(result === '-2'){
					alert('이미 추천/비추천/신고 행동을 하였습니다.')
				}else if(result === '1'){
					if(somethingDo === 'up'){
						alert('추천되었습니다.')
					}else{
						alert('비추천되었습니다.')
					}
				}else{
					alert('추천/비추천 중 오류가 발생했습니다. 관리자에게 문의하세요.')
				}
			}
		})
	}
</script>
<jsp:include page="../header.jsp" />
<div class="container" style="margin-top: 30px; margin-bottom: 10px;">
	<h5>
		<font size="3">이젠'sTop게시판 > <a href="review_list.board">지역별
				강의 후기게시판</a> >
		</font><b>게시글보기</b>
	</h5>
	<div class="row"
		style="padding-left: 10px; padding-top: 10px; padding-bottom: 10px; background-color: #EFF7EA;">
		<div class="col-md-3">${reviewDetail.id}</div>
		<div class="col-md-6 text-center">
			<b>${reviewDetail.subject}</b>
		</div>
		<div class="col-md-3" align="right">조회 ${reviewDetail.readCount}
			| 추천수 ${reviewDetail.upCount}</div>
	</div>
	<div class="row" style="padding-top: 10px;">
		<div class="col-md-12" align="right">
			<font color="gray">${reviewDetail.regdate}
				${reviewDetail.regdate_time}</font>&nbsp;댓글[${reviewDetail.replyCount}]
		</div>
	</div>
	<hr />
	<div class="row"
		style="padding: 0px 10px 20px 20px; min-height: 300px;">
		<div class="col-md-12">${reviewDetail.content}</div>
	</div>
	<c:if test="${sessionScope.userId == reviewDetail.id}">
		<div class="row">
			<div class="col-md-12" align="center">
				<button class="btn btn-info btn-sm" type="button"
					onclick="review_edit('${reviewDetail.article_num}')">글수정</button>
				<button class="btn btn-warning btn-sm" type="button"
					onclick="review_delete('${reviewDetail.article_num}')">글삭제</button>
			</div>
		</div>
	</c:if>
	<c:if test="${!empty sessionScope.userId && sessionScope.userId != reviewDetail.id}">
		<div class="row">
			<div class="col-md-12" align="center">
				<button class="btn btn-info btn-sm" type="button"
					onclick="javascript:somethingDo('up')" id="boardUp">${reviewDetail.upCount }추천</button>
				<button class="btn btn-secondary btn-sm" type="button"
					onclick="javascript:somethingDo('down')" id="boardDown">${reviewDetail.downCount }비추천</button>
				<button class="btn btn-warning btn-sm" type="button"
					onclick="javascript:reportBoard()" id="boardReport">신고하기</button>
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
					style="padding: 5px 5px 5px 5px; background-color: #F7F7F7;">
					<div class="col-md-12" align="left">${dto.id}
						<font color="gray">${dto.regdate} ${dto.regdate_time} | </font>
						<c:if test="${sessionScope.userId == dto.id}">
							<a
								href="javascript:deleteReply('${dto.reply_num}','${reviewDetail.article_num}');">[삭제]</a>
						</c:if>
					</div>
					<div class="col-md-12" align="left">${dto.content}</div>
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
						+ "<textarea class='form-control' rows='2' name='content' placeholder='댓글을 남겨주세요'></textarea>"
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
						+ "<textarea class='form-control' rows='2' name='content' placeholder='댓글을 남겨주세요'></textarea>"
						+ "<input class='btn btn-secondary btn-sm' type='submit' value='댓글달기'>"
						+ "</div>"
			}
		</script>
		<div id="inputReply">
			<div class="input-group"
				style="padding: 5px 5px 5px 5px; border: 1; border-color: #F7F7F7;">
				<textarea class="form-control" rows="2" name="content"
					placeholder="댓글을 남겨주세요"></textarea>
				<input class="btn btn-secondary btn-sm" type="submit" value="댓글달기">
			</div>
		</div>
	</form>
</div>
<jsp:include page="../footer.jsp" />