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
</script>
	<h5><font size="3">����'sTop�Խ��� > </font><b>�Ű� �Խ���</b></h5>
<form name="f" action="review_find.board" method="post" onsubmit="return check()">
	<div class="row" style="padding-bottom:5px">
		<div class="col-md-6">
		</div>    
        <div class="col-md-6">
		    <div class="input-group">
                <select class="form-control" name="searchType" style="width:20%;">
	 				<option value="id">�Ű���</option>
	 				<option value="article_num">�Ű�� �۹�ȣ</option>
					<option value="reportContent">�Ű���</option>
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
			<th width="8%">�Ű��<br>�� ��ȣ</th>
			<th width="58%">�Ű���</th>
			<th width="12%">�Ű���</th>
			<th width="12%">�Ű���</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${empty reportList}">		
		<tr>
			<td colspan="4">�Ű�� �Խñ��� �����ϴ�.</td>
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
		<li class="page-item"><a class="page-link" href="reportBoard.board?pageNum=${startPage-pageBlock}">����</a></li>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<li class="page-item"><a class="page-link" href="reportBoard.board?pageNum=${i}">${i}</a></li>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<li class="page-item"><a class="page-link" href="reportBoard.board?pageNum=${endPage+pageBlock}">����</a></li>
	</c:if>
	</ul>
	</div>
</c:if>
	</div>
</div>
<jsp:include page="../footer.jsp" />