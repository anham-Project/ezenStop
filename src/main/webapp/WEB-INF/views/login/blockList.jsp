<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<script>
	function check(){
		if (f.searchString.value==""){
			alert("검색어를 필수로 입력해야 합니다!!")
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
	 				<option value="blockId">아이디</option>
					<option value="memo">내용</option>
				</select>
                <input type="text" class="form-control" name="searchString" placeholder="검색어를 입력하세요." style="width:65%;">
                <span class="input-group-btn">
                    <button class="btn btn-secondary" type="submit">검색</button>
                </span>
            </div>
        </div>
	</div>
	<input type="hidden" name ="id" value="${sessionScope.userId}">
 </form>
	<table class="table table-condensed table-hover text-center">
	<thead>
		<tr>
			<th width="20%">차단 아이디</th>
			<th width="65%">차단 내용</th>
			<th width="15%">차단 해제</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${empty list}">		
		<tr>
			<td colspan="3">차단한 회원이 없습니다.</td>
		</tr>
</c:if>		
<c:forEach var="dto" items="${list}">
		<tr>
			<td align="center">${dto.blockId}</td>
			<td align="center">${dto.memo}</td>
			<td align="center"><a href="#">차단 해제</a></td>
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
		<li class="page-item"><a class="page-link" href="reportBoard.board?pageNum=${startPage-pageBlock}">이전</a></li>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<li class="page-item"><a class="page-link" href="reportBoard.board?pageNum=${i}">${i}</a></li>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<li class="page-item"><a class="page-link" href="reportBoard.board?pageNum=${endPage+pageBlock}">다음</a></li>
	</c:if>
	</ul>
	</div>
</c:if>
	</div>
<%@include file="myPage_bot.jsp"%>