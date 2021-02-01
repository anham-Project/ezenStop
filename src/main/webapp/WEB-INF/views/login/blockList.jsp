<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<script>
	function check(){
		if (f.searchString.value==""){
			alert("�˻�� �ʼ��� �Է��ؾ� �մϴ�!!")
			f.searchString.focus()
			return false
		}
		return true
	}
</script>
<form name="f" action="blockList_search.login" method="post" onsubmit="return check()">
	<div class="row" style="padding-bottom:5px">
		<div class="col-md-6">
		</div>    
        <div class="col-md-6">
		    <div class="input-group">
                <select class="form-control" name="searchType" style="width:20%;">
	 				<option value="blockId">���̵�</option>
					<option value="memo">����</option>
				</select>
                <input type="text" class="form-control" name="searchString" placeholder="�˻�� �Է��ϼ���." style="width:65%;">
                <span class="input-group-btn">
                    <button class="btn btn-secondary" type="submit">�˻�</button>
                </span>
            </div>
        </div>
	</div>
	<input type="hidden" name ="id" value="${sessionScope.userId}">
 </form>
	<table class="table table-condensed table-hover text-center">
	<thead>
		<tr>
			<th width="20%">���� ���̵�</th>
			<th width="65%">���� ����</th>
			<th width="15%">���� ����</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${empty list}">		
		<tr>
			<td colspan="3">������ ȸ���� �����ϴ�.</td>
		</tr>
</c:if>		
<c:forEach var="dto" items="${list}">
		<tr>
			<td align="center">${dto.blockId}</td>
			<td align="center">${dto.memo}</td>
			<td align="center"><a href="#">���� ����</a></td>
		</tr>
</c:forEach>
	</tbody>
	</table>
	<div class="row">
<c:if test="${count>0}">
	<div class="col-md-4">
	</div>
	<div class="col-md-6">
	<ul class = "pagination">
	<c:if test="${startPage > pageBlock}">	
		<li class="page-item"><a class="page-link" href="reportBoard.board?pageNum=${startPage-pageBlock}">����</a></li>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<li class="page-item"><a class="page-link" href="reportBoard.board?pageNum=${i}">${i}</a></li>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<li class="page-item"><a class="page-link" href="reportBoard.board?pageNum=${endPage+pageBlock}">����</a></li>
	</c:if>
	</ul>
	</div>
</c:if>
	</div>
<%@include file="myPage_bot.jsp"%>