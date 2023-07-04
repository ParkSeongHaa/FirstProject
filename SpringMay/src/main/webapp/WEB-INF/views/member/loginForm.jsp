<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp" %>
<script type="text/javascript">
	
$(function(){
	$(".login_button").on("click",function(e){
		e.preventDefault();
		if(isValid()) {
			$("form").submit();
		}
	});
	
	function isValid(){
		const userid = $("#userid").val()
		const userpw = $("#userpw").val()
		if(userid === "") {
			$("#error_userid").text("아이디는 필수항목입니다.");
			$("#error_userid").css("color","red");
			$("#error_userid").focus();
			return false;
		}
		if(userpw === "") {
			$("#error_userpw").text("비밀번호는 필수항목입니다.").css("color","red");
			$("#error_userpw").focus();
			return false;
		}
		return true;
	}

	$("#userid").on("input",function(e){
		let userId = $(this).val();
		if(userId.length ===0) {
			$("#error_userid").text("아이디를 입력하세요").css("color","red");
		} else if(userId.length!=0) {
            $("#error_userid").text("");
        }
	})
	
	$("#userpw").on("input",function(e){
		let userPw = $(this).val();
		if(userPw.length ===0) {
			$("#error_userpw").text("비밀번호를 입력하세요").css("color","red");
		} else if(userPw.length!=0) {
            $("#error_userpw").text("");
        }
	})
	
	let error = "${error}";
	console.log(error);
	if(error ==="") {
		return;
	}
	if(error==="nonuser"){
		$("#userid").focus();
	} else{
		$("#userpw").focus();
	}
	let msg = (error ==="nonuser") ? "존재하지 않는 ID입니다." : "비밀번호가 일치하지 않습니다.";
	alert(msg);

})
</script>

<style>
.wraped_login {
  width: 200px;
  margin: 0 0 0 10px;
  padding: 20px;
  background-color: #f7f7f7;
  border-radius: 8px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.login_form {
  display: flex;
  flex-direction: column;
}

.form_id,
.form_pw {
  margin-bottom: 20px;
}

label {
  font-weight: bold;
  margin-bottom: 5px;
  display: block;
}

.id_control,
.pw_control {
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 14px;
}

.error {
  color: red;
  font-size: 12px;
  margin-top: 5px;
}

.login_button {
  background-color: #4caf50;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
}

.login_button:hover {
  background-color: #45a049;
}
</style>
<div class="wraped_login">
	<form action="/member/login" class="login_form" method="post">
		<div class="form_id">
			<label for="userid">E-mail</label>
			<input type="email" class="id_control" id="userid" name="userid" placeholder="E-mail을 입력하세요"
			 value="${memberVO.userid }"/><!-- name이 변수명으로 넘어감 -->
			 <div class="error" id="error_userid"></div>
		</div>
		<div class="form_pw">
			<label for="userpw">비밀번호</label>
			<input type="password" class="pw_control" id="userpw" name="userpw" placeholder="비밀번호를 입력하세요"/> 
			<!-- name이 변수명으로 넘어감 -->
			<div class="error" id="error_userpw"></div>
		</div>
		<div class="form_login_button">
			<button class="login_button" type="submit">
				로그인
			</button>
		</div>
	</form>
</div>

<%@include file="../includes/footer.jsp" %>