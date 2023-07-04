<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header2.jsp"%>
<link rel="stylesheet" href="/resources/css/editInfo.css">
<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/js/editInfo.js" defer></script>

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
                    <li><a href="/member/CheckPw">정보수정</a></li>
                    <li><a href="/member/deleteMember">회원탈퇴</a></li>
                </ul>
            </div>
            <div id="main_board">
                <div id="main_selected_menu">
                    <h1>정보수정</h1>
                </div>
                <form role="form" action="/member/editInfo" method="post">
				<table id="tab">
				<tr>
					<td class="td1"><span class="star">*</span>소속도서관</td>
					<td class="td2">대구남부도서관</td>
				</tr>
				<tr>
					<td class="td1_2">
						<span class="star">*</span>아이디
					</td>
					<td class="td2">
					<input type="text" class="box_normal" id="userid" name="userid" value='${MemberVO.userid}' readonly>
						<div class="error" id="error__id"></div>
						<div class="error" id="error__id_duplicate"></div> <br> 
					</td>
				</tr>
				<tr>
					<td class="td1_2">
						<span class="star">*</span>비밀번호
					</td>
					<td class="td2">
						<input type="password" class="box_normal" id="userpw1" name="userpw"  value='${MemberVO.userpw}'>
						<div class="error" id="error__password1" style="display: inline-block;"></div> <br> 
						<span class="sub">*비밀번호는 영문(대소문자구분),숫자,특수문자(!@#$%^&*만허용)를 혼용하여 9~20자 이내로 구성해주십시오.</span>
					</td>
				</tr>
				<tr>
					<td class="td1"><span class="star">*</span>비밀번호 확인</td>
					<td class="td2"><input type="password" class="box_normal" id="userpw2"  value='${MemberVO.userpw}'>
					<div class="error" id="error__password2"></div></td>
				</tr>
				<tr>
					<td class="td1"><span class="star">*</span>성명</td>
					<td class="td2"><input type="text" class="box_normal"
						id="username" name="username" readonly  value='${MemberVO.username}'>
						<div class="error" id="error__name"></div></td>
				</tr>
				<tr>
					<td class="td1"><span class="star">*</span>성별</td>
					<td class="td2">
						<div>
							<input class="radioGender" type="radio" name="gender" value="man"
								id="gender__man" style="display: inline-block;"  onclick="return false;" /> 
								<span class="gender">남성</span>
						</div>
						<div>
							<input class="radioGender" type="radio" name="gender"
								value="woman" id="gender__woman" style="display: inline-block;"  onclick="return false;" />
							<span class="gender">여성</span>
						</div>
						<div class="error" id="error__gender"></div>
						<input type="hidden" value='${MemberVO.gender}' id="checkGender">
					</td>
				</tr>
				<tr>
					<td class="td1"><span class="star">*</span>생년월일</td>
					<td class="td2">
						<input type="text" name="birthday"
						class="box_normal" id="birthday" maxlength="8" readonly value='${MemberVO.birthday}'/> 8자리로 입력하세요 ex)19990822
						<div class="error" id="error__birthday"></div>
					</td>
				</tr>
				<tr>
					<td class="td1_2"><span class="star">*</span>휴대폰번호</td>
					<td class="td2">
						<select class="box_small" style="height:30px;" name="phonecompany">
							<option>SKT</option>
							<option>KT</option>
							<option>LG</option>
							<option>알뜰폰</option>
						</select>
						<input type="text" class="box_small phone" id="phone1" name="phone1" maxlength="3" value='${MemberVO.phone1}'>-
						<input type="text" class="box_small phone" id="phone2" name="phone2" maxlength="4" value='${MemberVO.phone2}'>-
						<input type="text" class="box_small phone" id="phone3" name="phone3" maxlength="4" value='${MemberVO.phone3}'>
						<button class="auth_button" id="send" type="button">인증번호 전송</button> <span id="token">000000</span>
						<span id="timer">3:00</span>
						<button class="auth_button" id="finished" type="button" disabled="disabled">인증하기</button>
						<input type='hidden' id='phone_check' value='false' />
						<div id="certify" style="display: inline-block"></div> <br> 
						<input type="checkbox"> SMS수신 여부 <span class="sub">도서관련 알림 및 행사 안내를 받으실 수 있습니다.</span><br>
						<div class="error" id="error__phoneNum"></div>
					</td>
				</tr>
				<tr>
					<td class="td1_3"><span class="star">*</span>주소</td>
					<td class="td2">
						<input type="text" class="box_normal" placeholder="우편번호" name="addresscode" id="addresscode" value='${MemberVO.addresscode}'>
						<button id="findAdd" onClick="sample6_execDaumPostcode()">우편번호찾기</button><br>
						<input type="text" class="box_normal" placeholder="주소" name="address" id="address" value='${MemberVO.address}'><br>
						<input type="text" class="box_normal" placeholder="상세주소" id="address_detail" name="addressdetail" value='${MemberVO.addressdetail}'>
						<input type="text" class="box_normal" placeholder="참고항목" name="addressnote" id="addressnote" value='${MemberVO.addressnote}'>
						<div class="error" id="error__address"></div>
					</td>
				</tr>
				<tr>
					<td class="td1_2"><span class="star">*</span>이메일</td>
					<td class="td2">
						<input type="text" class="box_normal" name="email1" id="email1" value='${MemberVO.email1}'>@
						<input type="text" id="email2" class="box_normal" name="email2"  value='${MemberVO.email2}'> 
						<select class="info_select">
							<option>-직접입력-</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="yahoo.co.kr">yahoo.co.kr</option>
						</select>
						<div class="error" id="error__email"></div>
						<br> 
					<input type="checkbox"> EMAIL 수신여부</td>
				</tr>
			</table>
			<div id="complete">
				<button class="confirm__button" id="signup__button" type="submit">
					수정하기</button>
			</div>
		</form>
		<a href='/'><button id="c2">취소</button></a>
      </div>
    </div>

<%@include file="../includes/footer2.jsp"%>