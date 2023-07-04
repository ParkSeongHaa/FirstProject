<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="./includes/header2.jsp" %>
<link rel="stylesheet" href="/resources/css/home.css">
<link rel="stylesheet" href="/resources/images/images/bx_loader.gif">
<link rel="stylesheet" href="/resources/images/images/controls.png">
<script src="/resources/js/home.js" defer></script>
<script src="/resources/js/jquery.bxslider.min.js"></script>

<script type="text/javascript">
	$(function(){
		let msg = "${msg}"
		console.log(msg);
		if(msg == ""){
			return;
		}
		if(msg == "logout") {
			alert("로그아웃되었습니다.");
		}
		if(msg == 'deleteFinish'){
			alert("회원탈퇴가 완료되었습니다.")
		}
		
		
		
		
		$("#searchBookBtn").click(function(){
			alert("S");
		})
	});
</script>

<div id="main">
		<form action="/book/bookSearch2" method="get">  
            <div id="search_container"> <!-- 검색창 -->
                <div id="search_box">
                    <div id="search1">
                        <b>통합자료검색</b>
                    </div>
                    <select id="search2" name='type'>
                        <option value="T" <c:out value="${pageDTO.criteria.type eq 'T' ? 'selected' : ''}"/>>제목</option>
                        <option value="W" <c:out value="${pageDTO.criteria.type eq 'W' ? 'selected' : ''}"/>>저자</option>
                        <option value="C" <c:out value="${pageDTO.criteria.type eq 'C' ? 'selected' : ''}"/>>발행처</option>
                        <option value="L" <c:out value="${pageDTO.criteria.type eq 'L' ? 'selected' : ''}"/>>위치</option>
                    </select>
                    <input type="text" id="search3" name="keyword" value="<c:out value="${pageDTO.criteria.keyword}"/>" placeholder="검색어를 입력하세요">
                    <div id="search4">
                         <!-- <img src="/resources/images/search.JPG" id="searchBookBtn"> -->
                         <button id="searchBookBtn"></button>
                    </div>
                </div>
            </div>
        </form>
            <div id="centerMenu">
                <a href="#"><div id="centerMenu_1">
                    <h1 class="h1">이용안내</h1>
                    <span class="span">남부도서관 이렇게 이용하세요!</span>
                    <img src="/resources/images/bell.JPG" class="img">
                </div></a>
                <a href="#"><div id="centerMenu_2">
                    <h1 class="h1">대구전자도서관</h1>
                    <span class="span">대구시민의 스마트한</span><br>
                    <span class="span">독서생활이 시작되는 곳</span>
                    <img src="/resources/images/centerMenu_2.jpg">
                </div></a>
                <a href="#"><div id="centerMenu_3">
                    <h1 class="h1">좌석예약</h1>
                    <span class="span">디지털 자료실</span><br>
                    <span class="span">좌석예약</span><br>
                    <img src="/resources/images/sc.png" class="img" style="height:50px; width:50px;">
                </div></a>
                <a href="#"><div id="centerMenu_4">
                    <h1 class="h1">마이페이지</h1>
                    <span class="span">대출조회 및 신청현황</span><br>
                    <img src="/resources/images/centerMenu_2.jpg">
                </div></a>
                <div id="centerMenu_5">
                    <a href="#"><div id="centerMenu_5_1">
                        <h1 class="h1">수강신청</h1>
                        <span class="span">온라인 수강신청</span><br>
                        <img src="/resources/images/computer.png">
                    </div></a>
                    <a href="#"><div id="centerMenu_5_2">
                        <h1 class="h1">책나래</h1>
                        <span class="span">도서관 자료</span><br>
                        <span class="span">무료우편 서비스</span>
                        <img src="/resources/images/house.png">
                    </div></a>
                </div>
                <a href="#"><div id="centerMenu_6">
                    <h1 class="h1">책나래</h1>
                    <span class="span">국가상호대차</span><br>
                    <span class="span">서비스</span><br>
                    <img src="/resources/images/book.png">
                </div></a>
                <div id="centerMenu_7">
                    <span class="span">행사일</span><br>
                    <span class="span" style="color:yellowgreen">2023-05-16</span>
                </div>
                <div id="centerMenu_8">
                    <div class="event_about">
                        <ul>
                            <li>[영화][인문학]창의성을 위한 긍정심리</li>
                            <li>[중국문화이해프로그램]중국 인문학</li>
                            <li>[시니어 아카데미]맛과 멋으로 읽는 역사 인문학</li>
                        </ul>
                    </div>
                    <div class="event_about">
                        <ul>
                            <li>[영화]헬로우 고스트</li>
                            <li>[5~6]월 자녀 일기쓰기 지도</li>
                            <li>[중국문화이해프로그램]중국어 중급반</li>
                            <li>[봄학기]시를 쓰는 즐거움</li>
                        </ul>
                    </div>
                    <div id="abc">
                        <div id="centerMenu_8_prev">
                            <!-- <a href=""><img src="images/over.png"></a> -->
                            <h1>↑</h1>
                        </div>
                        <div id="centerMenu_8_next">
                            <!-- <a href=""><img src="images/bottom.png"></a> -->
                            <h1>↓</h1>
                        </div>
                    </div>
                </div>
                <div id="centerMenu_9">
                    <span class="span">휴관일</span><br>
                    <span class="span" style="color:yellowgreen">2023-05</span>
                </div>
                <div id="centerMenu_10">
                    <div class="days">5</div>
                    <div class="days">8</div>
                    <div class="days">22</div>
                    <div class="days">27</div>
                    <div class="days">29</div>
                    <div id="def">
                        <div id="centerMenu_10_prev">
                            <!-- <a href=""><img src="images/over.png"></a> -->
                            <h1>↑</h1>
                        </div>
                        <div id="centerMenu_10_next">
                            <!-- <a href=""><img src="images/bottom.png"></a> -->
                            <h1>↓</h1>
                        </div>
                    </div>
                </div>
            </div>
            <div id="slide">
                <ul>
                    <li><a href="#"><img src="/resources/images/slide1.jpg" alt="slide_img1" class="slide_img show"></a></li>
                    <li><a href="#"><img src="/resources/images/slide2.jpg" alt="slide_img2" class="slide_img"></a></li>
                    <li><a href="#"><img src="/resources/images/slide3.jpg" alt="slide_img3" class="slide_img"></a></li>
                    <li><a href="#"><img src="/resources/images/slide4.jpg" alt="slide_img4" class="slide_img"></a></li>
                    <li><a href="#"><img src="/resources/images/slide5.jpg" alt="slide_img5" class="slide_img"></a></li>
                    <li><a href="#"><img src="/resources/images/slide6.jpg" alt="slide_img6" class="slide_img"></a></li>
                </ul>
                <div class="slide_btn" id="slide_prev">
                    ←
                </div>
                <div class="slide_btn" id="slide_play">
                    ▶
                </div>
                <div class="slide_btn" id="slide_stop">
                    ll
                </div>
                <div class="slide_btn" id="slide_next">
                    →
                </div>
                <div id="slideNum">
                    <span>1</span>/6
                </div>
            </div>
            <div id="notice">
                <div id="notice_name">
                    <h3>공지사항</h3>
                </div>
                <div id="notice_icon">
                    <a href="/board/list"><img src="/resources/images/menu2.JPG"></a>
                </div>
                <div id="notice_head">
                    <img src="/resources/images/main_notice_img.png">
                    <a href="#"><b>[안내] 어린이날 및 가정의 달 기념 행사</b></a><br>
                    <a href="#">2023-04-26</a><br>
                    <a href="#">금쪽같은 우리 가족 상담 신청하기(클릭)...</a>
                </div>
                <ul id="notice_ul">
                    <li>
                        <a href="#">
                            <span>2023년 5월 1차 이용자 희망도서 처리결과 알림</span>
                            <span>2023-05-16</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span>도전! 유튜브 크리에이터 응모 이벤트 당첨자 안내</span>
                            <span>2023-05-03</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span>[모집] 5~6월 미디어콘텐츠 프로그램 수강생 모집</span>
                            <span>2023-05-03</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span>[전시] 발달장애인 작가 미술작품 전시 'Happy Toget...</span>
                            <span>2023-05-03</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span>2023년 4월 어린이 독서퀴즈 및 나도 북큐레이터 당...</span>
                            <span>2023-05-01</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div id="movie">
                    <div id="movie_head">
                        <div id="movie_head_1">
                         <h3>영화소개</h3>
                        </div>
                        <div id="movie_head_2">
                            <a href="#"><img src="/resources/images/menu2.JPG"></a>
                        </div>
                    </div>
                    <div id="movieSlide">
                    <div id="movie_content">
                        <div id="movie_poster">
                            <a href="#"><img src="/resources/images/movie.png"></a>
                        </div>
                        <div id="movie_sub">
                            <div id="movie_age">
                                전체관람가
                            </div>
                            <p>[인문학]공감에 반대한다</p>
                            <b>날짜</b>　2023-05-19<br>
                            <b>시간</b>　14:00<br>
                            <b>장소</b>　시청각실<br>
                            <b>장르</b>　인문학
                        </div>
                    </div>  
                    <div id="movie_content_2">
                        <div id="movie_poster">
                            <a href="#"><img src="/resources/images/movie (1).jpg"></a>
                        </div>
                        <div id="movie_sub">
                            <div id="movie_age">
                                전체관람가
                            </div>
                            <p>행복을 찾아서</p>
                            <b>날짜</b>　2023-05-19<br>
                            <b>시간</b>　14:00<br>
                            <b>장소</b>　시청각실<br>
                            <b>장르</b>　인문학
                        </div>
                    </div> 
                    <div id="movie_content_3">
                        <div id="movie_poster">
                            <a href="#"><img src="/resources/images/movie (2).jpg"></a>
                        </div>
                        <div id="movie_sub">
                            <div id="movie_age">
                                전체관람가
                            </div>
                            <p>명탐정 코난: 비색의 탄환</p>
                            <b>날짜</b>　2023-05-19<br>
                            <b>시간</b>　14:00<br>
                            <b>장소</b>　시청각실<br>
                            <b>장르</b>　인문학
                        </div>
                    </div> 
                    <div id="movie_content_4">
                        <div id="movie_poster">
                            <a href="#"><img src="/resources/images/movie (3).jpg"></a>
                        </div>
                        <div id="movie_sub">
                            <div id="movie_age">
                                전체관람가
                            </div>
                            <p>우리형</p>
                            <b>날짜</b>　2023-05-19<br>
                            <b>시간</b>　14:00<br>
                            <b>장소</b>　시청각실<br>
                            <b>장르</b>　인문학
                        </div>
                    </div> 
                </div>
            </div>
            <div id="book">
                <div id="book_switch">
                    <div class="switch" id="new_book">
                        신착도서
                    </div>
                    <div class="switch" id="curation" style="border-left: 1px solid grey;">
                        북큐레이션
                    </div>
                    <div id="book_menu">
                        <a href="#"><img src="/resources/images/menu2.JPG"></a>
                    </div>
                </div>
                <div id="bookContent_1">
                    <div class="book_list">
                        <a href="#"><img src="/resources/images/book1.JPG"></a>
                        <a href="#"><p class="book_title">친구야! 나는 너와 달라 - 나는 너와 같아</p></a>
                    </div>
                    <div class="book_list">
                        <a href="#"><img src="/resources/images/book2.JPG"></a>
                        <a href="#"><p class="book_title">이상하게 재밌는 생활과학</p></a>
                    </div>
                </div>
                <div id="bookContent_2">
                    <div class="book_list">
                        <a href="#"><img src="/resources/images/book3.JPG"></a>
                        <a href="#"><p class="book_title">5월 북솔루션</p></a>
                    </div>
                    <div class="book_list">
                        <a href="#"><img src="/resources/images/book4.JPG"></a>
                        <a href="#"><p class="book_title">5월 북솔루션</p></a>
                    </div>
                </div>
            </div>
            <div id="famliySite">
                <div id="familySite_box">
                    <div id="famliySite_slide">
                        <ul id="ulul">
                            <li><a href="#"> <img src="/resources/images/slide1 (1).png"> </a></li>
                            <li><a href="#"> <img src="/resources/images/slide1 (2).png"> </a></li>
                            <li><a href="#"> <img src="/resources/images/slide1 (3).png"> </a></li>
                            <li><a href="#"> <img src="/resources/images/slide1 (4).png"> </a></li>
                            <li><a href="#"> <img src="/resources/images/slide1 (5).png"> </a></li>
                            <li><a href="#"> <img src="/resources/images/slide1 (6).png"> </a></li>
                            <li><a href="#"> <img src="/resources/images/slide1 (7).png"> </a></li>
                            <li><a href="#"> <img src="/resources/images/slide1 (8).png"> </a></li>
                            <li><a href="#"> <img src="/resources/images/slide1 (9).png"> </a></li>
                            <li><a href="#"> <img src="/resources/images/slide1 (10).png"> </a></li>
                        </ul>
                    </div>
                </div>
                <div id="famliySite_btn_box">
                    <span class="familySite_btn" id="family_slide_prev">←</span>
                    <span class="familySite_btn" id="family_slide_next">→</span>
                    <a href="#" class="familySite_btn" id="family_slide_control_stop"> ∥ </a>
                    <a href="#" class="familySite_btn hide" id="family_slide_control_start"> ▶ </a>
                    <a href="/board/list" class="familySite_btn"> ＝ </a>
                </div>
            </div>
        </div>





<%@include file="./includes/footer2.jsp" %>