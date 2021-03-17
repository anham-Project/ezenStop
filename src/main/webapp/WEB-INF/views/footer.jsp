<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<!-- Footer -->
</div>
	<div class="col-1"id="rightBanner"
		style="position: relative; display: block; z-index: 100;padding-left:0px;">
		<img src="resources/img/loading.gif" style="width:100%; margin-top: 50px; margin-bottom: 10px;">
		<h1>광고 배너 공간</h1>
	</div>
</div>
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; 
			2021 - 2021 EZEN'S TOP. All rights reserved.
			</p>
		</div>
		<!-- /.container -->
	</footer>
<c:if test="${!empty userId }">
<script type="text/javascript">
	$(document).ready(function(){
		getUnread();
		getInfiniteUnread();
	});
</script>
</c:if>
</body>

</html>