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
			window.open('email.login', "�̸��� ����", 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY)
		}	
		function findMember(){
			var popupWidth = 600;
			var popupHeight = 500;
			var popupX = (window.screen.width / 2) - (popupWidth / 2);
			var popupY= (window.screen.height / 2) - (popupHeight / 2);
			window.open('find.login', "���̵�/��й�ȣ ã��", 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY)
		}	
		function login(){
			if(document.f.id.value==""){
				alert("���̵� �Է����ּ���!")
				return false
			}else if(document.f.passwd.value==""){
				alert("��й�ȣ�� �Է����ּ���!")
				return false
			}
			return true
		}
</script>

<div class="container align-items-center mt-5" style="width: 50%;min-height: 400px;">
<div style="margin-top:25%;">
	<div align="center">
	<img class="media-object img-circle" style="margin-bottom:20px;"src = "resources/img/ezen_logo.jpg">
	</div>
	<form action="login.login" method="post" name="f"
		onsubmit="return login()">
		<div class="form-group" >
			<input type="text" name="id" class="form-control"
				placeholder="���̵� �Է����ּ���." style="margin-bottom:10px; height:55px; font-size:20px;"/> 
			<input type="password" name="passwd"class="form-control" 
				placeholder="��й�ȣ�� �Է����ּ���." style="margin-bottom:10px; height:55px; font-size:20px;"/>
		</div>
		<div class="form-group">
			<input type="submit" value="�α���" class="btn btn-primary btn-block" style="height:55px">
		</div>
	</form>
	<div align="right" style="padding:0px 0px 0px 0px;">
	<a class="btn btn-outline-secondary btn-sm" href="javascript:checkMember()">ȸ������</a> <a
		class="btn btn-outline-secondary btn-sm" href="javascript:findMember()">���̵�|��й�ȣ ã��</a>
	</div>
</div>
</div>
<jsp:include page="../footer.jsp" />