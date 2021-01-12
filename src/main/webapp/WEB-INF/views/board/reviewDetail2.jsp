<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	function check(){
		if (f.content.value==""){
			alert("��� ������ �Է��� �ּ���!!")
			f.content.focus()
			return false
		}
		return true
	}
	
</script>
<jsp:include page="../header.jsp" />
<div class="container" style="margin-top:30px; margin-bottom:10px;">
	<h5><font size="3">����'sTop�Խ��� > ������ ���� �ı�Խ��� > </font><b>�Խñۺ���</b></h5>
	<div class="row" style="padding-left:10px; padding-top:10px; padding-bottom:10px; background-color:#EFF7EA;">
		<div class="col-md-3">${reviewDetail.id}</div>
		<div class="col-md-6"><b>${reviewDetail.subject}</b></div>
		<div class="col-md-3" align="right">��ȸ ${reviewDetail.readCount} | ��õ�� ${reviewDetail.upCount}</div>
	</div>
	<div class="row" style="padding-top:10px;">
		<div class="col-md-12" align="right"><font color="gray">${reviewDetail.regdate} ${reviewDetail.regdate_time}</font>&nbsp;���[${reviewDetail.replyCount}] </div>
	</div>
	<hr/>
	<div class="row" style="padding:0px 10px 20px 20px; min-height:300px;">
		<div class="col-md-12">
		${reviewDetail.content}
		</div>
	</div>
	<div class="row">
		<div class="col-md-12" align="center">
		<button class="btn btn-info btn-sm" type="button">��õ</button>
		<button class="btn btn-secondary btn-sm" type="button">����õ</button>
		<button class="btn btn-warning btn-sm" type="button">�Ű��ϱ�</button>
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
		<div class="col-md-12" align="right" id="buttontype"><input type="button" class="btn btn-info btn-sm" value="��۾���" onclick="addInput();"/>
<script>
var reReply_open = new Array(0);
var reReply_Value = new Array(0);

function addInput() {
reReply_open.push(reReply_open.length);
reReply_Value.push("");
reReInput();
}
function reReInput(){
	document.getElementById('buttontype').innerHTML=
		"<input type='hidden' name='reply_num' value='"+${dto.reply_num}+"'/> "+
		"<div class='input-group' style='padding:0px 0px 5px 5px; border:1; border-color:#F7F7F7;'>"+
		"<textarea class='form-control' rows='1' name='content' placeholder='����� �����ּ���'></textarea>"+
		"<input class='btn btn-secondary btn-sm' type='button' value='���' onclick='deleteInput();'/> "+
		"<input class='btn btn-info btn-sm' type='submit' value='��۴ޱ�'/>"+
		"</div>"
}
function addbutton(){
	document.getElementById('buttontype').innerHTML=
		"<input type='button' class='btn btn-info btn-sm' value='��۾���' onclick='addInput();'/>"
}
function deleteInput() {
if (reReply_open.length > 0) { 
   reReply_open.pop(); 
   reReply_Value.pop();
}
addbutton(); 
}
</script>		
		</div>
	</div>
	</c:forEach>
	</c:if>
	<div class="input-group" style="padding:5px 5px 5px 5px; border:1; border-color:#F7F7F7;">
		<textarea class="form-control" rows="2" name="content" placeholder="����� �����ּ���"></textarea>
		<input class="btn btn-info btn-sm" type="submit" value="��۴ޱ�">
	</div>
	</form>
</div>
<jsp:include page="../footer.jsp" />