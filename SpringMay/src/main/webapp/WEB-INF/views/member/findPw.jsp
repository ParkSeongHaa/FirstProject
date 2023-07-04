<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header2.jsp" %>
<link rel="stylesheet" href="/resources/css/findPw.css">

<script type="text/javascript">
$(function(){
	$("#fine_id_btn").on("click",function(e){
		e.preventDefault();
		if(isValid()) {
			$("form").submit();
		}
	});
	
	function isValid(){
		const id = $("#find_id").val()
		const name = $("#find_name").val()
		const birthday = $("#find_birthday").val()
		const phone1 = $("#phone1").val()
		const phone2 = $("#phone2").val()
		const phone3 = $("#phone3").val()
		
		if(id ===""){
			alert("아이디를 입력해주세요.");
			return false;
		}
		if(name === "") {
			alert("이름을 입력해주세요");
			return false;
		}
		if(birthday === "") {
			alert("생년월일을 입력해주세요");
			return false;
		}
		if(phone1 ===""){
			alert("휴대전화번호를 입력해주세요");
			return false;
		} else if(phone2 ===""){
			alert("휴대전화번호를 입력해주세요");
			return false;
		} else if(phone3 ===""){
			alert("휴대전화번호를 입력해주세요");
			return false;
		}
		
		return true;
	}
	
	let error = "${error}";
	console.log(error);
	if(error ==="") {
		return;
	}
	if(error==="nonuser"){
		alert("옳지않은 정보입니다.");
	} 

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
                <form action="/member/findPw" class="login_form" method="post">
					<div id="userData_input_box">
                    <table id="findId_table">
                    	<tr>
                    		<td>아이디<span class="star">*</span></td>
                    		<td>
                    			<input type="text" id="find_id" name="userid" placeholder="아이디를 입력하세요"  maxlength="20">
                    		</td>
                    	</tr>
                        <tr>
                            <td>이름<span class="star">*</span></td>
                            <td>
                                <input type="text" id="find_name" name="username" placeholder="이름을 입력하세요.">
                            </td>
                        </tr>
                        <tr>
                            <td>생년월일<span class="star">*</span></td>
                            <td>
                                <input type="text" id="find_birthday" name="birthday" placeholder="생년월일을 입력하세요"  maxlength="8">
                                예)19800101
                            </td>
                        </tr>
                        <tr>
                            <td>휴대전화<span class="star">*</span></td>
                            <td>
                                <input type="text" id="phone1" class="phoneNum" name="phone1"  maxlength="4"> -
                                <input type="text" id="phone2" class="phoneNum" name="phone2"  maxlength="4"> -
                                <input type="text" id="phone3" class="phoneNum" name="phone3"  maxlength="4">
                            </td>
                        </tr>
                    </table>
                    <div id="find_btn_box">
                        <button id="fine_id_btn">비밀번호 찾기</button>
                    </div>
                </div>
        		</form>
            </div>
        </div>



<%@include file="../includes/footer2.jsp" %>