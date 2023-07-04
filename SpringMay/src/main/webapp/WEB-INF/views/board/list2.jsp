<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header2.jsp" %>
<link rel="stylesheet" href="/resources/css/list.css">

<script type="text/javascript"></script>
<script>
	$(function(){
		$(".active_list").css('font-size','25px');
		$(".active_list").css('font-weight','bold');
		
		let searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색 종류를 선택하세요");
				return false;
			}
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 검색하세요");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			searchForm.submit();
		});
		
		$(".write_btn").on("click",function(){  //글쓰기 버튼 등록
			self.location = "/board/register";
		});
		
		let result = '<c:out value="${result}"/>'; // 글상태변화 알람
		if(result == "modify") {
			result = "글이 수정되었습니다."
			alert(result);
		} else if(result =="remove"){
			result ="글이 삭제되었습니다.";
			alert(result);
		} else if(result !=""){
			result +="번 글이 등록되었습니다.";
			alert(result);
		}
		
		$(".a").on("click",function(e){  // 글 제목 클릭시 해당 게시글로 이동
			e.preventDefault()
			let form = $("<form></form>");
			let type = $("select[name=type]").val();
			let keyword = $("input[name=keyword]").val();
			form.attr("method","get");
			form.attr("action","/board/get");
			form.append("<input type='hidden' name='bno' value='"+$(this).attr('href')+"'>");
			form.append("<input type='hidden' name='pageNum' value='"+<c:out value="${pageDTO.criteria.pageNum}"/>+"'>");
			form.append("<input type='hidden' name='amount' value='"+<c:out value="${pageDTO.criteria.amount}"/>+"'>");
			form.append("<input type='hidden' name='type' value='" + type + "'>");
			form.append("<input type='hidden' name='keyword' value='" + keyword + "'>");
			form.appendTo('body');
			form.submit(); 
		}) 

		$(".paginate_button a").on("click",function(e){ // 하단 페이징 이동 1~10
			
			e.preventDefault();
		let form = $('<form></form>');
		let type = $('select[name=type]').val();
		let keyword = $('input[name=keyword]').val();
		form.attr("method","get");
		form.attr("action","/board/list");
		form.append("<input type='hidden' name='pageNum' value='" + $(this).attr("href") + "'>");
		form.append("<input type='hidden' name='amount' value='" + <c:out value="${pageDTO.criteria.amount}"/>+"'>");
		form.append("<input type='hidden' name='type' value='" + type + "'>");
		form.append("<input type='hidden' name='keyword' value='" + keyword + "'");
		form.appendTo('body');
		form.submit();
		$(this).css('font-size','25px');
		$(this).css('font-weight','bold');
		})
		
	let list = new Array();
	<c:forEach items="${list}" var="board">			
		list.push(<c:out value="${board.bno}" />);
	</c:forEach>
	if (list.length == 0) {
		return;
	}
	$.getJSON("/replies/cnt",{list:list},function(data){		//댓글수 표시
		let keys = Object.keys(data);
		$(keys).each(function(i,bno){
			let replyCnt = data[bno];
			let text = $("span[name="+bno+"]").text().trim() + "[" + replyCnt + "]";
			$("span[name="+bno+"]").css("color","grey")
			if(replyCnt != 0) {
				$("span[name="+bno+"]").text(text);
			}
		});
	})	;
		
	getAttachListOnList()				//이미지 미리보기
	}) //end ready
	
function getAttachListOnList(){
		let list = new Array();
		<c:forEach items="${list}" var="board">
			list.push(<c:out value="${board.bno}" />);
		</c:forEach>
		$.getJSON("/board/getAttachListOnList",{list:list},function(data){
		console.log(data)
		let html="";
		let keys=Object.keys(data).sort((a,b) => Number(b)-Number(a));
		$(keys).each(function(i,bno){
			let attach = data[bno];
			console.log(bno);
			if(attach[0] != null) {
				if(attach[0].filetype){
					let fileCallPath = encodeURIComponent(attach[0].uploadpath+"\\s_"+attach[0].uuid+"_"+attach[0].filename);
					html = "<img src='/display?filename="+fileCallPath+"'>";
				} else {
					html = "<img src='/resources/images/attach.png' style='width:100px; height:60px;'>";	//이미지가 아니면 클립표시
				}
				$("#"+bno).html(html);
			}
		});
	});	
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
			<h1>게시판</h1>
		</div>
		<div class="table-container">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>첨부파일</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">
						<tr>
							<td>${list.bno}</td>
							<td>
							<a class="a" href='<c:out value="${list.bno}"/>'>
							<c:out value="${list.title}" /></a>
							<span id="commentCount" name='<c:out value="${list.bno}"/>'></span>
							</td>
							<td><c:out value="${list.writer}" /></td>
							<td id='<c:out value="${list.bno}"/>'></td>
							<td><fmt:formatDate value="${list.updatedate}" pattern="yyyy.MM.dd HH:mm" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div class="board_page">
			<ul class="pagination">
				<c:if test="${pageDTO.prev}">
					<li class="paginate_button previous">
					<a href="${pageDTO.startPage-1}">Prev</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
					<li
						class="paginate_button ${pageDTO.criteria.pageNum==num ? 'active_list' :'' }">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>
				<c:if test="${pageDTO.next}">
					<li class="paginate_button next"><a
						href="${pageDTO.endPage+1}">Next</a></li>
				</c:if>
			</ul>
		</div>
		<br>
		<div class="searchForm">
			<form action="/board/list" id="searchForm">
				<select name="type" class="select-style">
					<option value="" <c:out value="${pageDTO.criteria.type == null ? 'selected' : ''}"/>>-선택-</option>
					<option value="T" <c:out value="${pageDTO.criteria.type eq 'T' ? 'selected' : ''}"/>>제목</option>
					<option value="C" <c:out value="${pageDTO.criteria.type eq 'C' ? 'selected' : ''}"/>>내용</option>
					<option value="W" <c:out value="${pageDTO.criteria.type eq 'W' ? 'selected' : ''}"/>>작성자</option>
					<option value="TC" <c:out value="${pageDTO.criteria.type eq 'TC' ? 'selected' : ''}"/>>제목+내용</option>
					<option value="TW" <c:out value="${pageDTO.criteria.type eq 'TW' ? 'selected' : ''}"/>>제목+작성자</option>
					<option value="TWC" <c:out value="${pageDTO.criteria.type eq 'TWC' ? 'selected' : ''}"/>>제목+내용+작성자</option>
				</select>
				<input type="text" class="select-style" name="keyword" value="<c:out value="${pageDTO.criteria.keyword}"/>"/>
				<input type="hidden" name="pageNum" value="<c:out value="${pageDTO.criteria.pageNum}"/>"/>
				<input type="hidden" name="amount" value="<c:out value="${pageDTO.criteria.amount}"/>"/>
				<button class="button" style="cursor:pointer;">검색</button>
			</form>
		</div>
		<div id="write_box">
			<button class="write_btn" id="write_btn">글쓰기</button>
		</div>
	</div>
</div>












<%@include file="../includes/footer2.jsp" %>