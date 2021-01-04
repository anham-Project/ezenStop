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

<title>���� �׸�...</title>

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
						aria-haspopup="true" aria-expanded="false"> ����'sTop�Խ��� </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">�α�� �Խ���</a> 
							<a class="dropdown-item" href="#">�����Խ���</a> 
							<a class="dropdown-item" href="#">�߰�å �ŷ� �Խ���</a>
							<a class="dropdown-item" href="#">������ ���� �ı� �Խ���</a>
							<a class="dropdown-item" href="#">���� ���� �Խ���</a>
						</div></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href=""
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> ķ�۽��� �Խ��� </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">��� ķ�۽�</a> 
							<a class="dropdown-item" href="#">���� ķ�۽�</a>
							<a class="dropdown-item" href="#">���� ķ�۽�</a>
							<a class="dropdown-item" href="#">��� ķ�۽�</a>
							<a class="dropdown-item" href="#">��� ķ�۽�</a>
							<a class="dropdown-item" href="#">���� ķ�۽�</a>
							<a class="dropdown-item" href="#">���� ķ�۽�</a>
							<a class="dropdown-item" href="#">�Ⱦ� ķ�۽�</a>
							<a class="dropdown-item" href="#">������ ķ�۽�</a>
							<a class="dropdown-item" href="#">���� ķ�۽�</a>
							<a class="dropdown-item" href="#">�ϻ� ķ�۽�</a>
							<a class="dropdown-item" href="#">�Ȼ� ķ�۽�</a>
							<a class="dropdown-item" href="#">���� �д� ķ�۽�</a>
							<a class="dropdown-item" href="#">���� ��� ķ�۽�</a>
							<a class="dropdown-item" href="#">���� ķ�۽�</a>
							<a class="dropdown-item" href="#">���� ķ�۽�</a>
							<a class="dropdown-item" href="#">����IT ķ�۽�</a>
						</div></li>
					<c:if test="${empty sessionScope.userId }">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href=""
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> �����ڿ� �Խ��� </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">�Ű� �Խ���</a> <a
								class="dropdown-item" href="#">���� ��� �Խ���</a>
							<a class="dropdown-item" href="#">ȸ�� ���� �Խ���</a>
						</div></li>
					</c:if>
				</ul>
			</div>
			<div class="align-right">
				<a class="btn btn-primary">�α���</a>
			</div>
		</div>
	</nav>