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
			<td align="center">${dto.id}</td>
			<td align="center">${dto.regdate}</td>
			<td align="center">${dto.readCount}</td>
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
<div class="row">
	<div class="col-md-1">�̸�</div>
	<div class="col-md-2">�̸���</div>
	<div class="col-md-1">�н�����</div>
	<div class="col-md-1">�п�����</div>
	<div class="col-md-1">������</div>
	<div class="col-md-1">ȸ�����</div>
	<div class="col-md-1">ȸ������</div>
	<div class="col-md-1">����|����</div>
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
	�̸� �̸��� �н����� �п����� ������ ȸ����� ȸ������ �����Ϸ� ���
	private String email;		//�̸���
	private String id;			//���̵�
	private String passwd;		//�н�����
	private String name;		//�̸�
	private String reg_date;	//������
	private String academyLocation;	//�п�����
	private int grade;			//ȸ����� 0 = ������ȸ��, 1 = ���� �� ȸ��, 2 = ������ ���, -1= ����� ȸ��
	private int status;			//0 = ������û ���� ȸ��, 1 = ���� ��û�ϰ� ����� ȸ��, 2 = �����Ϸ� ȸ��
<%@ include file="../footer.jsp"%>