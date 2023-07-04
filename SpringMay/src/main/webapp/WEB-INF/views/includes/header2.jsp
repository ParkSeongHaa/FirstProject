<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="/resources/js/jquery.cookie.min.js"></script>
	<script src="/resources/js/header.js" defer></script>
	<link rel="stylesheet" href="/resources/css/header.css">
<title>Spring project</title>
</head>
<body>
	<div id="wrap">
        <div id="header1">
            <a href="/"><img src="/resources/images/topLogo.JPG" alt="Logo"></a>
            <ul>
            	<!-- <li class="letter"><a href="/">홈으로</a> -->
            	<c:choose>
            	<c:when test="${not empty auth}">
            		<li class="letter"><c:out value="${auth.userid}"/>님</li>
            		<li class="letter"><a href="/member/logout">로그아웃</a></li>
            		<li class="letter"><a href="/member/CheckPw">정보수정</a></li>
  	          	</c:when>
  	          	<c:otherwise>
  	          		<li class="letter"><a href="/member/login">로그인</a></li>
                	<li class="letter"><a href="/member/signupLv1">회원가입</a></li>
  	          	</c:otherwise>	
                </c:choose>
                <li class="letter"><a href="/board/list">게시판</a></li>
                <li class="letter"><a href="/book/bookSearch2">도서검색</a></li>
                <c:choose>
                	<c:when test="${auth.admin == 1}">
                		<li class="letter"><a href="/book/bookRegisterForm">도서등록</a></li>
                		<li class="letter"><a href="/book/bookModify">도서관리</a></li>
                	</c:when>
                </c:choose>
                <li class="icon"><a href="/board/list"><img src="/resources/images/menu.JPG" alt="menu"></a></li>
                <li class="icon"><a href="#"><img src="/resources/images/kakao.JPG" alt="menu"></a></li>
                <li class="icon"><a href="#"><img src="/resources/images/twitter.JPG" alt="menu"></a></li>
                <li class="icon"><a href="#"><img src="/resources/images/facebook.JPG" alt="menu"></a></li>
            </ul>
        </div>
        <div id="header2">
            <div id="menu1">
                <ul id="gnb">
                    <li>
                        <a href="#">자료검색</a>
                        <ul class="lnb"> <!--자료검색-->
                            <li><a href="#">자료검색</a></li>
                            <li><a href="#">신착자료</a></li>
                            <li><a href="#">대출베스트</a></li>
                            <li><a href="#">희망도서신청</a></li>
                            <li><a href="#">사서추천도서</a></li>
                            <li><a href="#">테마별 북큐레이션</a></li>
                            <li><a href="#">다문화도서</a></li>
                            <li><a href="#">정기간행물 목록</a></li>
                            <li><a href="#">대구전자도서관</a></li>
                            <li><a href="#">도서관 협력서비스</a></li>
                            <li><a href="#">희망도서 바로대출</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">평생교육</a>
                        <ul class="lnb " ><!--평생교육-->
                            <li><a href="#">강좌소개</a></li>
                            <li><a href="#">수강신청</a></li>
                            <li><a href="#">창의적 체험활동</a></li>
                            <li><a href="#">소외계층 프로그램</a></li>
                            <li><a href="#">수강후기</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">독서문화행사</a>
                        <ul class="lnb lnb3"><!--독서문화행사-->
                            <li><a href="#">독서문화행사</a></li>
                            <li><a href="#">독서회</a></li>
                            <li><a href="#">영화상영</a></li>
                            <li><a href="#">시설대관</a></li>
                            <li><a href="#">독서퀴즈</a></li>
                            <li><a href="#">어린이북 큐레이션</a></li>
                            <li><a href="#">나도북큐레이터</a></li>
                            <li><a href="#">테마별 중국 도서전</a></li>
                            <li><a href="#">대구·경북 다시보기</a></li>
                            <li><a href="#">치매예방도서전</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">열린공간</a>
                        <ul class="lnb"> <!--열린공간-->
                            <li><a href="#">공지사항</a></li>
                            <li><a href="#">이달의행사</a></li>
                            <li><a href="#">자주묻는질문</a></li>
                            <li><a href="#">묻고답하기</a></li>
                            <li><a href="#">반부패청렴방</a></li>
                            <li><a href="#">설문조사</a></li>
                            <li><a href="#">RSS서비스</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">정보공개</a>
                        <ul class="lnb"><!--정보공개-->
                            <li><a href="#">입찰정보</a></li>
                            <li><a href="#">정보공개</a></li>
                            <li><a href="#">공공데이터개방제도</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">도서관안내</a>
                        <ul class="lnb lnb6"><!--도서관안내-->
                            <li><a href="#">인사말</a></li>
                            <li><a href="#">일반현황</a></li>
                            <li><a href="#">이용안내</a></li>
                            <li><a href="#">자료실안내</a></li>
                            <li><a href="#">스마트도서관</a></li>
                            <li><a href="#">자료기증</a></li>
                            <li><a href="#">찾아오시는길</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">나의도서관</a>
                        <ul class="lnb lnb7"><!--나의도서관-->
                            <li><a href="#">대출현황</a></li>
                            <li><a href="#">예약현황</a></li>
                            <li><a href="#">희망도서 신청현황</a></li>
                            <li><a href="#">수강신청현황</a></li>
                            <li><a href="#">나의보관함</a></li>
                            <li><a href="#">대구시민인증</a></li>
                            <li><a href="#">대구학생인증(DLS)</a></li>
                            <li><a href="#">스마트도서 추천</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div id="menu2">
                <div id="popup_1">
                    <div id="popup_1_img"></div>
                    <div id="popup_1_close_box">
                        <div id="radio_box">
                            <input type="radio" class="popup_radio" id="select1">
                            <label for="select1">오늘하루 열지않기</label>
                            <input type="radio" class="popup_radio" id="select2">
                            <label for="select2">7일간 보지않기</label>
                        </div>
                        <span class="closeBtn" id="closeBtn1"><b>X</b></span>
                    </div>
                </div>
                <div id="popup_2">
                    <div id="popup_2_img"></div>
                    <div id="popup_1_close_box">
                        <div id="radio_box">
                            <input type="radio" class="popup_radio" id="select3">
                            <label for="select3">오늘하루 열지않기</label>
                            <input type="radio" class="popup_radio" id="select4">
                            <label for="select4">7일간 보지않기</label>
                        </div>
                        <span class="closeBtn" id="closeBtn2"><b>X</b></span>
                    </div>
                </div>
            </div>
        </div>	
	
	
	
	
</body>
</html>