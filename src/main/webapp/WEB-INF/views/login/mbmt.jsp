<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- mbmt.jsp (MemBer_ManagemenT) -->
<%@ include file="../header.jsp"%>
<script>
	function check(){
		if(f.searchString.value==""){
			alert("���� �Է����ּ���")
			return false
		}
		return true
	}

</script>
<div class="container" style="margin-top:30px; margin-bottom:10px">
	<h5><font size="3">������ ������ > </font><b>�������</b></h5>
	<form action="search_member.login" name ="f" method="post" onsubmit="return check()">
	<div class="row" style="padding-bottom:5px"> <!-- �˻��� -->
		<div class="col-md-6">
		<div class="input-group">
			<span class="input-group-btn">
				<button class="btn btn-secondary" type="button" onclick="location.href='member_management.login'">��ü ����</button>
				<button class="btn btn-secondary" type="button" onclick="location.href='view_waitting.login'">������� ����</button>
			</span>
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
	<table class="table table-hover text-center">
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
			<th>����</th>
		</tr>
	</thead>
	<tbody>
<c:if test="${empty memberList}">		
		<tr>
			<td colspan="8">��ϵ� ȸ���� �����ϴ�.</td>
		</tr>
</c:if>		
<c:forEach var="dto" items="${memberList}">
		<tr>
			<c:set var="startNum" value="${startNum-1}"/>
			<td align="left">${dto.name}</td>
			<td align="center">${dto.email}</td>
			<td align="center">${dto.id}</td>
			<td align="center">${dto.passwd}</td>
			<td align="center">
			<select name="status">
			<c:forEach var="list" items="${locationList}">
			<option <c:if test="${dto.academyLocation==list}">selected</c:if>>${list}</option>
			</c:forEach>
			</select>
			</td>
			<td align="center">
			<select name="status">
			<option value="0" <c:if test="${dto.status==0}">selected</c:if>>�̽�û</option>
			<option value="1" <c:if test="${dto.status==1}">selected</c:if>>�������</option>
			<option value="2" <c:if test="${dto.status==2}">selected</c:if>>�����Ϸ�</option>
			</select>
			</td>
			<td align="center">
			<select name="grade">
			<option value="-1" <c:if test="${dto.status==-1}">selected</c:if>>���� ȸ��</option>
			<option value="0" <c:if test="${dto.status==0}">selected</c:if>>�Ϲ� ȸ��</option>
			<option value="1" <c:if test="${dto.status==1}">selected</c:if>>���� ȸ��</option>
			<option value="2" <c:if test="${dto.status==2}">selected</c:if>>������</option>
			</select>
			</td>
			<td align="center"><a href="#">���Ϻ���</a></td>
			<td align="center">
			<button class="btn btn-secondary" type="submit">�˻�</button> <!-- ���� �����ؾ��� -->
			</td>
		</tr>
</c:forEach>
	</tbody>
	</table>
	<hr/>
<c:if test="${count>0}">
<div align="center">
	<ul class = "pagination">
	<c:if test="${startPage > pageBlock}">	
		<li>[<a href="review_list.board?pageNum=${startPage-pageBlock}">����</a>]</li>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<li>[<a href="review_list.board?pageNum=${i}">${i}</a>]</li>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<li>[<a href="review_list.board?pageNum=${endPage+pageBlock}">����</a>]</li>
	</c:if>
	</ul>
</div>
</c:if>
</div>
<%@ include file="../footer.jsp"%>