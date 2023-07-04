<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header2.jsp" %>
<link rel="stylesheet" href="/resources/css/signupFormLv1.css">

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
                        	<img src="/resources/images/mem_prcs01_on.png" class="order_icon">
                        	<span class="order_text">회원유형확인</span>
                    	</div>
                    	<img src="/resources/images/mem_prcs_arrow.png" class="arrow">
                    	<div class="order">
                        	<img src="/resources/images/mem_prcs02.png" class="order_icon">
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
                	<div id="membership_notice">
                    	<ul>
                        	<li>자신이 해당하는 회원의 종류를 선택해 주시기 바랍니다.</li>
                        	<li>회원유형에 따라 절차가 다르고, 실제 정보와 차이가 있을 경우 인증이 되지 않을 수 있습니다.</li>
                    	</ul>
                	</div>
                	<div id="membership_ageCheck">
                    	<div id="adult" class="ageCheck">
                        	<h1 class="age_text">만 14세 이상</h1>
                        	<h3 class="age_text">일반 회원</h3>
                        	<a href="/member/signupLv2"><img src="/resources/images/mem_adult.png" class="age"></a>
                    	</div>
                    	<div id="children" class="ageCheck">
                        	<h1 class="age_text">만 14세 미만</h1>
                        	<h3 class="age_text">어린이,학생회원</h3>
                        	<a href="/member/signupLv2"><img src="/resources/images/mem_child.png" class="age"></a>
                    	</div>
                	</div>
            	</div>
        	</div>
		</div>


        
        
<%@include file="../includes/footer2.jsp" %>