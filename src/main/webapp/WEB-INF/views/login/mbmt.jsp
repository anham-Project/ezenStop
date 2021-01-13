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
			<td align="center">${dto.id}</td>
			<td align="center">${dto.regdate}</td>
			<td align="center">${dto.readCount}</td>
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
<div class="row">
	<div class="col-md-1">이름</div>
	<div class="col-md-2">이메일</div>
	<div class="col-md-1">패스워드</div>
	<div class="col-md-1">학원지점</div>
	<div class="col-md-1">가입일</div>
	<div class="col-md-1">회원등급</div>
	<div class="col-md-1">회원상태</div>
	<div class="col-md-1">수정|정지</div>
</div>
<c:forEach var="dto" items="${reviewList}">
		<tr>
			<td align="center"><c:out value="${startNum}"/></td>
			<c:set var="startNum" value="${startNum-1}"/>
			<td align="left">			
				<a href="review_detail.board?article_num=${dto.article_num}">
				${dto.category} ${dto.subject}
	<c:if test="${dto.replyCount != 0}">
		<font color="orange" size="2">[${dto.replyCount}]</font>
	</c:if>
				</a>	
			</td>
			<td align="center">${dto.id}</td>
			<td align="center">${dto.regdate}</td>
			<td align="center">${dto.readCount}</td>
		</tr>
</c:forEach>
	이름 이메일 패스워드 학원지점 가입일 회원등급 회원상태 수정완료 블락
	private String email;		//이메일
	private String id;			//아이디
	private String passwd;		//패스워드
	private String name;		//이름
	private String reg_date;	//가입일
	private String academyLocation;	//학원지점
	private int grade;			//회원등급 0 = 인증전회원, 1 = 인증 후 회원, 2 = 관리자 등급, -1= 블락된 회원
	private int status;			//0 = 인증신청 안한 회원, 1 = 인증 신청하고 대기중 회원, 2 = 인증완료 회원
<%@ include file="../footer.jsp"%>