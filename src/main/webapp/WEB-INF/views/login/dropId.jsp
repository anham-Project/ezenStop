<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- dropId.jsp -->
<script>
	function check(){
		if(f.password.value==""){
			alert("비밀번호를 입력해주세요!")
			return false	
		}
		return true
		
	}
</script>
<h2>
1. 탈퇴 후에 아이디 ${userId}는 다시 사용할 수 없으면 아이디와 데이터는 복구할 수 없습니다.
2. 현재 아이디로 작성한 게시글, 댓글등 모든 활동 내역이 삭제됩니다.
3. 위 사항들을 읽고 신중하게 생각해보시고 아래칸에 회원의 비밀번호를 적고 확인 버튼을 누르면 회원탈퇴가 이루어집니다.
</h2>
<form name="f" action="dropId.login" onsubmit="return check()">
<input type="password" name="passwd" placeholder="비밀번호">
<input type="submit" value="회원탈퇴">
</form>


