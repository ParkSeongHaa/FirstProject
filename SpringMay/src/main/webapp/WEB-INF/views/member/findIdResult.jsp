<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header2.jsp" %>
<link rel="stylesheet" href="/resources/css/findIdResult.css">

        <div id="header3">
            <div id="header3_pic">
                <div id="header3_seleted_menu">
                    <h1>회원관련</h1>
                </div>
                <div id="header3_seleted_menu_bar">
                    <img src="/resources/images/home.png"> > 회원관련 > 아이디찾기
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
                    <h1>아이디찾기</h1>
                </div>
                <div id="show_findedId">
					회원님의 ID는 <span id='findedId'>'${userId }'</span> 입니다.
                </div>
                <div id="menu_box">
                	<a href="/member/login"><button id="goLogin">로그인</button></a>
                	<a href="/member/findPw"><button id="goFindPw">비밀번호 찾기</button></a>
                </div>
            </div>
        </div>



<%@include file="../includes/footer2.jsp" %>