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
			alert("���� �Է����ּ���")
			return false
		}
		return true
	}
	function view_file(id){
		window.open('view_file.login?id='+id, "�������� ����", "width=600, height=600")
	}

</script>
<div class="container" style="margin-top:30px; margin-bottom:10px">
	<h5><font size="3">������ ������ > </font><b>�������</b></h5>
	<table class="table table-hover mytable text-center">
	<thead>
		<tr>
			<th width="10%">�̸�</th>
			<th width="20%">�̸���</th>
			<th>���̵�</th>
			<th>�н�����</th>
			<th>�п�����</th>
			<th>����</th>
			<th>���</th>
			<th>���� ����</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${empty memberList}">		
		<tr>
			<td colspan="7">��ϵ� ȸ���� �����ϴ�.</td>
		</tr>
</c:if>
<form name="f" action="edit_ok.login" method="post">
<div class="row">
	<div class="col-md-12" align="center" style="padding-bottom:10px">
	<button class="btn btn-secondary" type="button" onclick="location.href='member_management.login'">��ü ����</button>
	<button class="btn btn-secondary" type="button" onclick="location.href='view_waitting.login'">������� ����</button>
	<button class="btn btn-info" type="submit">��� ������� ����</button>
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
			<option value="0" <c:if test="${dto.status==0}">selected</c:if>>�̽�û</option>
			<option value="1" <c:if test="${dto.status==1}">selected</c:if>>�������</option>
			<option value="2" <c:if test="${dto.status==2}">selected</c:if>>�����Ϸ�</option>
			</select>
			</td>
			<td align="center">
			<select name="dtoList[${status.index}].grade">
			<option value="-1" <c:if test="${dto.grade==-1}">selected</c:if>>���� ȸ��</option>
			<option value="0" <c:if test="${dto.grade==0}">selected</c:if>>�Ϲ� ȸ��</option>
			<option value="1" <c:if test="${dto.grade==1}">selected</c:if>>���� ȸ��</option>
			<option value="2" <c:if test="${dto.grade==2}">selected</c:if>>������</option>
			</select>
			</td>
			<td align="center">
			<c:if test="${dto.status!=0}"><a href="javascript:view_file('${dto.id}')">���Ϻ���</a>	</c:if>
			<c:if test="${dto.status==0}"><h6>���Ͼ���</h6></c:if>
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
	<div class="row" style="padding-bottom:5px"> <!-- �˻��� -->
		<div class="col-md-6">
		<div class="input-group">
		</div>
		</div>    
        <div class="col-md-6">
		    <div class="input-group">
                <select class="form-control" name="searchType" style="width:20%;">
	 				<option value="id">���̵�</option>
	 				<option value="name">�̸�</option>
					<option value="email">�̸���</option>
				</select>
                <input type="text" class="form-control" name="searchString" placeholder="�˻�� �Է��ϼ���." style="width:65%;">
                <span class="input-group-btn">
                    <button class="btn btn-secondary" type="submit">�˻�</button>
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
</c:if>
</div>
</div>
<%@ include file="../footer.jsp"%>