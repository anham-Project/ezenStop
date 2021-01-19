<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="header.jsp" />
<!-- Page Content -->
<script type="text/javascript">
function loginPlz(){
	alert("게시물을 확인하려면 로그인해야합니다!!")
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
					<td width="20%">종로</td>
					<td width="20%">신촌</td>
					<td width="20%">노원</td>
					<td width="20%">상봉</td>
					<td width="20%">당산</td>
				</tr>
				<tr align="center">
					<td>송파</td>
					<td colspan="3" rowspan="3"><img class="center" src="<c:url value='resources/img/ezen_jumbotron.jpg'/>"></td>
					<td>안양</td>
				</tr>
				<tr align="center">
					<td>의정부</td>
					<td>구리</td>
				</tr>
				<tr align="center">
					<td>일산</td>
					<td>안산</td>
				</tr>
				<tr align="center">
					<td>성남 분당</td>
					<td>성남 모란</td>
					<td>김포</td>
					<td>전주</td>
					<td>이젠 IT</td>
				</tr>
			</table>
		</div>
	</header-->

	<!-- Page Features -->
	<div class="row text-left">
		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100">
				<div class="card-header">
					<a href="#" class="text-primary">최신 인기글
						</h5>
					</a>
				</div>
				<div class="card-body">
					<p class="card-text">
						<c:set var="tmp" value="0"/>
						<c:if test="${empty hotList }">
							최근 일주일간 게시물이 없습니다. ㅠㅠ
						</c:if>
						<c:forEach var="dto" items="${hotList }">
						<form name="f1" onclick="javascript:findDetailPage('${dto.article_num}')">
							<c:set var="tmp" value="${tmp+1 }"/>
							<c:if test="${sessionScope.userId != null}">
								<a href="review_detail.board?article_num=${dto.article_num}">
									${dto.category} ${dto.subject} <c:if
										test="${dto.image != '파일없음' }">
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
									${dto.subject} <c:if test="${dto.image != '파일없음' }">
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
					<a href="#" class="text-primary"><h5>공지사항</h5></a>
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
					<a href="#" class="text-primary"><h5>자유 게시판</h5></a>
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
					<a href="#" class="text-primary"><h5>지역별 강의 후기 게시판</h5></a>
				</div>
				<div class="card-body">
					<p class="card-text">
						<c:if test="${empty reviewList }">
							최근 일주일간 게시물이 없습니다. ㅠㅠ
						</c:if>
						<c:forEach var="dto" items="${reviewList }">
						<form name="f1" onclick="javascript:findDetailPage('${dto.article_num}')">
							<c:set var="tmp" value="${tmp+1 }"/>
							<c:if test="${sessionScope.userId != null}">
								<a href="review_detail.board?article_num=${dto.article_num}">
									${dto.category} ${dto.subject} <c:if
										test="${dto.image != '파일없음' }">
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
									${dto.subject} <c:if test="${dto.image != '파일없음' }">
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
					<a href="#" class="text-primary"><h5>거래 게시판</h5></a>
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
					<a href="#" class="text-primary"><h5>정보 공유 게시판</h5></a>
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