<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- īī�� �α��� ��ư�� �����մϴ�. 
<script>
Kakao.Auth.createLoginButton({ 
    container: '#kakao-login-btn', 
    success: function(authObj) { 
           Kakao.API.request({
 
               url: '/v1/user/me',
 
               success: function(res) {
 
                     console.log(res.id);//<---- �ܼ� �α׿� id ���� ���(id�� res�ȿ� �ֱ� ������  res.id �� �ҷ��´�)
 
                     console.log(res.kaccount_email);//<---- �ܼ� �α׿� email ���� ��� (������� �˰���?)
 
                     console.log(res.properties['nickname']);//<---- �ܼ� �α׿� �г��� ���(properties�� �ִ� nickname ���� 
                             
                 // res.properties.nickname���ε� ���� ���� )
                     console.log(authObj.access_token);//<---- �ܼ� �α׿� ��ū�� ���
          
          var kakaonickname = res.properties.nickname;    //īī���� �г����� ������ ���� (�г��� ���� �ٸ��������� �Ѱ� ����ϱ� ���ؼ�)
                     
          window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/hansub_project/home?kakaonickname="+kakaonickname);
          //�α��� ��� �������� �г��� ���� �Ѱܼ� ��½�Ų��.,
                   }
                 })
               },
               fail: function(error) {
                 alert(JSON.stringify(error));
               }
             });
</script>
-->
${response}