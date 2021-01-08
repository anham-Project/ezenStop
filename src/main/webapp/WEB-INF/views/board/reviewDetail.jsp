<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<button class="btn btn-info btn-sm" type="button" onclick="#">��õ</button>
		<button class="btn btn-secondary btn-sm" type="button" onclick="#">����õ</button>
		<button class="btn btn-warning btn-sm" type="button" onclick="#">�Ű��ϱ�</button>
		</div>
	</div>
	<hr/>
	<form class="form-horizontal" name="f" action="review_reply_write.board" method="post">
<c:if test="${reviewDetail.replyCount != 0}">		
	<table>
	<c:forEach var="dto" items="${replyList}">
		<tr>
			<td align="center">${dto.id}</td>
			<td align="center">${dto.regdate}</td>
			<td align="center">${dto.regdate_time}</td>
			<td align="center">${dto.content}</td>
		</tr>
	</c:forEach>
	</table>
</c:if>			
	<div class="input-group" style="padding:5px 5px 5px 5px; background-color:#F7F7F7;">
		<textarea class="form-control" rows="2" name="content" placeholder="����� �����ּ���"></textarea>
		<input class="btn btn-secondary btn-sm" type="submit" value="��۴ޱ�">
	</div>
	</form>
</div>
<jsp:include page="../footer.jsp" />