<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../header.jsp" />
	<script type = "text/javascript">
	$(document).ready(function(){
		chatBoxFunction();
		getInfiniteBox();
	});
	</script>
<div class="container" style="min-height: 600px">
	<table class="table" style = "margin: 0 auto;">
		<thead>
			<tr>
				<th><h4>주고받은 메세지 목록</h4></th>
			</tr>
		</thead>
		<div style="overflow-y: auto; width: 100%; max-height: 450px;">
			<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd; margin: 0 auto;">
				<tbody id="boxTable">
				</tbody>
			</table>
		</div>
	</table>
</div>

<jsp:include page="../footer.jsp" />