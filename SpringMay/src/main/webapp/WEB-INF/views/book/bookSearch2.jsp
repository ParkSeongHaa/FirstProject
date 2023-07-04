<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header2.jsp"%>
<link rel="stylesheet" href="/resources/css/bookSearch.css">


<script>
	$(function(){
		getAttachListOnList()
		
		var keyword = "<c:out value='${pageDTO.criteria.keyword}'/>";
		var type = "<c:out value='${pageDTO.criteria.type}'/>";
		if(type == 'T'){						// 메인페이지에서 검색했을 경우 type에 맞게 keyword값이 들어감
			$("#book_title").val(keyword)
		} else if(type == 'W'){
			$("#book_writer").val(keyword)
		} else if(type == 'C'){
			$("#book_company").val(keyword)
		} else if(type =="L") {
			$("#book_location").val(keyword)
		}

		
		$("#book_search_reset").click(function(){ // 리셋 클릭시 검색옵션 초기화
			$("#book_title").val("");
			$(".search_options").val("");
			$(".search_options2").val("");
			$(".search_options2_1").val("");
		})
		
		$(".a").on("click",function(e){  // 글 제목 클릭시 해당 게시글로 이동;
			e.preventDefault()
			let form = $("<form></form>");
			/* let type = $("select[name=type]").val();				// 메인페이지에서 넘어올때 한번만 사용됨
			let keyword = $("input[name=keyword]").val();			// 메인페이지에서 넘어올때 한번만 사용됨 */
			form.attr("method","get");
			form.attr("action","/book/getBookInfo");
			form.append("<input type='hidden' name='booknumber' value='"+$(this).attr('href')+"'>");
			form.append("<input type='hidden' name='pageNum' value='"+<c:out value="${pageDTO.criteria.pageNum}"/>+"'>");
			form.append("<input type='hidden' name='amount' value='"+<c:out value="${pageDTO.criteria.amount}"/>+"'>");
			/* form.append("<input type='hidden' name='type' value='" + type + "'>");						//메인페이지에서 넘어올때 한번만 사용됨
			form.append("<input type='hidden' name='keyword' value='" + keyword + "'>");				//메인페이지에서 넘어올때 한번만 사용됨  */
			form.appendTo('body');
			form.submit(); 
		})

		
		$(".paginate_button a").on("click",function(e){ // 하단 페이징 이동 1~10
			$(".paginate_button a").css("font-size","30px");
			$(this).css("font-size","40px");
			e.preventDefault();
			let form = $('<form></form>');
			form.attr("method","get");
			form.attr("action","/book/bookSearch2");
			form.append("<input type='hidden' name='pageNum' value='" + $(this).attr("href") + "'>");
			form.append("<input type='hidden' name='amount' value='" + <c:out value="${pageDTO.criteria.amount}"/>+"'>");
			form.appendTo('body');
			form.submit();
			})

		
		 $("#book_search_btn").click(function(e) {				//옵션검색  , 그냥 body에서 폼으로 전송
			e.preventDefault();
		 	var form = $("#searchForm")
		 	var title = $("#book_title").val();
		 	var writer = $("#book_writer").val();
		 	var company = $("#book_company").val();
		 	var location = $("#book_location").val();
		 	var year1 = $("#book_year1").val();
		 	var year2 = $("#book_year2").val();	
		 	
		 	
		 	if(title == "" && writer == "" && company == "" && year1 == "" && year2 == "" && location == ""){
		 		form.prop("action","/book/bookSearch2")
		 		form.submit();
		 	} else {
		 		/* if(year1 =="") {					//발행년도 최소범위가 공백이면 0 처리
		 			$("#book_year1").val("0");
			 	}
			 	if(year2 =="") {					//발행년도 최대범위가 공백이면 3000처리
			 		$("#book_year2").val("3000");
			 	} */
		 		form.submit();
		 	}
		 	
		}) 
		
		
		
		
	})  //end ready
	
	function getAttachListOnList(){
		let list = new Array();
		<c:forEach items="${list}" var="book">
			list.push(<c:out value="${book.booknumber}" />);
		</c:forEach>
		$.getJSON("/book/getAttachListOnList",{list:list},function(data){
		console.log(data)		//data -> 책사진정보 리스트
		let html="";
		let keys=Object.keys(data).sort((a,b) => Number(b)-Number(a));
		$(keys).each(function(i,booknumber){
			let attach = data[booknumber];
			console.log(booknumber);
			if(attach[0] != null) {
				if(attach[0].filetype){
					let fileCallPath = encodeURIComponent(attach[0].uploadpath+"\\s_"+attach[0].uuid+"_"+attach[0].filename);
					html = "<img src='/display?filename="+fileCallPath+"'>";
				}
				$("#"+booknumber+" a").html(html);
			}
		});
	});	
}

</script>

<div id="header3">
	<div id="header3_pic">
		<div id="header3_seleted_menu">
			<h1>자료검색</h1>
		</div>
		<div id="header3_seleted_menu_bar">
			<img src="/resources/images/home.png"> > 자료검색 > 자료검색
		</div>
	</div>
	<div id="header3_bottom_bar"></div>
</div>
<div id="board">
	<div id="side_menu">
		<ul id="side_ul">
			<li><a href="/book/bookSearch2">자료검색</a></li>
		</ul>
	</div>
	<div id="main_board">
		<div id="main_selected_menu">
			<h1>자료검색</h1>
		</div>
		<form action="/book/getSpecificBookList" id="searchForm" method="get">
			<div id="book_search">
        		<input type="text" id="book_title" placeholder="도서 제목을 입력하세요" name="booktitle" value='<c:out value="${inputOptions.booktitle}"/>' >  <br>
            	<span class="search_option_name">저자</span><input type="text" id="book_writer" class="search_options" name="bookwriter" value='<c:out value="${inputOptions.bookwriter}"/>' >
            	<span class="search_option_name">발행처</span><input type="text" id="book_company" class="search_options" name="bookcompany" value='<c:out value="${inputOptions.bookcompany}"/>' ><br><br>
            	<span class="search_option_name">발행년도</span><input type="text" id="book_year1" class="search_options2" maxlength="4" name="bookyear1" value='<c:out value="${inputOptions.bookyear1}"/>' >　~　
            												 <input type="text" id="book_year2" class="search_options2_1" maxlength="4" name="bookyear2" value='<c:out value="${inputOptions.bookyear2}"/>' >
            	<span class="search_option_name">위치</span><input type="text" id="book_location" class="search_options" name="booklocation" value='<c:out value="${inputOptions.booklocation}"/>' >
        	</div>
			<div id="book_search_btn_box">
				<button id="book_search_btn">검색하기</button>
				<button id="book_search_reset" type="button">검색초기화</button>
			</div>
			<input type='hidden' name="criteria.pageNum" value='<c:out value="${pageDTO.criteria.pageNum}"/>'>
			<input type='hidden' name="criteria.amount" value='<c:out value="${pageDTO.criteria.amount}"/>'>
		</form>
	</div>
	
	<div id="book_search_result">
		<table>
			<c:forEach var="list" items="${list}">
				<tr>
					<td id='<c:out value="${list.booknumber}"/>'>
						<a class="a" href='<c:out value="${list.booknumber}"/>'>
						
						</a>
					</td>
					<td style='font-size:25px;'>
						<a class="a" href='<c:out value="${list.booknumber}"/>'><b>[도서] ${list.booktitle}</b></a><br>
							저자 : ${list.bookwriter}<br>
							발행처 : ${list.bookcompany}　 ${list.bookyear}<br>
							자료실 : ${list.booklocation}<br>
							대출가능여부 : ${list.booklental}
					</td>
				</tr>
			</c:forEach>
		</table>
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
	</div>
	
</div>


<%@include file="../includes/footer2.jsp"%>