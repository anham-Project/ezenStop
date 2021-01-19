<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="header.jsp" />
<!-- Page Content -->
<script type="text/javascript">
function loginPlz(){
	alert("�Խù��� Ȯ���Ϸ��� �α����ؾ��մϴ�!!")
}
function findDetailPage(article_num) {
	$
			.ajax({
				type : "POST",
				url : "getDetail.board",
				contentType : 'application/x-www-form-urlencoded; charset=euc-kr',
				data : {
					article_num : article_num
				},
				success : function(result) {
					location.href = result + '?article_num='
							+ article_num;
				}
			})

}
</script>
<div class="container">

	<!-- Jumbotron Header -->
	<!-- header class="jumbotron my-4">
		<div align="center">
			<!--table>
				<tr align="center">
					<td width="20%">����</td>
					<td width="20%">����</td>
					<td width="20%">���</td>
					<td width="20%">���</td>
					<td width="20%">���</td>
				</tr>
				<tr align="center">
					<td>����</td>
					<td colspan="3" rowspan="3"><img class="center" src="<c:url value='resources/img/ezen_jumbotron.jpg'/>"></td>
					<td>�Ⱦ�</td>
				</tr>
				<tr align="center">
					<td>������</td>
					<td>����</td>
				</tr>
				<tr align="center">
					<td>�ϻ�</td>
					<td>�Ȼ�</td>
				</tr>
				<tr align="center">
					<td>���� �д�</td>
					<td>���� ���</td>
					<td>����</td>
					<td>����</td>
					<td>���� IT</td>
				</tr>
			</table>
		</div>
	</header-->

	<!-- Page Features -->
	<div class="row text-left">
		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100">
				<div class="card-header">
					<a href="#" class="text-primary">�ֽ� �α��
						</h5>
					</a>
				</div>
				<div class="card-body">
					<p class="card-text">
						<c:set var="tmp" value="0"/>
						<c:if test="${empty hotList }">
							�ֱ� �����ϰ� �Խù��� �����ϴ�. �Ф�
						</c:if>
						<c:forEach var="dto" items="${hotList }">
						<form name="f1" onclick="javascript:findDetailPage('${dto.article_num}')">
							<c:set var="tmp" value="${tmp+1 }"/>
							<c:if test="${sessionScope.userId != null}">
								<a href="review_detail.board?article_num=${dto.article_num}">
									${dto.category} ${dto.subject} <c:if
										test="${dto.image != '���Ͼ���' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if> <c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if>
								</a>
							</c:if>
							<c:if test="${sessionScope.userId == null}">
								<a href="#" onclick="javascript:loginPlz()">${dto.category}
									${dto.subject} <c:if test="${dto.image != '���Ͼ���' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if> <c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if>
								</a>
							</c:if>
							</form>
							<c:if test="${tmp%3 == 0 }"><hr></c:if>
						</c:forEach>
					</p>
				</div>

			</div>
		</div>
		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100">
				<div class="card-header">
					<a href="#" class="text-primary"><h5>��������</h5></a>
				</div>
				<div class="card-body">
					<p class="card-text">Lorem ipsum dolor sit amet, consectetur
						adipisicing elit. Sapiente esse necessitatibus neque.</p>
				</div>

			</div>
		</div>
		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100">
				<div class="card-header">
					<a href="#" class="text-primary"><h5>���� �Խ���</h5></a>
				</div>
				<div class="card-body">
					<p class="card-text">Lorem ipsum dolor sit amet, consectetur
						adipisicing elit. Sapiente esse necessitatibus neque.</p>
				</div>

			</div>
		</div>

		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100">
				<div class="card-header">
					<a href="#" class="text-primary"><h5>������ ���� �ı� �Խ���</h5></a>
				</div>
				<div class="card-body">
					<p class="card-text">
						<c:if test="${empty reviewList }">
							�ֱ� �����ϰ� �Խù��� �����ϴ�. �Ф�
						</c:if>
						<c:forEach var="dto" items="${reviewList }">
						<form name="f1" onclick="javascript:findDetailPage('${dto.article_num}')">
							<c:set var="tmp" value="${tmp+1 }"/>
							<c:if test="${sessionScope.userId != null}">
								<a href="review_detail.board?article_num=${dto.article_num}">
									${dto.category} ${dto.subject} <c:if
										test="${dto.image != '���Ͼ���' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if> <c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if>
								</a>
							</c:if>
							<c:if test="${sessionScope.userId == null}">
								<a href="#" onclick="javascript:loginPlz()">${dto.category}
									${dto.subject} <c:if test="${dto.image != '���Ͼ���' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if> <c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if>
								</a>
							</c:if>
							</form>
						</c:forEach>
					</p>
				</div>
			</div>
		</div>
		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100">
				<div class="card-header">
					<a href="#" class="text-primary"><h5>�ŷ� �Խ���</h5></a>
				</div>
				<div class="card-body">
					<p class="card-text">Lorem ipsum dolor sit amet, consectetur
						adipisicing elit. Sapiente esse necessitatibus neque.</p>
				</div>

			</div>
		</div>

		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100">
				<div class="card-header">
					<a href="#" class="text-primary"><h5>���� ���� �Խ���</h5></a>
				</div>
				<div class="card-body">
					<p class="card-text">Lorem ipsum dolor sit amet, consectetur
						adipisicing elit. Explicabo magni sapiente, tempore debitis beatae
						culpa natus architecto.</p>
				</div>
			</div>
		</div>
	</div>
	<!-- /.row -->

</div>
<!-- /.container -->
<jsp:include page="footer.jsp" />