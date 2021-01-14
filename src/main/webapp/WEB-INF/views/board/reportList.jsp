<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp" />
<div class="container" style="margin-top:30px; margin-bottom:10px">
<script type="text/javascript">
	function check(){
		if (f.searchString.value==""){
			alert("검색어를 필수로 입력해야 합니다!!")
			f.searchString.focus()
			return false
		}
		return true
	}
</script>
	<h5><font size="3">이젠'sTop게시판 > </font><b>신고 게시판</b></h5>
<form name="f" action="review_find.board" method="post" onsubmit="return check()">
	<div class="row" style="padding-bottom:5px">
		<div class="col-md-6">
		</div>    
        <div class="col-md-6">
		    <div class="input-group">
                <select class="form-control" name="searchType" style="width:20%;">
	 				<option value="id">신고자</option>
	 				<option value="article_num">신고된 글번호</option>
					<option value="reportContent">신고내용</option>
				</select>
                <input type="text" class="form-control" name="searchString" placeholder="검색어를 입력하세요." style="width:65%;">
                <span class="input-group-btn">
                    <button class="btn btn-secondary" type="submit">검색</button>
                </span>
            </div>
        </div>
	</div>
 </form>
	<table class="table table-hover text-center">
	<thead>
		<tr>
			<th width="8%">신고된<br>글 번호</th>
			<th width="58%">신고내용</th>
			<th width="12%">신고자</th>
			<th width="12%">신고일</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${empty reportList}">		
		<tr>
			<td colspan="4">신고된 게시글이 없습니다.</td>
		</tr>
</c:if>		
<c:forEach var="dto" items="${reportList}">
		<tr>
			<td align="center"><c:out value="${dto.article_num}"/></td>
			<c:set var="startNum" value="${startNum-1}"/>
			<td align="left">			
				<a href="review_detail.board?article_num=${dto.article_num}">
				${dto.reportContent}
				</a>	
			</td>
			<td align="center">${dto.userId}</td>
			<td align="center">${dto.reportDate}</td>
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
</div>
<jsp:include page="../footer.jsp" />