<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp" />
<div class="container" style="margin-top:30px; margin-bottom:10px">
<script type="text/javascript">
	function check(){
		if (f.searchString.value==""){
			alert("�˻�� �ʼ��� �Է��ؾ� �մϴ�!!")
			f.searchString.focus()
			return false
		}
		return true
	}
	function loginPlz(){
		alert("�Խù��� Ȯ���Ϸ��� �α����ؾ��մϴ�!!")
	}
	function certificationPlz(){
		alert("�ı⸦ �ۼ��Ϸ��� �п������� �ؾ��մϴ�!!")
	}
</script>
	<h5><font size="3">����'sTop�Խ��� > </font><b><a href="info_list.board" class="blackA">�������� �Խ���</a></b></h5>
<form name="f" action="info_find.board" method="post" onsubmit="return check()">
	<div class="row" style="padding-bottom:5px">
		<div class="col-md-6">
		</div>    
        <div class="col-md-6">
		    <div class="input-group">
                <select class="form-control" name="searchType" style="width:20%;">
	 				<option value="id">�ۼ���</option>
	 				<option value="subject">����</option>
					<option value="content">����</option>
					<option value="category">ī�װ���</option>
				</select>
                <input type="text" class="form-control" name="searchString" placeholder="�˻�� �Է��ϼ���." style="width:65%;">
                <span class="input-group-btn">
                    <button class="btn btn-secondary" type="submit">�˻�</button>
                </span>
            </div>
        </div>
	</div>
 </form>
	<table class="table table-hover text-center">
	<thead>
		<tr>
			<th width="8%"></th>
			<th width="58%">�� ��</th>
			<th width="12%">�ۼ���</th>
			<th width="12%">�ۼ���</th>
			<th width="10%">��ȸ</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${!empty noticeList}">
	<c:forEach var="dto" items="${noticeList}">
	<tr>
			<td align="center">[����]</td>
			<td align="left">			
				<a href="notice_detail.board?article_num=${dto.article_num}" class="grayA">
				<font color="#007bff"></font> ${dto.subject}
				<c:if test="${dto.image != '���Ͼ���' }">
				<img class="media-object img-circle" style = "width: 14px; height: 12px;" src = "resources/img/picture.png">
				</c:if>
		<c:if test="${dto.replyCount != 0}">
			<font color="orange" size="2">[${dto.replyCount}]</font>
		</c:if>
				</a>
			</td>
			<td align="center">
				<img class="media-object img-circle" style = "width: 30px; height: 30px;" src = "resources/img/2.png">
			<font style="color:#FF0000;  font-weight:bold;">${dto.id}</font>
			</td>
			<td align="center">${dto.regdate}</td>
			<td align="center">${dto.readCount}</td>
		</tr>
		</c:forEach>
</c:if>
<c:if test="${empty list}">		
		<tr>
			<td colspan="5">��ϵ� �Խñ��� �����ϴ�.</td>
		</tr>
</c:if>	
<c:forEach var="dto" items="${list}">
		<tr>
			<td align="center"><c:out value="${dto.article_num}"/></td>
			<td align="left">			
	<c:if test="${sessionScope.userId != null}">
				<a href="info_detail.board?article_num=${dto.article_num}" class="grayA">
				<font color="#007bff">${dto.category}</font> ${dto.subject}
				<c:if test="${dto.image != '���Ͼ���' }">
				<img class="media-object img-circle" style = "width: 14px; height: 12px;" src = "resources/img/picture.png">
				</c:if>
		<c:if test="${dto.replyCount != 0}">
			<font color="orange" size="2">[${dto.replyCount}]</font>
		</c:if>
				</a>
	</c:if>
	<c:if test="${sessionScope.userId == null}">
		<a href="login.login" onclick="javascript:loginPlz()" class="grayA"><font color="#007bff">${dto.category}</font> ${dto.subject}
		<c:if test="${dto.image != '���Ͼ���' }">
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
			<img class="media-object img-circle" style = "width: 30px; height: 30px;" src = "resources/img/${dto.academyLocation }.png">
			</c:if>
			<c:if test="${dto.grade != 1 }">
			<img class="media-object img-circle" style = "width: 30px; height: 30px;" src = "resources/img/${dto.grade }.png">
			</c:if>
			<c:choose>
					<c:when test="${dto.grade==2}"><font style="color:#FF0000;  font-weight:bold;">${dto.id}</font></c:when>
					<c:otherwise>${dto.id}</c:otherwise>
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
		<li class="page-item"><a class="page-link" href="info_list.board?pageNum=${startPage-pageBlock}">����</a></li>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<c:choose>
			<c:when test="${i == currentPage || currentPage == null}">
			<li class="page-item active"><a class="page-link" href="info_list.board?pageNum=${i}">${i}</a></li>
			</c:when>
			<c:otherwise>
			<li class="page-item"><a class="page-link" href="info_list.board?pageNum=${i}">${i}</a></li>
			</c:otherwise>
			</c:choose>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<li class="page-item"><a class="page-link" href="info_list.board?pageNum=${endPage+pageBlock}">����</a></li>
	</c:if>
	</ul>
	</div>
	<div class="col-md-2 text-center">
	<c:choose>
	<c:when test="${sessionScope.userId == null}">
	</c:when>
	<c:when test="${sessionScope.userGrade != -1}">
	<a class="btn btn-secondary pull-right" href="info_write.board?id=${sessionScope.userId}">�۾���</a>
	</c:when>
	<c:otherwise><a href="#" class="btn btn-secondary pull-right" onclick="javascript:certificationPlz()">�۾���</a>
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
	<c:when test="${sessionScope.userGrade != -1}">
	<a class="btn btn-secondary pull-right" href="info_write.board?id=${sessionScope.userId}">�۾���</a>
	</c:when>
	<c:otherwise><a href="#" class="btn btn-secondary pull-right" onclick="javascript:certificationPlz()">�۾���</a>
	</c:otherwise>
	</c:choose>
	</div>
</c:if>
	</div>
</div>
<jsp:include page="../footer.jsp" />