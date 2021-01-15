<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<!-- sign_up.jsp -->
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
					$('#str').html('<h6>���Ұ�</h6>')
				}else {
					alert('��� ������ ���̵��Դϴ�.')
					$('#idCheck').val('true')
					$('#str').html('<h6>��밡��</h6>')
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
	<form name="f" method="post" action="sign_up_ok.login" onsubmit="return validate()">
		<input type="text" id="name" name="name" placeholder="�̸�"><br>
		<input type="text" id="id" name="id" placeholder="���̵�"> <h6>�� ���̵�� 4~12���� ���� ��ҹ��ڿ� ���ڷθ� �Է��ϼ���</h6>
		<input type="button" onclick="javascript:id_check()" value="�ߺ�üũ"><div id="str"><font style=>���Ұ�</font></div><br>
		<input type="hidden" id="idCheck" name="idCheck" value="false">
		<input type="password" id="passwd" name="passwd" placeholder="��й�ȣ"><br>
		<input type="password" name="checkpasswd" placeholder="��й�ȣ Ȯ��"><br>
		<input type="hidden" name="email" value="${sessionScope.email}">
		<input type="submit" value="Ȯ��">
		<input type="button" value="���">
	</form>
</body>
</html>