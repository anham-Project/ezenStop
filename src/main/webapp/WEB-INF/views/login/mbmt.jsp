<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- mbmt.jsp (MemBer_ManagemenT) -->
<%@ include file="../header.jsp"%>
<div class="container" style="margin-top:30px; margin-bottom:10px">
	
	<h5><font size="3">������ ������ > </font><b>�������</b></h5>
	
	<div class="row" style="padding-bottom:5px"> <!-- �˻��� -->
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
                    <button class="btn btn-secondary" type="button">�˻�</button>
                </span>
            </div>
        </div>
	</div>
	
	<table class="table table-hover text-center">
	<thead>
		<tr>
			<th width="8%">�̸�</th>
			<th width="50%">�̸���</th>
			<th>���̵�</th>
			<th>�н�����</th>
			<th>�п�����</th>
			<th>����</th>
			<th>���</th>
			<th>����</th>
			<th>����|���</th>
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
			<option value="0" <c:if test="${dto.status==0}">selected</c:if>>�̽�û</option>
			<option value="1" <c:if test="${dto.status==1}">selected</c:if>>�������</option>
			<option value="2" <c:if test="${dto.status==2}">selected</c:if>>�����Ϸ�</option>
			</select>
			</td>
			<td align="center">
			<select name="status">
			<option value="-1" <c:if test="${dto.status==-1}">selected</c:if>>�Ϲ� ȸ��</option>
			<option value="0" <c:if test="${dto.status==0}">selected</c:if>>�Ϲ� ȸ��</option>
			<option value="1" <c:if test="${dto.status==1}">selected</c:if>>���� ȸ��</option>
			<option value="2" <c:if test="${dto.status==2}">selected</c:if>>������</option>
			</select>
			</td>
			<td align="center">${dto.file}</td>
			<td align="center">
			<a href ="#">����</a>|
			<a href ="#">���</a> 
			</td>
		</tr>
</c:forEach>
	</tbody>
	</table>
	<hr/>
	<div align = "right">
	<a class="btn btn-secondary pull-right" href="review_write.board">�۾���</a>
	</div>
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