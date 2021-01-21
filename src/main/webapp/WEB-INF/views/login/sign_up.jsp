<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link href="resources/vendor/bootstrap/css/custom.css" rel="stylesheet">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<!-- sign_up.jsp -->
<script>
	function winclose(){
		self.close()
	}
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
					$('#addstr').html('<h5>�ٸ� ���̵�� �ߺ�üũ�� ���ּ���.</h5>')
				}else if(result =='0') {
					alert('��� ������ ���̵��Դϴ�.')
					$('#idCheck').val('true')
					$('#addstr').html('<h5>���̵� �ߺ�üũ �Ϸ�!!</h5>')
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
	<div class ="lineBox shadow">
		<div class = "header">
       		<h4>ȸ �� �� ��</h4>
        <hr/>
        </div>
        <div class="row">
        	<div class="i-am-centered">
      		<form name="f" method="post" action="sign_up_ok.login" onsubmit="return validate()">
	        <div class="col-12">	
	        	<div class="input-group A">
					<input class="form-control" type="text" id="name" name="name" placeholder="�̸�">	
				</div>
				<div class="input-group A">
					<input class="form-control" type="text" id="id" name="id" placeholder="���̵�">
					<input class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:id_check()" value="�ߺ�üũ">
				</div>
				<div class="input-group B">
					<h6>�� ���̵�� 4~12���� ���� ��ҹ��ڿ� ���ڷθ� �Է��ϼ���.</h6>
				</div>
				<div class="input-group B">
					<div id="addstr"></div>
				</div>
				<input type="hidden" id="idCheck" name="idCheck" value="false">
				<input type="hidden" name="email" value="${sessionScope.email}">
				<div class="input-group A">
					<input class="form-control" type="password" id="passwd" name="passwd" placeholder="��й�ȣ">
				</div>
				<div class="input-group A">
					<input class="form-control" type="password" name="checkpasswd" placeholder="��й�ȣ Ȯ��">
				</div>
				<div class="input-group B">
					<h6>�� ��й�ȣ�� �ѹ� �� �Է��� �ּ���.</h6>
				</div>
			</div>
			<div align="center">
					<input class="btn btn-outline-secondary btn-sm" type="submit" value="Ȯ��">&nbsp;
					<input class="btn btn-outline-secondary btn-sm" type="button" onclick="javascript:winclose()" value="�ݱ�">
			</div>
			</form>
			</div>
		</div>
		</div>
</body>
</html>