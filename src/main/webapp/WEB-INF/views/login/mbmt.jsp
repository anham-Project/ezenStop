<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- mbmt.jsp (MemBer_ManagemenT) -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../header.jsp"%>
<style>
.table .mytable {
  width: 100%;
  margin-bottom: 1rem;
  color: #212529;
}
</style>
<script>
	function check(){
		if(f.searchString.value==""){
			alert("값을 입력해주세요")
			return false
		}
		return true
	}
	function view_file(id){
		window.open('view_file.login?id='+id, "인증파일 보기", "width=600, height=600")
	}

</script>
<div class="container" style="margin-top:30px; margin-bottom:10px">
	<h5><font size="3">관리자 페이지 > </font><b>멤버관리</b></h5>
	<table class="table table-hover mytable text-center">
	<thead>
		<tr>
			<th width="10%">이름</th>
			<th width="20%">이메일</th>
			<th>아이디</th>
			<th>패스워드</th>
			<th>학원지점</th>
			<th>상태</th>
			<th>등급</th>
			<th>인증 파일</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${empty memberList}">		
		<tr>
			<td colspan="7">등록된 회원이 없습니다.</td>
		</tr>
</c:if>
<form name="f" action="edit_ok.login" method="post">
<div class="row">
	<div class="col-md-12" align="center" style="padding-bottom:10px">
	<button class="btn btn-secondary" type="button" onclick="location.href='member_management.login'">전체 보기</button>
	<button class="btn btn-secondary" type="button" onclick="location.href='view_waitting.login'">인증대기 보기</button>
	<button class="btn btn-info" type="submit">모든 변경사항 저장</button>
	</div>
</div>
<c:forEach var="dto" items="${memberList}" begin="0" end="${fn:length(memberList)}" varStatus="status">
		<tr>
			<td align="left" >${dto.name}</td>
			<td align="center">${dto.email}</td>
			<td align="center">${dto.id}</td>
			<td align="center">${dto.passwd}</td>
			<td align="center">
			<select name="dtoList[${status.index}].academyLocation">
				<c:forEach var="list" items="${locationList}">
				<option <c:if test="${dto.academyLocation==list}">selected</c:if>>${list}</option>
				</c:forEach>
			</select>
			</td>
			<td align="center">
			<select name="dtoList[${status.index}].status">
			<option value="0" <c:if test="${dto.status==0}">selected</c:if>>미신청</option>
			<option value="1" <c:if test="${dto.status==1}">selected</c:if>>인증대기</option>
			<option value="2" <c:if test="${dto.status==2}">selected</c:if>>인증완료</option>
			</select>
			</td>
			<td align="center">
			<select name="dtoList[${status.index}].grade">
			<option value="-1" <c:if test="${dto.grade==-1}">selected</c:if>>정지 회원</option>
			<option value="0" <c:if test="${dto.grade==0}">selected</c:if>>일반 회원</option>
			<option value="1" <c:if test="${dto.grade==1}">selected</c:if>>인증 회원</option>
			<option value="2" <c:if test="${dto.grade==2}">selected</c:if>>관리자</option>
			</select>
			</td>
			<td align="center">
			<c:if test="${dto.status!=0}"><a href="javascript:view_file('${dto.id}')">파일보기</a>	</c:if>
			<c:if test="${dto.status==0}"><h6>파일없음</h6></c:if>
			</td>
		</tr>
			<input type="hidden" name="dtoList[${status.index}].name" value="${dto.name}"/>
			<input type="hidden" name="dtoList[${status.index}].email" value="${dto.email}"/>
			<input type="hidden" name="dtoList[${status.index}].id" value="${dto.id}"/>
			<input type="hidden" name="dtoList[${status.index}].passwd" value="${dto.passwd}"/>
</c:forEach>
</form>
	</tbody>
	</table>
	<hr/>
	<form action="search_member.login" name ="f" method="post" onsubmit="return check()">
	<div class="row" style="padding-bottom:5px"> <!-- 검색대 -->
		<div class="col-md-6">
		<div class="input-group">
		</div>
		</div>    
        <div class="col-md-6">
		    <div class="input-group">
                <select class="form-control" name="searchType" style="width:20%;">
	 				<option value="id">아이디</option>
	 				<option value="name">이름</option>
					<option value="email">이메일</option>
				</select>
                <input type="text" class="form-control" name="searchString" placeholder="검색어를 입력하세요." style="width:65%;">
                <span class="input-group-btn">
                    <button class="btn btn-secondary" type="submit">검색</button>
                </span>
            </div>
        </div>
	</div>
	</form>
<div class="row">
<c:if test="${count>0}">
	<div class="col-md-4">
	</div>
	<div class="col-md-6">
	<ul class = "pagination">
	<c:if test="${startPage > pageBlock}">	
		<li class="page-item"><a class="page-link" href="review_list.board?pageNum=${startPage-pageBlock}">이전</a></li>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<li class="page-item"><a class="page-link" href="review_list.board?pageNum=${i}">${i}</a></li>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<li class="page-item"><a class="page-link" href="review_list.board?pageNum=${endPage+pageBlock}">다음</a></li>
	</c:if>
	</ul>
	</div>
</c:if>
</div>
</div>
<%@ include file="../footer.jsp"%>