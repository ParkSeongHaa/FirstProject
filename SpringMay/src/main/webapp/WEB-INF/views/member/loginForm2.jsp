<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header2.jsp" %>

<script type="text/javascript">
	
$(function(){
	$("#login_btn").on("click",function(e){
		e.preventDefault();
		if(isValid()) {
			$("form").submit();
		}
	});
	
	function isValid(){
		const userid = $("#login_id").val()
		const userpw = $("#login_pw").val()
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

	$("#login_id").on("input",function(e){
		let userId = $(this).val();
		if(userId.length ===0) {
			$("#error_userid").text("아이디를 입력하세요").css("color","red");
		} else if(userId.length!=0) {
            $("#error_userid").text("");
        }
	})
	
	$("#login_pw").on("input",function(e){
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
<link rel="stylesheet" href="/resources/css/login.css">

        <div id="header3">
            <div id="header3_pic">
                <div id="header3_seleted_menu">
                    <h1>회원관련</h1>
                </div>
                <div id="header3_seleted_menu_bar">
                    <img src="/resources/images/home.png"> > 회원관련 > 로그인
                </div>
            </div>
            <div id="header3_bottom_bar"></div>
        </div>
        <div id="board">
            <div id="side_menu">
                <ul id="side_ul">
                    <li><a href="/member/login">로그인</a></li>
                    <li><a href="/member/signupLv1">회원가입</a></li>
                    <li><a href="/member/findId">아이디찾기</a></li>
                    <li><a href="/member/findPw">비밀번호찾기</a></li>
                </ul>
            </div>
            <div id="main_board">
                <div id="main_selected_menu">
                    <h1>로그인</h1>
                </div>
                <form action="/member/login" class="login_form" method="post">
					<div id="login">
            			<div id="login_content">
                			<h1><span>대구광역시립 남부도서관 </span>방문을 환영합니다.</h1>
                			<div id="login_box">
                    			<div id="login_img">
                        			<img src="/resources/images/login.png">
                    			</div>
                    			<div id="login_login">
                   	     			<input type="text" placeholder="아이디" id="login_id" class="login_text_box" name="userid" value="${memberVO.userid}"/>
                   	     			<div class="error" id="error_userid"></div>
                        			<input type="password" placeholder="비밀번호" id="login_pw" class="login_text_box" name="userpw">
                       				<div class="error" id="error_userpw"></div>
                        			<button id="login_btn" type="submit">로그인</button>
                        			<a href="/member/signupLv1/"><span class="login_options">회원가입▶</span></a>
                        			<a href="/member/findId"><span class="login_options">아이디 찾기▶</span></a>
                        			<a href="/member/findPw"><span class="login_options">비밀번호 찾기▶</span></a>
                    			</div>
                    			<div id="login_notice">
                        			<span>※ 기존 회원은 통합회원 인증 후 로그인할 수 있습니다.</span>
                    			</div>
                			</div>
            			</div>
        			</div>
        		</form>
            </div>
        </div>



<%@include file="../includes/footer2.jsp" %>