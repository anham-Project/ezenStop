<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<!-- sign_up.jsp -->
<style>
	.container .grayline{
	border: 1px solid #E7E7E7
	}
</style>
<script>
	function check(re, what, message) {
	    if(re.test(what.value)) {
	        return true;
	    }
	    alert(message);
	    what.value = "";
	    what.focus();
	    //return false;
	}
	function id_check(){
		var id = $('#id').val();
		$.ajax({
			type : "POST",
			url : "id_check.login",
			contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			data : {
				id : id,
			},
			datatype : 'text',
			success : function(result){
				if(result == '1'){
					alert('�̹� ������� ���̵��Դϴ�.')
					$('#idCheck').val('false')
					$('#str').html('<font size="2" color="gray">�ٸ� ���̵�� �ߺ�üũ�� ���ּ���.</font>')
				}else if(result =='0') {
					alert('��� ������ ���̵��Դϴ�.')
					$('#idCheck').val('true')
					$('#str').html('<font size="2" color="gray">���̵� �ߺ�üũ �Ϸ�!!</font>')
				}else {
					alert('�ùٸ��� ���� ���̵� �����Դϴ�.')
					$('#idCheck').val('false')
				}
			}
		})
	}
   function validate() {
       var re = /^[a-zA-Z0-9]{4,12}$/ // ���̵�� �н����尡 �������� �˻��� ���Խ�
       // �̸����� �������� �˻��� ���Խ�
       var id = document.getElementById("id");
       var pw = document.getElementById("passwd");
       var name = document.getElementById("name");
       
       // ------------ �̸��� ���� -----------
       if(!check(re,id,"���̵�� 4~12���� ���� ��ҹ��ڿ� ���ڷθ� �Է�")) {
           return false;
       }
       if(!check(re,pw,"�н������ 4~12���� ���� ��ҹ��ڿ� ���ڷθ� �Է�")) {
           return false;
       }
       if(f.passwd.value != f.checkpasswd.value) {
           alert("��й�ȣ�� �ٸ��ϴ�. �ٽ� Ȯ���� �ּ���.");
           join.checkpasswd.value = "";
           join.checkpasswd.focus();
           return false;
       }
       if(f.idCheck.value == "false"){
    	   alert("���̵� �ߺ�üũ�� ���ּ���.")
    	   return false;
       }
       return true
   }
</script>
<html>
<head>
<title>ȸ �� �� ��</title>
</head>
<body>
	<div class = "container" style="margin-top:10px; margin-bottom:10px;">
		<div align="center">
       	<h4><b>ȸ �� �� ��</b></h4>
        <hr/>
        </div>
        <div class="row" style="padding-left:50px">
      		<form name="f" method="post" action="sign_up_ok.login" onsubmit="return validate()">
	        	<div class="input-group" style="padding-left:5%; padding-right:5%; padding-bottom:3px; max-width:80%">
					<input class="form-control" type="text" id="name" name="name" placeholder="�̸�">	
				</div>
				<div class="input-group" style="padding-left:5%; padding-right:5%; max-width:80%;">
					<input class="form-control" type="text" id="id" name="id" placeholder="���̵�">
					<input class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:id_check()" value="�ߺ�üũ">
				</div>
				<div class="input-group" style="padding-left:5%; padding-right:5%;padding-bottom:3px; max-width:80%">
					<font size="2" color="gray">�� ���̵�� 4~12���� ���� ��ҹ��ڿ� ���ڷθ� �Է��ϼ���.<br></font>
					<div id="str"></div>
				</div>
				<input type="hidden" id="idCheck" name="idCheck" value="false">
				<input type="hidden" name="email" value="${sessionScope.email}">
				<div class="input-group" style="padding-left:5%; padding-right:5%; padding-bottom:3px; max-width:80%">
					<input class="form-control" type="password" id="passwd" name="passwd" placeholder="��й�ȣ">
				</div>
				<div class="input-group" style="padding-left:5%; padding-right:5%; padding-bottom:3px; max-width:80%">
					<input class="form-control" type="password" name="checkpasswd" placeholder="��й�ȣ Ȯ��">
				</div>
				<div class="input-group" style="padding-left:5%; padding-right:5%; padding-bottom:3px; max-width:80%">
					<font size="2" color="gray">�� ��й�ȣ�� �ѹ� �� �Է��ϼ���.</font>
				</div>
				<div class="input-group" style="padding-left:43%;">
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="Ȯ��">&nbsp;
					<input class="btn btn-outline-secondary btn-sm" type="button" value="���">
				</div>
			</form>
		</div>
	</div>
</body>
</html>