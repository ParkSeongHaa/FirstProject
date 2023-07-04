<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header2.jsp" %>
<link rel="stylesheet" href="/resources/css/modify.css">
<script type="text/javascript"></script>
<script>
$(function(){
	$(".post-content").focus();
	var formObj = $('form');
	
	$('button').on("click",function(e){
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation);
	if(operation === 'remove'){
		formObj.attr("action","/board/remove");
	} else if(operation === 'list'){
		let pageNumTag = $("input[name='pageNum']").clone();
		let amountTag = $("input[name='amoung']").clone();
		let typeTag = $("input[name='type']").clone();
		let keywordTag = $("input[name='keywordTag']").clone();
		formObj.empty();
		formObj.attr("action","/board/list").attr("method","get");
		formObj.append(pageNumTag);
		formObj.append(amountTag);
		formObj.append(typeTag);
		formObj.append(keywordTag);
	} else if(operation === 'modify'){
		let str = "";
		$('.uploadResult ul li').each(function(i,listItem){
			let liObj = $(listItem);
			str += "<input type='hidden' name='attachList["+i+"].filename' value ='"+liObj.data("filename")+"'>"; 
			str += "<input type='hidden' name='attachList["+i+"].uuid' value ='"+liObj.data("uuid")+"'>"; 
			str += "<input type='hidden' name='attachList["+i+"].uploadpath' value ='"+liObj.data("path")+"'>"; 
			str += "<input type='hidden' name='attachList["+i+"].filetype' value ='"+liObj.data("type")+"'>"; 
		});
		formObj.append(str).submit();
	}
	formObj.submit();
});
	
	let bno = '<c:out value="${list.bno}"/>';
	$.getJSON("/board/getAttachList/"+bno,function(attachList){
		console.log(attachList);
		let str="";
		$(attachList).each(function(i,attach){
			if(attach.filetype){
				let fileCallPath = encodeURIComponent(attach.uploadpath+"\\s_"+attach.uuid+"_"+attach.filename);
				str +="<li data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"''";
				str +=" data-type='"+attach.filetype+"'>";
				str +=" <div>";
				str +="  <span>" + attach.filename+"</span>";
				str +="   <button type='button' data-file=\'"+fileCallPath+"\' data-type='image'"
				str +="      class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str +="     <img src='/display?filename="+fileCallPath+"'/>";
				str +="    </div>";
				str +=" </li>";
			} else{
				var fileCallPath = encodeURIComponent(attach.uploadPath+"\\"+attach.uuid+" " + attach.fileName);
				str +="<li data-path='"+attach.uploadpath+"' data-uuid='" + attach.uuid+"'";
				str +="    data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'>";
				str +="  <div>";
				str +="    <span> " + attach.filename+"</span>";
				str +="    <button type='button' data-file=\'"+fileCallPath+"\' data-type='file'";
				str +="       class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str +="     <img src='/resources/images/attach.png'/>";
				str +="   </div>";
				str +="</li>";
			}
		});
		$(".uploadResult ul").html(str);
	});
	
	$(".uploadResult").on("click","button",function(e){
		console.log("delete file");
		if(confirm("Remove this file?")){
			let targetLi = $(this).closest("li");
			targetLi.remove();
		}
	})
	
	
	let regex = new RegExp("(.*)\.(exe|zip|alz)$");
	let maxSize = 5*1024*1024;
	
	function checkExtension(filename , fileSize){
		if(fileSize >= maxSize) {
			alert("파일 용량 초과");
			return false;
		}
		if(regex.test(filename)){
			alert("해당 확장자의 파일은 업로드가 불가능합니다.");
			return false;
		}
		return true;
	}
	
	
	$("#uploadFile").on("change",function(e){
		let formData = new FormData();
		let inputFile = $("#uploadFile");
		let files = inputFile[0].files;
		for(let i=0; i<files.length; i++){
			if(!checkExtension(files[i].name,files[i].size)){
				return false;
			}
			formData.append("uploadFile",files[i]);
		}
		$.ajax({
			type:'post',
			url:'/uploadFileAjax',
			processData:false,
			contentType:false,
			data:formData,
			success:function(result){
				console.log(result);
				showUploadResult(result);
			}
		});
	});
	
	function showUploadResult(result){
		if(!result || result.length == 0) {return;}
		let uploadUL = $(".uploadResult ul");
		let str="";
		$(result).each(function(i,obj){
			if(obj.image) {
				let fileCallPath = encodeURIComponent(obj.uploadpath+"\\s_"+obj.uuid+"_"+obj.filename);
				str += "<li data-path='"+obj.uploadpath+"'";
				str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'>";
				str += "  <div>";
				str += "   <span> "+obj.filename+"</span>"
				str += "   <button type='hidden' data-file=\'"+fileCallPath+"\'"; 
				str += "    data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "   <img src='/display?filename="+fileCallPath+"'>";
				str += "  </div>";
				str += " </li>"
			} else{
				let fileCallPath = encodeURIComponent(obj.uploadpath+"\\"+obj.uuid+"_"+obj.filename);
				str += "<li data-path='"+obj.uploadpath+"'";
				str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'>";
				str += "  <div>";
				str += "   <span> "+obj.filename+"</span>"
				str += "   <button type='hidden' data-file=\'"+fileCallPath+"\'";   
				str += "    data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "   <img src='/resources/images/attach.png'/>";
				str += "  </div>";
				str += " </li>"
			}
		});
		uploadUL.append(str);
	};
	
}); //end ready
</script>

<div id="header3">
	<div id="header3_pic">
		<div id="header3_seleted_menu">
			<h1>게시판</h1>
		</div>
		<div id="header3_seleted_menu_bar">
			<img src="/resources/images/home.png"> > 평생교육 > 게시판
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
		<form action="/board/modify" method="post">
			<div class="post-container">
				<input type="hidden" name="bno" value= <c:out value="${list.bno }"/> >
   				<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
   				<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
   				<input type='hidden' name='type' value='<c:out value="${criteria.type}"/>'>
   				<input type='hidden' name='keyword' value='<c:out value="${criteria.keyword}"/>'>
  				<input type="text"  name="title" class="post-title" value= '<c:out value="${list.title}" />' >
  				<p class="post-writer">작성자: <c:out value="${list.writer}" /> 　　　작성일: <fmt:formatDate value="${list.updatedate}" pattern="yyyy.MM.dd HH:mm" /></p>
  				<input type="text" name="content" class="post-content" value= '<c:out value="${list.content}" />'>
  				
			</div>
			<div class="article-bottom">
				<div class="field1 get-th field-style" style="width:1100px; height:50px;">
					<label style="height:20px;display:block"><b>첨부파일</b></label>
					<div class="field2 get-td">
						<input type="file" name="uploadFile" id="uploadFile" class="file-input" multiple />
					</div>
				</div>
				<div class="uploadResult">
					<ul></ul>
				</div>
				</div>
			<div id="btn_box" style="width:1100px; float:left;">
				<button type="submit" data-oper='modify' class="read_button" >수정완료</button>
				<button type="submit" data-oper='remove' class="read_button" >삭제</button>
				<button type="submit" data-oper="list" class="read_button">목록</button>
			</div>
		</form>
	</div>
</div>

















<%@include file="../includes/footer2.jsp" %>