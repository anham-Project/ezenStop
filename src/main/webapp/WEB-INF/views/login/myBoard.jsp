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
	<h5><b>내 게시판 </b></h5>
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
	<input type="hidden" name ="id" value="${sessionScope.userId}">
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
				<c:if test="${dto.image != '파일없음' }">
				<img class="media-object img-circle" style = "width: 14px; height: 12px;" src = "resources/img/picture.png">
				</c:if>
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
	<div class="col-md-10">
	<ul class = "pagination justify-content-center">
	<c:if test="${startPage > pageBlock}">	
		<li class="page-item"><a class="page-link" href="myBoard.login?pageNum=${startPage-pageBlock}">이전</a></li>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<c:choose>
			<c:when test="${i == currentPage}">
			<li class="page-item active"><a class="page-link" href="myBoard.login?pageNum=${i}">${i}</a></li>
			</c:when>
			<c:when test="${currentPage == null}">
				<c:if test="${i == 1}">
				<li class="page-item active"><a class="page-link" href="myBoard.login?pageNum=${i}">${i}</a></li>
				</c:if>
				<c:if test="${i != 1}">
				<li class="page-item"><a class="page-link" href="myBoard.login?pageNum=${i}">${i}</a></li>
				</c:if>
			</c:when>
			<c:otherwise>
			<li class="page-item"><a class="page-link" href="myBoard.login?pageNum=${i}">${i}</a></li>
			</c:otherwise>
			</c:choose>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<li class="page-item"><a class="page-link" href="myBoard.login?pageNum=${startPage+pageBlock}">다음</a></li>
	</c:if>
	</ul>
	</div>
	</c:if>
	</div>
</div>
<jsp:include page="../footer.jsp" />