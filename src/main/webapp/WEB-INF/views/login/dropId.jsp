<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="myPage_top.jsp"%>
<!-- dropId.jsp -->
<script>
	function dropIdCheck(){
		if(f.passwd.value==""){
			alert("비밀번호를 입력해주세요!")
			return false	
		}
		return true
	}
</script>
<h2>
1. 탈퇴 후에 아이디 '${userId}'는 다시 사용할 수 없으면 아이디와 데이터는 복구할 수 없습니다.<br>
2. 현재 아이디로 작성한 게시글, 댓글등 모든 활동 내역이 삭제됩니다. <br>
3. 위 사항들을 읽고 신중하게 생각해보시고 아래칸에 회원의 비밀번호를 적고 확인 버튼을 누르면 회원탈퇴가 이루어집니다.<br>
</h2>
<form name="f" action="dropId.login" method="post" onsubmit="return dropIdCheck()">
<input type="password" name="passwd" placeholder="비밀번호">
<input type="hidden" name="id" value="${sessionScope.userId}">
<input type="submit" value="회원탈퇴">
</form>
<%@include file="myPage_bot.jsp"%>


