<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- mbmt.jsp (MemBer_ManagemenT) -->
<%@ include file="../header.jsp"%>
<div class="container" style="margin-top:30px; margin-bottom:10px">
	
	<h5><font size="3">관리자 페이지 > </font><b>멤버관리</b></h5>
	
	<div class="row" style="padding-bottom:5px"> <!-- 검색대 -->
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
			<th width="8%">이름</th>
			<th width="50%">이메일</th>
			<th>아이디</th>
			<th>패스워드</th>
			<th>학원지점</th>
			<th>상태</th>
			<th>등급</th>
			<th>파일</th>
			<th>수정|블락</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${empty memberList}">		
		<tr>
			<td colspan="8">등록된 회원이 없습니다.</td>
		</tr>
</c:if>		
<c:forEach var="dto" items="${memberList}">
		<tr>
			<td align="center"><c:out value="${startNum}"/></td>
			<c:set var="startNum" value="${startNum-1}"/>
			<td align="left">${dto.name}</td>
			<td align="center">${dto.email}</td>
			<td align="center">${dto.id}</td>
			<td align="center">${dto.passwd}</td>
			<td align="center">${dto.academyLocation}</td>
			<td align="center">${dto.status}</td>
			<td align="center">
			<select name="status">
			<option value="0" <c:if test="${dto.status==0}">selected</c:if>>미신청</option>
			<option value="1" <c:if test="${dto.status==1}">selected</c:if>>인증대기</option>
			<option value="2" <c:if test="${dto.status==2}">selected</c:if>>인증완료</option>
			</select>
			</td>
			<td align="center">
			<select name="status">
			<option value="-1" <c:if test="${dto.status==-1}">selected</c:if>>일반 회원</option>
			<option value="0" <c:if test="${dto.status==0}">selected</c:if>>일반 회원</option>
			<option value="1" <c:if test="${dto.status==1}">selected</c:if>>인증 회원</option>
			<option value="2" <c:if test="${dto.status==2}">selected</c:if>>관리자</option>
			</select>
			</td>
			<td align="center">${dto.file}</td>
			<td align="center">
			<a href ="#">수정</a>|
			<a href ="#">블락</a> 
			</td>
		</tr>
</c:forEach>
	</tbody>
	</table>
	<hr/>
	<div align = "right">
	<a class="btn btn-secondary pull-right" href="review_write.board">글쓰기</a>
	</div>
<c:if test="${count>0}">
<div align="center">
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
</div>
</c:if>
</div>
<%@ include file="../footer.jsp"%>