<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header2.jsp" %>
<link rel="stylesheet" href="/resources/css/deleteMember.css">

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
		$("#userpw_input").focus();
	});
</script>

	<div id="header3">
            <div id="header3_pic">
                <div id="header3_seleted_menu">
                    <h1>회원관련</h1>
                </div>
                <div id="header3_seleted_menu_bar">
                    <img src="/resources/images/home.png"> > 회원관련 > 회원탈퇴
                </div>
            </div>
            <div id="header3_bottom_bar"></div>
        </div>
        <div id="board">
            <div id="side_menu">
                <ul id="side_ul">
                    <li><a href="/member/CheckPw">정보수정</a></li>	
                    <li><a href="/member/deleteMember">회원탈퇴</a></li>
                </ul>
            </div>
            <div id="main_board">
                <div id="main_selected_menu">
                    <h1>정보수정</h1>
                </div>
                <form action="/member/deleteMember" class="login_form" method="post">
					<div id="delete_notice">
						※ 도서관 서비스의 부정이용을 방지하고자 탈퇴한 회원은 재가입 하실 수 없습니다.<br>
						※ 재가입을 원하시는 경우 도서관으로 문의 부탁드립니다.<br>
						※ 회원 탈퇴를 하여도 해당 아이디로 등록된 게시물, 신청현황 등은 삭제되지 않고 남아있습니다.<br>
						※ 탈퇴 후 작성 글에 대한 모든 권한을 잃게 되므로 게시물 삭제를 원하시면 반드시 탈퇴 전에 삭제하시기 바랍니다.<br>
						※ 탈퇴 후 자료대출, 홈페이지 이용(강좌 신청 등), 전자도서관 대출 등 모든 도서관 서비스를 이용하실 수 없습니다.<br>
						※ 탈퇴 시 미반납 도서가 있을 경우 탈퇴가 불가능 합니다.<br>
						※ 책이음 회원의 경우 책이음을 먼저 탈퇴하셔야 회원 탈퇴가 가능하오니 도서관에 문의 바랍니다.<br>
						※  회원님의 정보를 안전하게 보호하기 위해 한 번 더 비밀번호를 입력해 주시기 바랍니다.<br>
					</div>
					<div id="check_pw_box">
						<div id="check_pw_title">
							비밀번호(<span class='star'>*</span>)
						</div>
						<div id="check_pw_input_box">
							<input type="password" name='userpw' id='userpw_input'/>
						</div>
						<div id="delete_btn_box">
							<button type='submit' id='deleteBtn'>탈퇴</button>
							<a href="/"><button id="cancel_delete">취소</button></a>
						</div>
					</div>
        			<input type="hidden" value="<c:out value="${auth.userid}"/>"/>
        		</form>
            </div>
        </div>



<%@include file="../includes/footer2.jsp" %>