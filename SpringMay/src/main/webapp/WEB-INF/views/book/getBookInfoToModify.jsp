<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header2.jsp"%>
<link rel="stylesheet" href="/resources/css/bookInfoToModify.css">
<script>
	$(function(){
		getAttachList()
		const operForm = $("#operForm");
		$("#toGoBookList").on("click", function(e) {	//리스트로 돌아가기
			operForm.find("#booknumber").remove();
			operForm.attr("action","/book/bookModify");
			operForm.submit();
		});
		
		$("#book_modify").on("click", function(e) {	//게시글 수정 및 삭제
			operForm.attr("action","/book/bookModifyForm").submit();
		});
		
		$("#book_delete").on("click", function(e) {	//게시글 수정 및 삭제
			operForm.attr("action","/book/bookDelete").submit();
		});
		
	})
	
	function getAttachList(){  //첨부파일 표시
	let booknumber = $("#booknumber").val();
	$.getJSON("/book/getAttachList/"+booknumber,function(attachList){
		console.log(attachList);
		let str = "";
		$(attachList).each(function(i,obj){
			if(obj.filetype){
				let fileCallPath = encodeURIComponent(obj.uploadpath+"\\s_"+obj.uuid+"_"+obj.filename);
				str += "<img src='/display?filename="+fileCallPath+"'>";
			}
		 });
		$("#bookImage").html(str);
	});
}
	
</script>


<div id="header3">
	<div id="header3_pic">
		<div id="header3_seleted_menu">
			<h1>도서관리</h1>
		</div>
		<div id="header3_seleted_menu_bar">
			<img src="/resources/images/home.png"> > 도서관리
		</div>
	</div>
	<div id="header3_bottom_bar"></div>
</div>
<div id="board">
	<div id="side_menu">
		<ul id="side_ul">
			<li><a href="/book/bookModify">도서관리</a></li>
		</ul>
	</div>
	<div id="main_board">
		<div id="main_selected_menu">
			<h1>자료검색</h1>
		</div>
		<div id="bookInfoNotice">
			<b>도서의 상세내용</b>을 확인하세요
		</div>
		<div id="bookInfo">
			<div id="bookImage">
				
			</div>
			<div id="bookExplain">
				<h1><c:out value="${list.booktitle}" /></h1>
				<b>저자</b>   <c:out value="${list.bookwriter}" /> <br><br>
				<b>발행처</b> <c:out value="${list.bookcompany}" /> <br><br>
				<b>발행년도</b> <c:out value="${list.bookyear}" /> <br><br>
				<b>자료실</b>  <c:out value="${list.booklocation}" /> <br><br>
				<b>대출상태</b> <c:out value="${list.booklental}" />
			</div>
			<div id="bookInfoBtnBox">
				<button id="book_modify"        class="book_reserve_options">수정하기</button>
				<button id="book_delete" class="book_reserve_options">삭제하기</button>
				<button id="toGoBookList">목록으로</button>
			</div>
		</div>
	</div>
	<form id='operForm' action="/book/bookModify" method="get">
		<input type='hidden' id='booknumber' name='booknumber' value='<c:out value="${list.booknumber}"/>'>
		<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
		<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
		<input type='hidden' name='type' value='<c:out value="${criteria.type}"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${criteria.keyword}"/>'>
	</form>
	
	
</div>


<%@include file="../includes/footer2.jsp"%>