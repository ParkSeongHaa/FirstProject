<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header2.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/get.css">
<script src="/resources/js/get.js"></script>
<script type="text/javascript"></script>
<script>
$(function() {
	const operForm = $("#operForm");
	$("#list_btn").on("click", function(e) {	//리스트로 돌아가기
		operForm.find("#bno").remove();
		operForm.attr("action","/board/list");
		operForm.submit();
	});
	
	$("#modify_btn").on("click", function(e) {	//게시글 수정 및 삭제
		operForm.attr("action","/board/modify").submit();
	});
	
	$("#addReplyBtn").on("click",function(){	//댓글작성
		$("#reply").val("");
		$("#modalModBtn").hide();
		$("#modalRegisterBtn").show();
		$("#modalCloseBtn").show();
		$(".modal").modal("show");
	});
	
	$("#modalCloseBtn").on("click",function(){	//댓글작성 취소
		$(".modal").modal("hide");
	});
	
	$("#modalRegisterBtn").on("click",function(){	//댓글등록
		let reply_data = $("#reply").val();
		let replyer_data = $("#replyer").val();
		let bno_data = $("#bno").val();
		const reply = {reply:reply_data , replyer:replyer_data , bno:bno_data};
		ReplyService.add(reply,function(result){
			alert("댓글작성완료");
			$(".modal").modal("hide");
			getReplyListWithPaging(pageNum);
		},function(error){
			alert(error);
		});
	});
	
	//reply list with paging
	let pageNum = 1;
	let replyPageFooter = $(".panel-footer");
	getReplyListWithPaging(pageNum);
	
	function getReplyListWithPaging(pageNum) {
		ReplyService.getListWithPaging({bno:'<c:out value="${list.bno}"/>',page:pageNum},function(replyCnt,list){
			console.log("list : " + list);
			showReplyList(list);
			showReplyPaging(replyCnt);
		},
		function(error) {
			alert(error);
		});
	}
	
	
	getReplyList();
	function getReplyList(){
		ReplyService.getList(
			{bno:'<c:out value="${list.bno}"/>'},
			function(list){
				showReplyList(list);
			},
			function (error){
				alert(error);
			});
	}
	
	function showReplyList(list){ //for문으로 댓글 출력
		let str = "";
		let replyUL = $(".reply");
		if(list == null || list.length ==0) {
			replyUL.html(str);
			return;
		}
		for(var i=0; i<list.length; i++) {
			str +="<li>";
			str +="  <div>";
			str +="    <div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
			str +="      <small class='pull-right text-muted'>"+ReplyService.displayTime(list[i].regdate)+"</small>"; 
			str +="    </div>";
			str +="    <div data-rno='"+list[i].rno + "' data-replyer='" + list[i].replyer + "'>";
			str +="     <strong id='modify' class='primary-font'>"+list[i].reply+"</strong>";
			if("${auth.admin}" == 1){
				str +="    <button id='remove' type='button' class='close' data-rno='" + list[i].rno+"'>";
				str +="      <span>　　x</span></button>";
			}
			if("${auth.userid}"===list[i].replyer){
				str +="    <button id='mod' type='button' class='close' data-rno='" + list[i].rno + "'>";
				str +="      <span>수정</span></button>";
			}
			str +="   </div>";
			str +="  </div>";
			str +=" </li>";
		}
		replyUL.html(str);
	}
	
 	$(".reply").on("click", "#modify", function(){ //리플내용 클릭시 모달 출력
 		let replyer = $(this).parent().closest('div').data("replyer");
 		let rno = $(this).parent().closest('div').data("rno");
 		let auth = "${auth.userid}";
 		let admin = "${auth.admin}";
 		if(auth !== replyer || admin!= 1) {
			return;
		}  
		ReplyService.get(rno,function(reply){
			$("#reply").val(reply.reply);
			$("#replyer").val(reply.replyer);
			$(".modal").data("rno",reply.rno);
			$("#modalModBtn").show();
			$("#modalRegisterBtn").hide();
			$(".modal").modal("show");
		});		
		openModal();
	}) ;
 	
 	
	$("#modalModBtn").on("click",function(e){ // 모달에서 mod 클릭시 수정
		let reply = {reply : $("#reply").val(),
				rno:$(".modal").data("rno")
		};
		ReplyService.update(reply,
			function(result){
			/* alert(result);  */   // result == "success"
 			alert("댓글수정완료");
			$(".modal").modal("hide")
			/* getReplyList(); */
			getReplyListWithPaging(pageNum);	// 작성된 페이지로
		}, 
		function(error){
			alert(error);
		});
	});
	
	 $(".reply").on("click","#mod",function(e){ // 수정버튼으로 수정
		let replyer = $(this).parent().closest('div').data("replyer");
 		let rno = $(this).parent().closest('div').data("rno");
 		let auth = "${auth.userid}";
 		let admin = "${auth.admin}";
 		 if(auth !== replyer || admin!= 1) {
				return;
			}   
		ReplyService.get(rno,function(reply){
			$("#reply").val(reply.reply);
			$("#replyer").val(reply.replyer);
			$(".modal").data("rno",reply.rno);
			$("#modalModBtn").show();
			$("#modalRegisterBtn").hide();
			$(".modal").modal("show");
		});		
		openModal();
		ReplyService.update(reply,
			function(result){
			/* alert(result);  */   // result == "success"
 			alert("댓글수정완료");
 			getReplyListWithPaging(pageNum);		// 작성된 페이지로
		}, 
		function(error){
			alert(error);
		});
	}); 
	
	$(".reply").on("click", "#remove", function(){ //댓글삭제
		let rno = $(this).parent().closest('div').data("rno");
		/* alert('remove '+rno); */
		ReplyService.remove(rno,
			function(result){
			/* alert(result);  */   // result == "success"
 			alert("댓글삭제완료");
			/* getReplyList(); */
			getReplyListWithPaging(pageNum);
		},
		function(error){
			alert(error);
		});
	});
	
	
	
	function showReplyPaging(replyCnt){
		let endNum = Math.ceil(pageNum / 10.0) *10;
		let startNum = endNum-9;
		let prev = startNum !=1;
		let next = false;
		let str = "";
		if(endNum * 10 >= replyCnt) {
			endNum = Math.ceil(replyCnt/10.0);
		}
		if(endNum * 10 < replyCnt) {
			next = true;
		}
		str += "<ul class='pagination'>";
		if(prev) {
			str += "<li class='paginate_button'><a href='"+(startNum-1)+"'Previous</a></li>";
		}
		for(let i=startNum; i<=endNum; i++) {
			let active = pageNum == i? "active_list":"";
			str += "<li class='paginate_button "+active+"'><a href='"+i+"' class='page_Color'>"+i+"</a></li>"
		}
		if(next){
			str+="<li class='paginate_button'><a href='"+(endNum + 1) + "'>Next</a></li>";
		}
		str += "</ul></div>";
		console.log(str);
		replyPageFooter.html(str);
	};
	
		replyPageFooter.on("click","li a",function(e){
			e.preventDefault();
			console.log("page click");
			let targetPageNum = $(this).attr("href");
			console.log("targetPageNum: " + targetPageNum);
			pageNum = targetPageNum;
			getReplyListWithPaging(pageNum);
		});
	
		function showImage(fileCallPath){ //첨부파일 미리보기
			$(".bigPictureWrapper").css("display","flex").show();
			$(".bigPicture").html("<img src='/display?filename="+fileCallPath+"'>").animate({width:'100%',top:'0'},600);
		}
		
		
		$(".uploadResult").on("click","li",function(e){ //미리보기 클릭시 이동
			console.log("view image");
			let liObj = $(this);
			let path = encodeURIComponent(liObj.data("path") + "\\" + liObj.data("uuid")+"_"+liObj.data("filename"));
			if(liObj.data("type")){
				showImage(path);
			} else{
				if(path.toLowerCase().endsWith('pdf')){
					//new window
					window.open("/pdfviewer?filename="+path);
				} else{
					//download
					self.location = "/downloadFile?filename="+path;
				}
			}
		});
		$(".bigPictureWrapper").on("click",function(e){
			$(".bigPictureWrapper").hide();
			$(".bigPicture").css("top","15%");
		})
		

		
		pageColor()
		getAttachList()
		
		
		
});  //end ready

function pageColor(){  //숫자 페이징 색
	$(".page_Color").eq(0).css("font-size","30px");
	$(".page_Color").eq(0).css("font-weight","bold");
};
function getAttachList(){  //첨부파일 표시
	let bno = $("#bno").val();
	$.getJSON("/board/getAttachList/"+bno,function(attachList){
		console.log(attachList);
		let str = "";
		$(attachList).each(function(i,obj){
			if(obj.filetype){
				let fileCallPath = encodeURIComponent(obj.uploadpath+"\\s_"+obj.uuid+"_"+obj.filename);
				str += "<li data-path='"+obj.uploadpath+"'";
				str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.filetype+"'>";
				str += "  <div>";
				str += "   <span> "+obj.filename+"</span>"
				str += "   <img src='/display?filename="+fileCallPath+"'>";
				str += "  </div>";
				str += " </li>"
			} else{
				str += "<li data-path='"+obj.uploadpath+"'";
				str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.filetype+"'>";
				str += "  <div>";
				str += "   <span> "+obj.filename+"</span>"
				str += "   <img src='/resources/images/attach.png'>";
				str += "  </div>";
				str += " </li>"
			}
		 });
		$(".uploadResult ul").html(str);
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
		<div class="post-container">
  			<h2 class="post-title"><c:out value="${list.title}" /></h2>
  			<p class="post-writer">작성자: <c:out value="${list.writer}" /> 　　　작성일: <fmt:formatDate value="${list.updatedate}" pattern="yyyy.MM.dd HH:mm" /></p>
  			<p class="post-content"><c:out value="${list.content}" /></p>
		</div>
	
	<div class="article-bottom" style="margin:0 auto; width:1100px; height:200px;">
		<div id="file_title">
			<p><b>첨부파일</b></p>
		</div>
		<div id="file_list">
			<div class="uploadResult">
				<ul></ul>
			</div>
		</div>
	</div>
	
	<div id="under_container">
		<div id="read_button_box">
			<button class="read_button" id="list_btn">목록</button>
			<c:if test="${auth.userid eq list.writer || auth.admin eq 1}">		<!--  작성자는 수정 및 삭제 가능 -->
				<button class="read_button" id='modify_btn'>수정 및 삭제</button>
			</c:if>
		</div>
		<div class="read_reply">
			<c:if test="${not empty auth}">
				<button id='addReplyBtn' class='btn btn-primary btn-xs puu-right' style="height:44px;">댓글 작성</button>
			</c:if>
			<form id='operForm' action="/board/modify" method="get">
				<input type='hidden' id='bno' name='bno' value='<c:out value="${list.bno}"/>'>
				<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
				<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
				<input type='hidden' name='type' value='<c:out value="${criteria.type}"/>'>
				<input type='hidden' name='keyword' value='<c:out value="${criteria.keyword}"/>'>
			</form>
		</div><br><br><br>
		<div id="reply_box">
			<div>
				<h4>댓글 목록</h4>
			</div>
			<div class="reply_list">
				<ul class="reply">
				</ul>
				<div class="panel-footer">
				</div>
			</div>
		</div>
	</div>

<!-- Modal -->
<div class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">REPLY</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label>
					<input class="form-control" id="reply" name="reply">
				</div>
				<div class="form-group">
					<label>Replyer</label>
					<input class="form-control" id="replyer" name="replyer" value="${auth.userid}" readonly="readonly">
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn-warning">Modify</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
				<button id="modalCloseBtn" type="button" class="btn btn-info">close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<div class="bigPictureWrapper">
	<div class="bigPicture"></div>
</div>
	</div>
</div>








<%@include file="../includes/footer2.jsp" %>