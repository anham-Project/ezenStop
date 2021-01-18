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
<div class="info">
<h5>1. 탈퇴 후에 아이디 '${userId}'는 다시 사용할 수 없으며,</h5>
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;아이디와 데이터는 복구할 수 없습니다.</h5><br>
<h5>2. 현재 아이디로 작성한 게시글, 댓글 등 모든 활동 내역이 삭제됩니다.</h5><br>
<h5>3. 위 사항을 참고하여 신중하게 생각해보시고,</h5>
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;아래에 비밀번호를 적고 확인 버튼을 누르면 회원탈퇴가 이루어집니다.</h5><br>
<h5><font color="red">이 과정은 취소가 불가합니다.</font></h5><br>
</div>
<div class="row" style="padding-left:50px;">
<form name="f" action="dropId.login" method="post" onsubmit="return dropIdCheck()">
<input type="hidden" name="id" value="${sessionScope.userId}">
<div class="input-group A" style="padding-bottom:10px;">
<input class="form-control" type="password" name="passwd" placeholder="비밀번호">
<input class="btn btn-outline-secondary btn-sm" type="submit" value="회원탈퇴">
</div>
</form>
</div>
<%@include file="myPage_bot.jsp"%>


