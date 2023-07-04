<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header2.jsp" %>
<link rel="stylesheet" href="/resources/css/findPwResult.css">
<script>
$(function(){
	$("#newPw").on("click",function(e){
		e.preventDefault();
		var pw1 = $("#new_pw1").val();
		var pw2 = $("#new_pw2").val();
		var regExp2 = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{9,20}$/;
		console.log(regExp2.test(pw1));
		if(pw1 != pw2) {
			alert("비밀번호가 일치하지 않습니다.")
		} else if(regExp2.test(pw1) === false){
			alert("비밀번호 형식이 옳바르지 않습니다..")
		} else{
			alert("비밀번호가 수정되었습니다.")
			$("form").submit();
		}
		 
		
		
	}); 
	
	
	
	
	
	
	
})
</script>

        <div id="header3">
            <div id="header3_pic">
                <div id="header3_seleted_menu">
                    <h1>회원관련</h1>
                </div>
                <div id="header3_seleted_menu_bar">
                    <img src="/resources/images/home.png"> > 회원관련 > 비밀번호찾기
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
                    <h1>비밀번호찾기</h1>
                </div>
                <form action="/member/modifyPw" method="post">
                <div id="boxbox">
                	<span style="color:red;">※ 비밀번호는 영문(대소문자구분),숫자,특수문자(!@#$%^&*만허용)를 혼용하여 9~20자 이내로 구성해주십시오.</span><br>
					<table id="new_pw_table">
						<tr>
							<td class="pw_table">새로운 비밀번호</td>
							<td class="pw_table">
								<input type="password" id="new_pw1" name="userpw"  class="pw_table" placeholder="비밀번호를 입력하세요">
							</td>
						</tr>
						<tr>
							<td class="pw_table">새로운 비밀번호 확인</td>
							<td class="pw_table">
								<input type="password" id="new_pw2"  class="pw_table" placeholder="비밀번호를 입력하세요">
							</td>
						</tr>
					</table>
				</div>
                <div id="menu_box">
                	<button id="newPw" type="submit">확인</button>
                </div>
                </form>
            </div>
        </div>



<%@include file="../includes/footer2.jsp" %>