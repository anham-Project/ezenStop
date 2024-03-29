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
	function loginPlz(){
		alert("게시물을 확인하려면 로그인해야합니다!!")
	}
	function certificationPlz(){
		alert("후기를 작성하려면 학원인증을 해야합니다!!")
	}
	function block(id,blockId){
		var popupWidth = 704;
		var popupHeight = 450;
		var popupX = (window.screen.width / 2) - (popupWidth / 2);
		var popupY= (window.screen.height / 2) - (popupHeight / 2);
		window.open('addBlock.login?id='+id+'&blockId='+blockId, "이메일 인증", 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY)
	}
</script>
	<h5><font size="3">이젠'sTop게시판 > </font><a href="review_list.board" class="blackA"><b>지역별 수강후기 게시판</b></a></h5>
<form name="f" action="review_find.board" method="post" onsubmit="return check()">
	<div class="row" style="padding-bottom:5px">
		<div class="col-md-6">
		</div>    
        <div class="col-md-6">
		    <div class="input-group">
                <select class="form-control" name="searchType" style="width:20%;">
	 				<option value="id">작성자</option>
	 				<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="category">수강기간</option>
				</select>
                <input type="text" class="form-control" name="searchString" placeholder="검색어를 입력하세요." style="width:65%;">
                <span class="input-group-btn">
                    <button class="btn btn-secondary" type="submit">검색</button>
                </span>
            </div>
        </div>
	</div>
 </form>
	<table class="table table-condensed table-hover text-center">
	<thead>
		<tr>
			<th width="8%"></th>
			<th width="58%">제 목</th>
			<th width="12%">작성자</th>
			<th width="12%">작성일</th>
			<th width="10%">조회</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${!empty noticeList}">
	<c:forEach var="dto" items="${noticeList}">
	<tr>
			<td align="center">[공지]</td>
			<td align="left">			
				<a href="notice_detail.board?article_num=${dto.article_num}" class="grayA">
				<font color="#007bff"></font> ${dto.subject}
				<c:if test="${dto.image != '파일없음' }">
				<img class="media-object img-circle" style = "width: 14px; height: 12px;" src = "resources/img/picture.png">
				</c:if>
		<c:if test="${dto.replyCount != 0}">
			<font color="orange" size="2">[${dto.replyCount}]</font>
		</c:if>
				</a>
			</td>
			<td align="center">
				<img class="media-object img-circle" style = "width: 30px; height: 30px; float:left;" src = "resources/img/2.png">
				<a class="btn btn-default dropdown" data-toggle="dropdown"  style="padding:0; margin:0;"> 
					<font style="color:#FF0000;  font-weight:bold;">${dto.id}</font>
				</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="">작성글검색</a>
					</div>
			</td>
			<td align="center">${dto.regdate}</td>
			<td align="center">${dto.readCount}</td>
		</tr>
		</c:forEach>
</c:if>
<c:if test="${empty list}">		
		<tr>
			<td colspan="5">등록된 게시글이 없습니다.</td>
		</tr>
</c:if>	
<c:forEach var="dto" items="${list}">
		<tr>
			<td align="center"><c:out value="${dto.article_num}"/></td>
			<td align="left">			
	<c:if test="${sessionScope.userId != null}">
				<a href="review_detail.board?article_num=${dto.article_num}" class="grayA">
				<font color="#007bff">${dto.category}</font> ${dto.subject}
				<c:if test="${dto.image != '파일없음' }">
				<img class="media-object img-circle" style = "width: 14px; height: 12px;" src = "resources/img/picture.png">
				</c:if>
		<c:if test="${dto.replyCount != 0}">
			<font color="orange" size="2">[${dto.replyCount}]</font>
		</c:if>
				</a>
	</c:if>
	<c:if test="${sessionScope.userId == null}">
		<a href="login.login" onclick="javascript:loginPlz()" class="grayA"><font color="#007bff">${dto.category}</font> ${dto.subject}
		<c:if test="${dto.image != '파일없음' }">
				<img class="media-object img-circle" style = "width: 14px; height: 12px;" src = "resources/img/picture.png">
		</c:if>
		<c:if test="${dto.replyCount != 0}">
			<font color="orange" size="2">[${dto.replyCount}]</font>
		</c:if>
		</a>
	</c:if>
			</td>
			<td align="center">
			<c:if test="${dto.grade == 1 }">
			<img class="media-object img-circle" style = "width: 30px; height: 30px; float:left;" src = "resources/img/${dto.academyLocation}.png">
			</c:if>
			<c:if test="${dto.grade != 1 }">
			<img class="media-object img-circle" style = "width: 30px; height: 30px; float:left;" src = "resources/img/${dto.grade }.png">
			</c:if>
			<c:choose>
					<c:when test="${dto.grade==2}">
						<a class="btn btn-default dropdown" data-toggle="dropdown"  style="padding:0; margin:0;"> 
							<font style="color:#FF0000;  font-weight:bold;">${dto.id}</font>
						 </a>
						<div class="dropdown-menu">
							 <a class="dropdown-item" href="">작성글검색</a>
						</div>
					</c:when>
					<c:otherwise>
						<a class="btn btn-default dropdown" data-toggle="dropdown" style="padding:0; margin:0;"> ${dto.id} </a>
						<div class="dropdown-menu">
							 <a class="dropdown-item" href="">정보보기</a>
							 <a class="dropdown-item" href="">친구등록</a>
							 <a class="dropdown-item" href="javascript:block('${sessionScope.userId}','${dto.id}')">차단하기</a>
							 <a class="dropdown-item" href="">작성글검색</a>
						</div></c:otherwise>
				</c:choose></td>
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
		<li class="page-item"><a class="page-link" href="review_list.board?pageNum=${startPage-pageBlock}">이전</a></li>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<c:choose>
			<c:when test="${i == currentPage}">
			<li class="page-item active"><a class="page-link" href="review_list.board?pageNum=${i}">${i}</a></li>
			</c:when>
			<c:when test="${currentPage == null}">
				<c:if test="${i == 1}">
				<li class="page-item active"><a class="page-link" href="review_list.board?pageNum=${i}">${i}</a></li>
				</c:if>
				<c:if test="${i != 1}">
				<li class="page-item"><a class="page-link" href="review_list.board?pageNum=${i}">${i}</a></li>
				</c:if>
			</c:when>
			<c:otherwise>
			<li class="page-item"><a class="page-link" href="review_list.board?pageNum=${i}">${i}</a></li>
			</c:otherwise>
			</c:choose>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<li class="page-item"><a class="page-link" href="review_list.board?pageNum=${startPage+pageBlock}">다음</a></li>
	</c:if>
	</ul>
	</div>
	<div class="col-md-2 text-center">
	<c:choose>
	<c:when test="${sessionScope.userId == null}">
	</c:when>
	<c:when test="${sessionScope.userGrade == 1 || sessionScope.userGrade == 2}">
	<a class="btn btn-secondary pull-right" href="review_write.board?id=${sessionScope.userId}">글쓰기</a>
	</c:when>
	<c:otherwise><a href="#" class="btn btn-secondary pull-right" onclick="javascript:certificationPlz()">글쓰기</a>
	</c:otherwise>
	</c:choose>
	</div>
</c:if>
<c:if test="${count == 0}">
	<div class="col-md-10 text-center">
	</div>
	<div class="col-md-2 text-center">
	<c:choose>
	<c:when test="${sessionScope.userId == null}">
	</c:when>
	<c:when test="${sessionScope.userGrade == 1 || sessionScope.userGrade == 2}">
	<a class="btn btn-secondary pull-right" href="review_write.board?id=${sessionScope.userId}">글쓰기</a>
	</c:when>
	<c:otherwise><a href="#" class="btn btn-secondary pull-right" onclick="javascript:certificationPlz()">글쓰기</a>
	</c:otherwise>
	</c:choose>
	</div>
</c:if>
	</div>
</div>
<jsp:include page="../footer.jsp" />