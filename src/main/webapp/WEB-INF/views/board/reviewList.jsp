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
	<h5><font size="3">����'sTop�Խ��� > </font><b>������ ���� �ı�Խ���</b></h5>
<form name="f" action="review_find.board" method="post" onsubmit="return check()">
	<div class="row" style="padding-bottom:5px">
		<div class="col-md-6">
		</div>    
        <div class="col-md-6">
		    <div class="input-group">
                <select class="form-control" name="searchType" style="width:20%;">
	 				<option value="id">�ۼ���</option>
	 				<option value="subject">����</option>
					<option value="content">����</option>
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
<c:if test="${empty reviewList}">		
		<tr>
			<td colspan="5">��ϵ� �Խñ��� �����ϴ�.</td>
		</tr>
</c:if>		
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
	</tbody>
	</table>
	<div class="row">
<c:if test="${count>0}">
	<div class="col-md-4">
	</div>
	<div class="col-md-6">
	<ul class = "pagination">
	<c:if test="${startPage > pageBlock}">	
		<li class="page-item"><a class="page-link" href="review_list.board?pageNum=${startPage-pageBlock}">����</a></li>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<li class="page-item"><a class="page-link" href="review_list.board?pageNum=${i}">${i}</a></li>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<li class="page-item"><a class="page-link" href="review_list.board?pageNum=${endPage+pageBlock}">����</a></li>
	</c:if>
	</ul>
	</div>
	<div class="col-md-2 text-center">
	<a class="btn btn-secondary pull-right" href="review_write.board">�۾���</a>
	</div>
</c:if>
<c:if test="${count == 0}">
	<div class="col-md-10 text-center">
	</div>
	<div class="col-md-2 text-center">
	<a class="btn btn-secondary pull-right" href="review_write.board">�۾���</a>
	</div>
</c:if>
	</div>
</div>
<jsp:include page="../footer.jsp" />