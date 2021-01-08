<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp" />
<div class="container" style="margin-top:30px; margin-bottom:10px">
	
	<h2><b>후 기 게 시 판</b></h2>
	<div class="row" style="padding-bottom:5px">
		<div class="col-md-6">
		</div>    
        <div class="col-md-6">
		    <div class="input-group">
                <select class="form-control" name="searchType" style="width:20%;">
	 				<option value="id">작성자</option>
	 				<option value="subject">제목</option>
					<option value="content">내용</option>
				</select>
                <input type="text" class="form-control" name="searchString" placeholder="검색어를 입력하세요." style="width:65%;">
                <span class="input-group-btn">
                    <button class="btn btn-secondary" type="button">검색</button>
                </span>
            </div>
        </div>
	</div>
	<table class="table table-hover text-center">
	<thead>
		<tr>
			<th width="8%"></th>
			<th width="50%">제 목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${empty reviewList}">		
		<tr>
			<td colspan="5">등록된 게시글이 없습니다.</td>
		</tr>
</c:if>		
<c:forEach var="dto" items="${reviewList}">
		<tr>
			<td align="center"><c:out value="${startNum}"/></td>
			<c:set var="startNum" value="${startNum-1}"/>
			<td>			
				<a href="#?article_num=${dto.article_num}">
					${dto.subject}
				</a>	
			</td>
			<td align="center">${dto.id}</td>
			<td align="center">${dto.regdate}</td>
			<td align="center">${dto.readcount}</td>
		</tr>
</c:forEach>
	</tbody>
	</table>
	<hr/>
	<div align = "right">
	<a class="btn btn-secondary pull-right" href="#">글쓰기</a>
	</div>
<c:if test="${count>0}">
	<ul class = "pagination">
	<c:if test="${startPage > pageBlock}">	
		<li>[<a href="review_list.board?pageNum=${startPage-pageBlock}">이전</a>]</li>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<li>[<a href="review_list.board?pageNum=${i}">${i}</a>]</li>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<li>[<a href="review_list.board?pageNum=${endPage+pageBlock}">다음</a>]</li>
	</c:if>
	</ul>
</c:if>
</div>
<jsp:include page="../footer.jsp" />