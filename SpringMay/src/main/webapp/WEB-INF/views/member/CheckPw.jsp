<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header2.jsp" %>
<link rel="stylesheet" href="/resources/css/CheckPw.css">

<script type="text/javascript">
	$(function() {
		let pwIncorrect = "${pwIncorrect}"
		console.log(pwIncorrect);
		if (pwIncorrect == "") {
			return;
		}
		if (pwIncorrect == "pwIncorrect") {
			alert("비밀번호가 일치하지 않습니다.");
		}
	});
</script>

	<div id="header3">
            <div id="header3_pic">
                <div id="header3_seleted_menu">
                    <h1>회원관련</h1>
                </div>
                <div id="header3_seleted_menu_bar">
                    <img src="/resources/images/home.png"> > 회원관련 > 정보수정
                </div>
            </div>
            <div id="header3_bottom_bar"></div>
        </div>
        <div id="board">
            <div id="side_menu">
                <ul id="side_ul">
                    <li><a href="/member/CheckPw">정보수정</a></li>	<!-- 링크 넣어야함 -->
                    <li><a href="/member/deleteMember">회원탈퇴</a></li>	<!-- 링크 넣어야함 -->
                </ul>
            </div>
            <div id="main_board">
                <div id="main_selected_menu">
                    <h1>정보수정</h1>
                </div>
                <form action="/member/CheckPw" class="login_form" method="post">
					<div id="check_pw">
						<div id="check_title">
							비밀번호 확인 
						</div>
						<div id="input_pw">
							<input type="password" id="input_pw_check" name="userpw" placeholder="비밀번호를 입력해주세요">
						</div>
						<div id="check_pw_btnBox">
							<button id="check_pw_btn" type="submit">확인</button>
							<button id="reset_pw_btn" type="reset">취소</button>
						</div>
        			</div>
        			<input type="hidden" value="<c:out value="${auth.userid}"/>"/>
        		</form>
            </div>
        </div>



<%@include file="../includes/footer2.jsp" %>