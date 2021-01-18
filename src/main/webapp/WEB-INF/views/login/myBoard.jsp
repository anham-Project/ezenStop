<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="../header.jsp" />
<div class="container" style="margin-top:30px; margin-bottom:10px">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	function check(){
		if (f.searchString.value==""){
			alert("검색어를 필수로 입력해야 합니다!!")
			f.searchString.focus()
			return false
		}
		return true
	}
	function findDetailPage(article_num){
		$.ajax({
			type: "POST",
			url: "getDetail.board",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data: {
				article_num: article_num
			},
			success: function(result){
				location.href=result+'?article_num='+article_num;
			}
		})
		
	}
</script>
	<h5><font size="3">내 게시판 </font></h5>
<form name="f" action="myBoard_find.board" method="post" onsubmit="return check()">
	<div class="row" style="padding-bottom:5px">
		<div class="col-md-6">
		</div>    
        <div class="col-md-6">
		    <div class="input-group">
                <select class="form-control" name="searchType" style="width:20%;">
	 				<option value="subject">제목</option>
					<option value="content">내용</option>
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
			<th width="8%">글 번호</th>
			<th width="58%">제목</th>
			<th width="12%">작성일</th>
			<th width="12%">조회수</th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${empty list}">		
		<tr>
			<td colspan="4">내가 쓴 게시글이 없습니다.</td>
		</tr>
	</c:if>		
	<c:forEach var="dto" items="${list}">
		<tr>
		
			<td align="center"><c:out value="${dto.article_num}" /></td>
			<td align="left">			
				<form name="f" onclick="javascript:findDetailPage('${dto.article_num}')">
				<a href="#">${dto.subject}</a>
				</form>
			</td>
			<td align="center">${dto.regdate}</td>
			<td align="center">${dto.readCount}</td>
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
					<li class="page-item"><a class="page-link" href="myBoard.board?pageNum=${startPage-pageBlock}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<li class="page-item"><a class="page-link" href="myBoard.board?pageNum=${i}">${i}</a></li>
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					<li class="page-item"><a class="page-link" href="myBoard.board?pageNum=${endPage+pageBlock}">다음</a></li>
				</c:if>
			</ul>
		</div>
	</c:if>
	</div>
</div>
<jsp:include page="../footer.jsp" />