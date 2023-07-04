<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/resources/js/tests(class).js" defer></script>
<script type="text/javascript">
$(function(){
	$("#phone1").on("input",function(e){
		let phone1 = $(this).val();
		if(phone1.length === 3) {
			$("#phone2").focus();
		}
	});
	$("#phone2").on("input",function(e){
		let phone2 = $(this).val();
		if(phone2.length === 4) {
			$("#phone3").focus();
		}
	});
	$("#phone3").on("input",function(e){
		let phone3 = $(this).val();
		if($("#phone1").val().length === 3 && $("#phone2").val().length === 4 && $("#phone3").val().length === 4) {
			$("#send").attr("style","background-color: #FFFFFF; color: #0068FF; cursor:pointer;");
			$("#send").attr("disabled",false);
		} 
	});
	$("#signup__button").on("click",function(e){
		e.preventDefault();
		if(isValid()) {
			$("form").submit();
		}
	});
 
	function isValid(){
		const userid = $("#email").val();
		const username = $("#name").val();
		const password1 = $("#pw1").val();
		const password2 = $("#pw2").val();
		const location = $("#location").val();
		const genderWoman = $("#gender__woman").is(":checked");
		const genderMan = $("#gender__man").is(":checked");
		
		/* $("#error__email").text("");
		$("#error__name").text("");
		$("#error__password1").text("");
		$("#error__password2").text("");
		$("#error__location").text("");
		$("#error__gender").text(""); */ 
		
		var regExp = /^[0-9a-zA-Z] ([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-z])*\.[a-zA-Z]{2,3}$/;
		var regExp2 = /^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/
		if(regExp2.test(userid)===false) {
			$("#error__email").text("이메일이 올바르지 않습니다.");
			$("#email").focus();
			return false;
		} 
		if(username === "") {
			$("#error__name").text("이름이 올바르지 않습니다.");
			$("#name").focus();
			return false;
		}
		if(password1==="") {
			$("#error__password1").text("비밀번호를 입력해 주세요.");
			$("#pw1").focus();
			return false;
		}
		if(password2==="") {
			$("#error__password1").text("비밀번호를 입력해 주세요.");
			$("#pw2").focus();
			return false;
		}
		
		const validLocations = ["서울","경기도","인천","대전","광주","대구","부산","울산","충청도","강원도","전라도","경상도","제주도"];
		if(!validLocations.includes(location)){
			$("#error__location").text("필수항목입니다.");
			$("#location").focus();
			return false;	
		}
		if(genderWoman === false && genderMan == false) {
			$("#error__gender").text("필수항목(성별)입니다.");
			$("#gender__woman").focus();
			return false;
		}
		
		return true;
	}
	
	const timer = new Timer()
	
	$("#send").on("click",function(e){
		/* getToken(); */
		/* memberService.getToken($("#token") , $("#send"), $("#finished"),$("#timer")); */
		timer.getToken($("#token") , $("#send"), $("#finished"),$("#timer"));
	});
	$("#finished").on("click",function(e){
		/* getTimerIntervalConfirm(); */
		/* memberService.getTimerIntervalConfirm($("#finished"),$("signup__button")); */
		timer.getTimerIntervalConfirm($("#finished"),$("signup__button"));
	});
	
	function getToken(){
		const token = String(Math.floor(Math.random()*100000)).padStart(6,"0")
		$("#token").text(token);
		$("#send").attr("style","background-color:#FFFFFF; cursor:default;");
		$("#send").attr("disabled",true);
		$("#finished").attr("style","background-color: #0068FF; color:#FFFFFF; cursor:pointer;");
		$("#finished").attr("disabled",false);
		getTimerInterval();
	}
	
	let interval;
	
	function getTimerInterval(){
		let time=179;
		interval = setInterval(() =>{
			if(time >=0) {
				const minutes = Math.floor(time / 60);
				const seconds = time % 60;
				$("#timer").text(minutes + ":" + String(seconds).padStart(2,"0"));
				time-=1;
			} else{
				$("#token").text("000000");
				$("#send").attr("style","");
				$("#send").attr("disabled",true);
				$("#timer").text("3:00");
				$("#finished").attr("style","");
				$("#finished").attr("disabled",true);
				clearInterval(interval);
			}
		},1000);
	}
	
	function getTimerIntervalConfirm(){
		clearInterval(interval)
		$("#finished").attr("style","background-color:#FFFFFF; cursor:default;");
		$("#finished").attr("disabled",true);
		$("#finished").text("인증하기");
		alert("인증 완료");
		$("#signup__button").attr("style","background-color:#FFFFFF; color:#2C3639; border: 1px solid #2C3639; cursor:pointer;");
		$("#signup__button").attr("disabled",false);
		$("#timer").text("0:00");
		$("#certify").text("인증완료").css("color","blue");
		
	}
//--------------------------------------------	
	
/*     $("#error__email").text("이메일을 입력하세요"); */
    $("#error__email").css("color","red")
	$("#email").on("input",function(e){
		let userId = $(this).val();
		if(userId.length ===0) {
			$("#error__email").text("이메일을 입력하세요");
		} else if(userId.length!=0) {
            $("#error__email").text("");
        }
	}) 
	
    /* $("#error__name").text("이름을 입력하세요"); */
    $("#error__name").css("color","red")
	$("#name").on("input",function(e){
		let userName = $(this).val();
		if(userName.length ===0) {
			$("#error__name").text("이름을 입력하세요");
		} else if(userName.length!=0) {
            $("#error__name").text("");
        }
	})
	
    /* $("#error__password1").text("비밀번호를 입력하세요"); */
    $("#error__password1").css("color","red")
	$("#pw1").on("input",function(e){
		let userPw = $(this).val();
		if(userPw.length ===0) {
			$("#error__password1").text("비밀번호를 입력하세요");
		} else if(userPw.length!=0) {
            $("#error__password1").text("");
        }
	})
	

    
	$("#pw2").on("input",function(e){
        let userPw1 = $("#pw1").val();
		let userPw2 = $(this).val();
		if(userPw2 != userPw1) {
			$("#error__password2").text("비밀번호가 일치하지 않습니다.")
			$("#error__password2").css("color","red")
        } else if(userPw1 == userPw2) {
            $("#error__password2").text("비밀번호가 일치합니다.")
            $("#error__password2").css("color","blue")
        }
	})
	
	$("#error__location").text("지역을 선택하세요");
    $("#error__location").css("color","red")
	$("#location").on("change",function(e){
		$("#error__location").text("");
	})
	
	$("#error__gender").text("성별을 선택하세요").css("color","red");
    /* $("#error__password1").css("color","red") */
	$(".radioGender").on("change",function(e){
		$("#error__gender").text("");
	})
	
	
	
})
</script>
<title>회원가입</title>
</head>
<body>
<div class="wrapper_signup">
    <div class="main_body">
        <header class="wrap__title">회원가입</header>
        <form role="form" action="/member/signup" method="post">
            <main class="wrap__main">
                <input class="main__input" id="email" type="email" name="userid" placeholder="이메일을 입력해주세요."/>
                <div class="error" id="error__email"></div>
                <input class="main__input" id="name" type="text" name="username" maxlength="8" placeholder="이름을 입력해 주세요"/>
                <div class="error" id="error__name"></div>
                <input class="main__input" id="pw1" type="password" name="userpw" maxlength="20" placeholder="비밀번호를 입력해 주세요"/>
                <div class="error" id="error__password1"></div>
                <input class="main__input" id="pw2" type="password" maxlength="20" placeholder="비밀번호를 다시 입력해 주세요"/>
                <div class="error" id="error__password2"></div>

                <div class="wrap__phone">
                    <input class="phone__input" id="phone1" type="text" maxlength="3" />
                    <span>-</span>
                    <input class="phone__input" id="phone2" type="text" maxlength="4" />
                    <span>-</span>
                    <input class="phone__input" id="phone3" type="text" maxlength="4" />
                </div>

                <div class="wrap__auth">
                    <div id="auth__target">
                        <span id="token">000000</span>
                        <button class="auth_button" id="send" type="button" disabled="disabled" >
                            인증번호 전송
                        </button>
                    </div>
                </div>
                <div class="wrap__auth">
                    <div id="auth__timer">
                        <span id="timer">3:00</span>
                        <button class="auth_button" id="finished" type="button" disabled="disabled" >
                            인증하기
                        </button>
                        <div id="certify"></div>
                    </div>
                </div>
                <select class="select__box" id="location" name="location">
                    <option disabled="disabled" selected="true">지역을 선택하세요</option>
                    <option value="서울">서울</option>
                    <option value="인천">인천</option>
                    <option value="대전">대전</option>
                    <option value="광주">광주</option>
                    <option value="대구">대구</option>
                    <option value="부산">부산</option>
                    <option value="울산">울산</option>
                    <option value="경기도">경기도</option>
                    <option value="충청도">충청도</option>
                    <option value="강원도">강원도</option>
                    <option value="전라도">전라도</option>
                    <option value="경상도">경상도</option>
                    <option value="제주도">제주도</option>
                </select>
                <div class="error" id="error__location"></div>

                <div class="wrap__radio">
                    <div>
                        <input class="radioGender" type="radio" name="gender" value="woman" id="gender__woman"/>
                        <span class="gender">여성</span>
                    </div>
                    <div>
                        <input class="radioGender" type="radio" name="gender" value="man" id="gender__man"/>
                        <span class="gender">남성</span>
                    </div>
                </div>
                <div class="error" id="error__gender"></div>
            </main>
            <hr/>

            <div class="wrap__confirm">
                <button class="confirm__button" id="signup__button" type="submit">
                    가입하기
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>