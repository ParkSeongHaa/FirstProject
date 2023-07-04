<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header2.jsp" %>
<link rel="stylesheet" href="/resources/css/signupFormLv1.css">
<link rel="stylesheet" href="/resources/css/signupFormLv2.css">
<script src="/resources/js/signupFormLv2.js" defer></script>


<div id="header3">
            <div id="header3_pic">
                <div id="header3_seleted_menu">
                    <h1>회원관련</h1>
                </div>
                <div id="header3_seleted_menu_bar">
                    <img src="/resources/images/home.png"> > 회원관련 > 회원가입
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
                    <h1>회원가입</h1>
                </div>
				<div id="membership_content">
                <div id="membership_icon">
                    <div class="order">
                        <img src="/resources/images/mem_prcs01.png" class="order_icon">
                        <span class="order_text">회원유형확인</span>
                    </div>
                    <img src="/resources/images/mem_prcs_arrow.png" class="arrow">
                    <div class="order">
                        <img src="/resources/images/mem_prcs02_on.png" class="order_icon">
                        <span class="order_text">이용약관동의</span>
                    </div>
                    <img src="/resources/images/mem_prcs_arrow.png" class="arrow">
                    <div class="order">
                        <img src="/resources/images/mem_prcs03.png" class="order_icon">
                        <span class="order_text">본인확인</span>
                    </div>
                    <img src="/resources/images/mem_prcs_arrow.png" class="arrow">
                    <div class="order">
                        <img src="/resources/images/mem_prcs04.png" class="order_icon">
                        <span class="order_text">정보입력</span>
                    </div>
                </div>
                <div class="membership_terms">
                    <h2>▶ 대구광역시 도서관 통합회원 이용 약관</h2>
                    <div class="term">
                        약관
                    </div>
                    <div class="agree_term">
                        <input type="checkbox" class="agree" id="agree1">통합회원 이용약관에 동의합니다.
                    </div>
                </div>
                <div class="membership_terms">
                    <h2>▶ 개인정보 공통이용(제공) 내역</h2>
                    <div class="term">
                        약관
                    </div>
                    <div class="agree_term">
                        <input type="checkbox" class="agree" id="agree2">개인정보 공동이용에 동의합니다.
                    </div>
                </div>
                <div class="membership_terms">
                    <h2>▶ 개인정보 제3자 제공 내역</h2>
                    <div class="term">
                        약관
                    </div>
                    <div class="agree_term">
                        <input type="checkbox" class="agree" id="agree3">개인정보 제3자 제공에 동의합니다.
                    </div>
                </div>
                <div id="last_check">
                    <input type="checkbox" id="all_agree" class="agree"> <span>모든 약관에 동의합니다.</span><br>
                    <a href='/member/signupLv3'><button id="next_level">동의합니다.</button></a>
                    <button id="no_next_level">동의하지 않습니다.</button>
                </div>
            </div>
        </div>
	</div>



<%@include file="../includes/footer2.jsp" %>