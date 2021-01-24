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
	<h5><font size="3">����'sTop�Խ��� > </font><b>�Ű� �Խ���</b></h5>
<form name="f" action="report_find.board" method="post" onsubmit="return check()">
	<div class="row" style="padding-bottom:5px">
		<div class="col-md-6">
		</div>    
        <div class="col-md-6">
		    <div class="input-group">
                <select class="form-control" name="searchType" style="width:20%;">
	 				<option value="userId">�Ű���</option>
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
			<th width="12%"><small>�Ű�� �� ��ȣ</small></th>
			<th width="18%">�Խñ��� ����</th>
			<th width="46%">�Ű���</th>
			<th width="12%">�Ű���</th>
			<th width="12%">�Ű���</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${empty list}">		
		<tr>
			<td colspan="4">�Ű�� �Խñ��� �����ϴ�.</td>
		</tr>
</c:if>		
<c:forEach var="dto" items="${list}">
		<tr>
			<td align="center"><c:out value="${dto.article_num}"/></td>
			<td align="center">
				<c:if test="${dto.visible == 1 }">
					Ȱ��ȭ
				</c:if>
				<c:if test="${dto.visible == -1}">
					��Ȱ��ȭ
				</c:if>
			</td>
			<td align="left">			
				<form name="f" onclick="javascript:findDetailPage('${dto.article_num}')">
				<a href="#" class="grayA">${dto.reportContent}</a>
				</form>
			</td>
			<td align="center">
			<c:if test="${dto.grade == 1 }">
			<img class="media-object img-circle" style = "width: 30px; height: 30px;" src = "resources/img/${dto.academyLocation }.png">
			</c:if>
			<c:if test="${dto.grade != 1 }">
			<img class="media-object img-circle" style = "width: 30px; height: 30px;" src = "resources/img/${dto.grade }.png">
			</c:if>
			${dto.userId}</td>
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