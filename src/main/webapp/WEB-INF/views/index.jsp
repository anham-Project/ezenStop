<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="header.jsp" />
<!-- Page Content -->
<script type="text/javascript">
function loginPlz(){
	alert("惟獣弘聖 溌昔馬形檎 稽益昔背醤杯艦陥!!")
	return false
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
					<td width="20%">曽稽</td>
					<td width="20%">重談</td>
					<td width="20%">葛据</td>
					<td width="20%">雌裟</td>
					<td width="20%">雁至</td>
				</tr>
				<tr align="center">
					<td>勺督</td>
					<td colspan="3" rowspan="3"><img class="center" src="<c:url value='resources/img/ezen_jumbotron.jpg'/>"></td>
					<td>照丞</td>
				</tr>
				<tr align="center">
					<td>税舛採</td>
					<td>姥軒</td>
				</tr>
				<tr align="center">
					<td>析至</td>
					<td>照至</td>
				</tr>
				<tr align="center">
					<td>失害 歳雁</td>
					<td>失害 乞空</td>
					<td>沿匂</td>
					<td>穿爽</td>
					<td>戚賎 IT</td>
				</tr>
			</table>
		</div>
	</header-->

	<!-- Page Features -->
	<div class="row text-left">
		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100 shadow">
				<div class="card-header">
					<img class="img-index" src="resources/img/HOT.png">
					<a href="#" class="blackA titleA">
					爽娃 昔奄越</a>
				</div>
				<div class="card-body"  style="padding: 0.5rem 2rem;">
					<p class="card-text">
						<c:set var="tmp" value="0"/>
						<c:if test="${empty hotList }">
							<a href="#" class="grayA gapA">置悦 析爽析娃 惟獣弘戚 蒸柔艦陥. ばば</a>
						</c:if>
						<c:forEach var="dto" items="${hotList }">
						<form name="f1" onclick="javascript:findDetailPage('${dto.article_num}')">
							<c:if test="${sessionScope.userId != null}">
								<a href="#" class="grayA gapA">
									<font color="#007bff">${dto.category}</font> ${dto.subject} 
									<c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if>
									<c:if test="${dto.image != '督析蒸製' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if> 
								</a>
								&nbsp;
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/up.png">
								<font color="blue"size="2">${dto.upCount}</font>
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/down.png">
								<font color="red"size="2">${dto.downCount}</font>
							</c:if>
						</form>
							<c:if test="${sessionScope.userId == null}">
								<a href="#" onclick="javascript:loginPlz()" class="grayA gapA"><font color="#007bff">${dto.category}</font>
									${dto.subject} 
									<c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if>
									<c:if test="${dto.image != '督析蒸製' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if>
								</a>
								&nbsp;
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/up.png">
								<font color="blue"size="2">${dto.upCount}</font>
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/down.png">
								<font color="red"size="2">${dto.downCount}</font>
							</c:if>
						</c:forEach>
					</p>
				</div>

			</div>
		</div>
		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100 shadow">
				<div class="card-header">
					<img class="img-index" src="resources/img/NOTICE.png">
					<a href="notice_list.board" class="blackA titleA">因走紫牌</a>
				</div>
				<div class="card-body" style="padding: 0.5rem 2rem;">
					<p class="card-text">
						<c:if test="${empty indexListMap['EZEN_NOTICE_BOARD']}">
							<a href="#" class="grayA gapA">因走紫牌戚 蒸柔艦陥. ばば</a>
						</c:if>
						<c:forEach var="dto" items="${indexListMap['EZEN_NOTICE_BOARD'] }">
						<form name="f1" onclick="javascript:findDetailPage('${dto.article_num}')">
							<c:set var="tmp" value="${tmp+1 }"/>
								<a href="notice_detail.board?article_num=${dto.article_num}" class="grayA gapA">
									${dto.subject}<c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if><c:if
										test="${dto.image != '督析蒸製' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if> 
								</a>
								
							</form>
						</c:forEach>
					</p>
				</div>

			</div>
		</div>
		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100 shadow">
				<div class="card-header">
					<img class="img-index" src="resources/img/INFO.png">
					<a href="info_list.board" class="blackA titleA">舛左 因政 惟獣毒</a>
				</div>
				<div class="card-body" style="padding: 0.5rem 2rem;">
					<p class="card-text">
						<c:if test="${empty indexListMap['EZEN_INFO_BOARD']}">
							<a href="#" class="grayA gapA">惟獣弘戚 蒸柔艦陥. ばば</a>
						</c:if>
						<c:forEach var="dto" items="${indexListMap['EZEN_INFO_BOARD'] }">
						<form name="f1" onclick="javascript:findDetailPage('${dto.article_num}')">
							<c:set var="tmp" value="${tmp+1 }"/>
							<c:if test="${sessionScope.userId != null}">
								<a href="info_detail.board?article_num=${dto.article_num}" class="grayA gapA">
									<font color="#007bff">${dto.category}</font> ${dto.subject}
									<c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if> <c:if
										test="${dto.image != '督析蒸製' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if> 
								</a>
								&nbsp;
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/up.png">
								<font color="blue"size="2">${dto.upCount}</font>
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/down.png">
								<font color="red"size="2">${dto.downCount}</font>
							</c:if>
						</form>
							<c:if test="${sessionScope.userId == null}">
								<a href="#" onclick="javascript:loginPlz()" class="grayA gapA"><font color="#007bff">${dto.category}</font>
									${dto.subject}  <c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if>
									<c:if test="${dto.image != '督析蒸製' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if>
								</a>
								&nbsp;
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/up.png">
								<font color="blue"size="2">${dto.upCount}</font>
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/down.png">
								<font color="red"size="2">${dto.downCount}</font>
							</c:if>
						</c:forEach>
					</p>
				</div>
			</div>
		</div>

		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100 shadow">
				<div class="card-header">
					<img class="img-index" src="resources/img/REVIEW.png">
					<a href="review_list.board" class="blackA titleA">走蝕紺 呪悪板奄 惟獣毒</a>
				</div>
				<div class="card-body" style="padding: 0.5rem 2rem;">
					<p class="card-text">
						<c:if test="${empty indexListMap['EZEN_REVIEW_BOARD']}">
							<a href="#" class="grayA gapA">惟獣弘戚 蒸柔艦陥. ばば</a>
						</c:if>
						<c:forEach var="dto" items="${indexListMap['EZEN_REVIEW_BOARD'] }">
						<form name="f1" onclick="javascript:findDetailPage('${dto.article_num}')">
							<c:set var="tmp" value="${tmp+1 }"/>
							<c:if test="${sessionScope.userId != null}">
								<a href="review_detail.board?article_num=${dto.article_num}" class="grayA gapA">
									<font color="#007bff">${dto.category}</font> ${dto.subject} <c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if>
									<c:if
										test="${dto.image != '督析蒸製' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if> 
								</a>
								&nbsp;
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/up.png">
								<font color="blue"size="2">${dto.upCount}</font>
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/down.png">
								<font color="red"size="2">${dto.downCount}</font>
							</c:if>
						</form>
							<c:if test="${sessionScope.userId == null}">
								<a href="#" onclick="javascript:loginPlz()" class="grayA gapA"><font color="#007bff">${dto.category}</font>
									${dto.subject} <c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if>
									<c:if test="${dto.image != '督析蒸製' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if> 
								</a>
								&nbsp;
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/up.png">
								<font color="blue"size="2">${dto.upCount}</font>
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/down.png">
								<font color="red"size="2">${dto.downCount}</font>
							</c:if>
						</c:forEach>
					</p>
				</div>
			</div>
		</div>
		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100 shadow">
				<div class="card-header">
					<img class="img-index" src="resources/img/TRADE.png">
					<a href="trade_list.board" class="blackA titleA">紫壱独壱 惟獣毒</a>
				</div>
				<div class="card-body" style="padding: 0.5rem 2rem;">
					<p class="card-text">
						<c:if test="${empty indexListMap['EZEN_TRADE_BOARD']}">
							<a href="#" class="grayA gapA">惟獣弘戚 蒸柔艦陥. ばば</a>
						</c:if>
						<c:forEach var="dto" items="${indexListMap['EZEN_TRADE_BOARD'] }">
						<form name="f1" onclick="javascript:findDetailPage('${dto.article_num}')">
							<c:set var="tmp" value="${tmp+1 }"/>
								<a href="trade_detail.board?article_num=${dto.article_num}" class="grayA gapA">
									<font color="#007bff">${dto.category}</font> ${dto.subject} <c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if>
									 <c:if
										test="${dto.image != '督析蒸製' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if>
								</a>
								&nbsp;
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/up.png">
								<font color="blue"size="2">${dto.upCount}</font>
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/down.png">
								<font color="red"size="2">${dto.downCount}</font>
							</form>
						</c:forEach>
					</p>
				</div>
			</div>
		</div>

		<div class="col-lg-6 col-md-6 mb-4">
			<div class="card h-100 shadow">
				<div class="card-header">
					<img class="img-index" src="resources/img/FREE.png">
					<a href="free_list.board" class="blackA titleA">切政惟獣毒</a>
				</div>
				<div class="card-body" style="padding: 0.5rem 2rem;">
					<p class="card-text">
						<c:if test="${empty indexListMap['EZEN_FREE_BOARD']}">
							<a class="grayA gapA">惟獣弘戚 蒸柔艦陥. ばば</a>
						</c:if>
						<c:forEach var="dto" items="${indexListMap['EZEN_FREE_BOARD'] }">
						<form name="f1" onclick="javascript:findDetailPage('${dto.article_num}')">
							<c:set var="tmp" value="${tmp+1 }"/>
								<a href="free_detail.board?article_num=${dto.article_num}" class="grayA gapA">
									<font color="#007bff">${dto.category}</font> ${dto.subject} <c:if test="${dto.replyCount != 0}">
										<font color="orange" size="2">[${dto.replyCount}]</font>
									</c:if>
									<c:if
										test="${dto.image != '督析蒸製' }">
										<img class="media-object img-circle"
											style="width: 14px; height: 12px;"
											src="resources/img/picture.png">
									</c:if> 
								</a>
								&nbsp;
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/up.png">
								<font color="blue"size="2">${dto.upCount}</font>
								<img class="media-object img-circle"style="width: 15px; height: 15px;"src="resources/img/down.png">
								<font color="red"size="2">${dto.downCount}</font>
							</form>
						</c:forEach>
					</p>
				</div>
			</div>
		</div>
	</div>
	<!-- /.row -->

</div>
<!-- /.container -->
<jsp:include page="footer.jsp" />