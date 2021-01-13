<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<!-- Footer -->
</div>
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2020</p>
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