<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
<script type="text/javascript">
	function check(){
		if (f.content.value==""){
			alert("댓글 내용을 입력해 주세요!!")
			f.content.focus()
			return false
		}
		return true
	}
</script>
<script type="text/javascript">
$(document).ready(function() {
	$('.show1').show(); //페이지를 로드할 때 표시할 요소
	$('.show2').hide(); //페이지를 로드할 때 숨길 요소
	$('.show1').click(function(){
	$(this).replaceWith($('.show2')); //클릭 시 두번째 요소로 변경
	return false;
	});
});
</script>
<jsp:include page="../header.jsp" />
<div class="container" style="margin-top:30px; margin-bottom:10px;">
	<h5><font size="3">이젠'sTop게시판 > 지역별 강의 후기게시판 > </font><b>게시글보기</b></h5>
	<div class="row" style="padding-left:10px; padding-top:10px; padding-bottom:10px; background-color:#EFF7EA;">
		<div class="col-md-3">${reviewDetail.id}</div>
		<div class="col-md-6"><b>${reviewDetail.subject}</b></div>
		<div class="col-md-3" align="right">조회 ${reviewDetail.readCount} | 추천수 ${reviewDetail.upCount}</div>
	</div>
	<div class="row" style="padding-top:10px;">
		<div class="col-md-12" align="right"><font color="gray">${reviewDetail.regdate} ${reviewDetail.regdate_time}</font>&nbsp;댓글[${reviewDetail.replyCount}] </div>
	</div>
	<hr/>
	<div class="row" style="padding:0px 10px 20px 20px; min-height:300px;">
		<div class="col-md-12">
		${reviewDetail.content}
		</div>
	</div>
	<div class="row">
		<div class="col-md-12" align="center">
		<button class="btn btn-info btn-sm" type="button">추천</button>
		<button class="btn btn-secondary btn-sm" type="button">비추천</button>
		<button class="btn btn-warning btn-sm" type="button">신고하기</button>
		</div>
	</div>
	<hr/>
	<form class="form-horizontal" name="f" method="post" 
		action="review_reply_write.board"onsubmit="return check()">
		<input type="hidden" name="id" value="testUser1">
		<input type="hidden" name="article_num" value="${reviewDetail.article_num}">
	<c:if test="${reviewDetail.replyCount != 0}">		
	<c:forEach var="dto" items="${replyList}">
	<div class="row" style="padding:5px 5px 5px 5px; background-color:#F7F7F7;">
		<div class="col-md-12" align="left">${dto.id} <font color="gray">${dto.regdate} ${dto.regdate_time} | </font></div>
		<div class="col-md-12" align="left">${dto.content}</div>
		<div class="col-md-12" align="right" id="buttontype">
<script>
var reReply_open = new Array(0);
var reReply_Value = new Array(0);

function addInput() {
reReply_open.push(reReply_open.length);
reReply_Value.push("");
reReInput();
}
</script>
		<div class="show1">
		<input type="button" class="btn btn-info btn-sm" value="답글쓰기">
		</div>
		<div class="show2">
			<input type='hidden' name='reply_num' value='"+${dto.reply_num}+"'/>
			<div class='input-group' style='padding:0px 0px 5px 5px; border:1; border-color:#F7F7F7;'>
				<textarea class='form-control' rows='1' name='content' placeholder='댓글을 남겨주세요'></textarea>
				<input class='btn btn-secondary btn-sm' type='button' value='취소' onclick='deleteInput();'/>
				<input class='btn btn-info btn-sm' type='submit' value='댓글달기'/>
			</div>
		</div>
	</div>
	</div>
	</c:forEach>
	</c:if>
	<div class="input-group" style="padding:5px 5px 5px 5px; border:1; border-color:#F7F7F7;">
		<textarea class="form-control" rows="2" name="content" placeholder="댓글을 남겨주세요"></textarea>
		<input class="btn btn-info btn-sm" type="submit" value="댓글달기">
	</div>
	</form>
</div>
<jsp:include page="../footer.jsp" />