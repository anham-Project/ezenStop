<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- login.jsp-->
<jsp:include page="../header.jsp" />
<script type="text/javascript">



window.open('', '', 'status=no, height=300, width=200, left='+ popupX + ', top='+ popupY);

		function checkMember(){
			var popupWidth = 450;
			var popupHeight = 450;
			var popupX = (window.screen.width / 2) - (popupWidth / 2);
			var popupY= (window.screen.height / 2) - (popupHeight / 2);
			window.open('email.login', "이메일 인증", 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY)
		}	
		function findMember(){
			var popupWidth = 600;
			var popupHeight = 500;
			var popupX = (window.screen.width / 2) - (popupWidth / 2);
			var popupY= (window.screen.height / 2) - (popupHeight / 2);
			window.open('find.login', "아이디/비밀번호 찾기", 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY)
		}	
		function login(){
			if(document.f.id.value==""){
				alert("아이디를 입력해주세요!")
				return false
			}else if(document.f.passwd.value==""){
				alert("비밀번호를 입력해주세요!")
				return false
			}
			return true
		}
</script>
<div class="container align-items-center mt-5" style="width: 30%;min-height: 400px;margin-top:50px;">
	<form action="login.login" method="post" name="f"
		onsubmit="return login()">
		<div class="form-group">
			<input type="text" name="id" class="form-control"
				placeholder="아이디를 입력해주세요." /> <input type="password" name="passwd"
				class="form-control" placeholder="비밀번호를 입력해주세요." />
		</div>
		<div class="form-group">
			<input type="submit" value="로그인" class="btn btn-primary btn-block">
		</div>
	</form>
	<div align="center" style="padding:0px 0px 0px 0px;">
	<a class="btn btn-outline-secondary btn-sm" href="javascript:checkMember()">회원가입</a> <a
		class="btn btn-outline-secondary btn-sm" href="javascript:findMember()">아이디|비밀번호 찾기</a>
	</div>
</div>
<!-- 
	<div align="center">
	<b>로 그 인</b>
	<form action="login.login" method="post" name="f" onsubmit="return login()">
	<input type="text" name="id" class="box" size="20" placeholder="아이디를 입력해주세요."><br>
	<input type="password" name="passwd" class="box" size="20" placeholder="비밀번호를 입력해주세요."><br>
	<input type="submit" value="로그인">
	</form>
	<a href="javascript:checkMember()">회원가입</a>
	<a href="javascript:findMember()">아이디|비밀번호 찾기</a>
	</div>
-->

<jsp:include page="../footer.jsp" />