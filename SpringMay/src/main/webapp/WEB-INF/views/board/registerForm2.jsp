<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header2.jsp"%>
<script src="/resources/js/register.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="/resources/css/register.css">
<script>
	var ckeditor_config = {
		enterMode : CKEDITOR.ENTER_BR.CKEDITOR,
		shiftEnterMode : CKEDITOR.ENTER_P,
		filebrowserUploadUrl : ''
	}
	
</script>
<div id="header3">
	<div id="header3_pic">
		<div id="header3_seleted_menu">
			<h1>게시판</h1>
		</div>
		<div id="header3_seleted_menu_bar">
			<img src="/resources/images/home.png"> > 게시판
		</div>
	</div>
	<div id="header3_bottom_bar"></div>
</div>
<div id="board">
	<div id="side_menu">
		<ul id="side_ul">
			<li>공지사항</li>
			<li><a href='/board/list'>게시판</a></li>
		</ul>
	</div>
	<div id="main_board">
		<div id="main_selected_menu">
			<h1>글쓰기</h1>
		</div>
		<form class="register_form" method="post" action="/board/register">
			<div id="register_wrap">
				<div id="title_box">
					<div id="title" class="register_float register_padding">제목</div>
					<div id="title_input" class="register_float">
						<input type="text" id="title_write" name="title">
					</div>
				</div>
				<div id="mem_date_box">
					<div id="member" class="register_float register_padding">작성자
					</div>
					<div id="member_input" class="register_float">
						<input type="text" id="member_write" value="${auth.userid}"
							readonly="readonly" name="writer" class='fixedAuth'>
					</div>
					<div id="date" class="register_float register_padding">작성일</div>
					<div id="date_input" class="register_float" ></div>
				</div>
				<div id="number_box">
					<div id="number" class="register_float register_padding">연락처
					</div>
					<div id="number_input" class="register_float">
						<input type="text" id="number_write" value="${auth.totalphone}"  class='fixedAuth'>
					</div>
				</div>
				<div id="text_box">
					<textarea id="board_textarea" cols="30" rows="10" name="content" required="required"></textarea>
				</div>
				<div class="article-bottom">
					<div class="field1 get-th field-style">
						<label><b>첨부파일</b></label>
					</div>
					<div class="field2 get-td">
						<input type="file" name="uploadFile" id="uploadFile" class="file-input" multiple />
					</div>
					<div class="uploadResult">
						<ul></ul>
					</div>
				</div>
				<div id="btn_box">
					<button type="submit" class='registerPage_btn' id='register'>저장하기</button>
					<a href="/board/list"><button class='registerPage_btn'>목록으로</button></a>
				</div>
			</div>
		</form>
	</div>
</div>

<script>
	CKEDITOR.replace("board_textarea", ckeditor_config)
</script>
<%@include file="../includes/footer2.jsp"%>
