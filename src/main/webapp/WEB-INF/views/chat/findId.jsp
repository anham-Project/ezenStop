<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../header.jsp" />
<div class="container">
	<table class="table table-bordered table-hover"
		style="text-align: center; border: 1px solid #dddddd">
		<thead>
			<tr>
				<th colspan="2"><h4>검색으로 친구찾기</h4></th>
			</tr>
		<tbody>
			<tr>
				<td style="width: 110px;"><h5>친구 아이디</h5></td>
				<td><input class="form-control" type="text" id="findId"
					maxlength="20" placeholder="찾을 아이디를 입력하세요."></td>
			</tr>
			<tr>
				<td colspan="2"><button class="btn btn-primary pull-right"
						onclick="findFunction();">검색</button></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="container">
	<table id="friendResult class=" table table-bordered
		table-hover" style="text-align: center; border: 1px solid #dddddd"></table>
</div>

<jsp:include page="../footer.jsp" />