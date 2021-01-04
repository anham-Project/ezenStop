<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>이젠 그만...</title>

<!-- Bootstrap core CSS -->
<link
	href="<c:url value='resources/vendor/bootstrap/css/bootstrap.min.css'/>"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="<c:url value='resources/css/heroic-features.css'/>"
	rel="stylesheet">
<link
	href="resources/vendor/bootstrap/css/custom.css"
	rel="stylesheet">
</head>
<style>
.dropdown:hover>.dropdown-menu {
	display: block;
	margin-top: 0; 
}
</style>
<body>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="#"><h4>EzenStop</h4></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href=""
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 이젠'sTop게시판 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">인기글 게시판</a> 
							<a class="dropdown-item" href="#">자유게시판</a> 
							<a class="dropdown-item" href="#">중고책 거래 게시판</a>
							<a class="dropdown-item" href="#">지역별 강의 후기 게시판</a>
							<a class="dropdown-item" href="#">정보 공유 게시판</a>
						</div></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href=""
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 캠퍼스별 게시판 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">노원 캠퍼스</a> 
							<a class="dropdown-item" href="#">종로 캠퍼스</a>
							<a class="dropdown-item" href="#">신촌 캠퍼스</a>
							<a class="dropdown-item" href="#">상봉 캠퍼스</a>
							<a class="dropdown-item" href="#">당산 캠퍼스</a>
							<a class="dropdown-item" href="#">송파 캠퍼스</a>
							<a class="dropdown-item" href="#">강남 캠퍼스</a>
							<a class="dropdown-item" href="#">안양 캠퍼스</a>
							<a class="dropdown-item" href="#">의정부 캠퍼스</a>
							<a class="dropdown-item" href="#">구리 캠퍼스</a>
							<a class="dropdown-item" href="#">일산 캠퍼스</a>
							<a class="dropdown-item" href="#">안산 캠퍼스</a>
							<a class="dropdown-item" href="#">성남 분당 캠퍼스</a>
							<a class="dropdown-item" href="#">성남 모란 캠퍼스</a>
							<a class="dropdown-item" href="#">김포 캠퍼스</a>
							<a class="dropdown-item" href="#">전주 캠퍼스</a>
							<a class="dropdown-item" href="#">이젠IT 캠퍼스</a>
						</div></li>
					<c:if test="${empty sessionScope.userId }">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href=""
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 관리자용 게시판 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">신고 게시판</a> <a
								class="dropdown-item" href="#">삭제 대기 게시판</a>
							<a class="dropdown-item" href="#">회원 관리 게시판</a>
						</div></li>
					</c:if>
				</ul>
			</div>
			<div class="align-right">
				<a class="btn btn-primary">로그인</a>
			</div>
		</div>
	</nav>