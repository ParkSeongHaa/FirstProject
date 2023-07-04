<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header2.jsp" %>
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
		var pageNumTag = $("input[name='pageNum']").clone();
		var amountTag = $("input[name='amoung']").clone();
		formObj.empty();
		formObj.attr("action","/board/list").attr("method","get");
		formObj.append(pageNumTag);
		formObj.append(amountTag);
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

<style>
/* 게시글 컨테이너 스타일 */
  .post-container {
    width:1400px;
    height:350px;
    border: 1px solid #ccc;
    padding: 10px;
    margin:10px auto;
  }

  /* 제목 스타일 */
  .post-title {
  	width:1360px;
    font-size: 20px;
    font-weight: bold;
    padding: 10px;
    margin-bottom: 10px;
    border-bottom: 1px solid #ccc;
  }

  /* 작성자 스타일 */
  .post-writer {
  	width:1360px;
    font-style: italic;
    font-size:14px;
    color: #666;
    padding: 10px;
    margin-bottom: 10px;
    margin-top:-15px;
    border-bottom: 1px solid #ccc;
  }

  /* 내용 스타일 */
  .post-content {
 	width:1360px;
 	height:200px;
    line-height: 1.5;
    padding: 10px;
    border: 1px solid #ccc;
    }
    
    .read_button {
  		background-color: #4caf50;
 		 color: white;
 		 border: none;
 		 padding: 10px 20px;
 		 border-radius: 4px;
 		 cursor: pointer;
 		 font-size: 16px;
 		 margin-right: 10px;
 		 float:left;
		}

	.read_button:hover {
	  background-color: #45a049;
	}
	#btn_box{
	width:1400px;
	height:50px;
	margin:0 auto;
	}
	.uploadResult > ul > li{
    float:left;
    margin-right:10px;
}
.uploadResult > ul > li > div > img{
	width:150px;
	height:100px;
}
.article-bottom{
width:1400px;
height:250px;
margin:0 auto;
}
</style>



<form action="/board/modify" method="post">
	<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
<div class="post-container">
   <input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
   <input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
  <input type="text"  name="title" class="post-title" value= '<c:out value="${list.title}" />' >
  <p class="post-writer">작성자: <c:out value="${list.writer}" /> 　　　작성일: <fmt:formatDate value="${list.updatedate}" pattern="yyyy.MM.dd HH:mm" /></p>
  <input type="text" name="content" class="post-content" value= '<c:out value="${list.content}" />'>
  <input type="hidden" name="bno" value= <c:out value="${list.bno }"/> >
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
		<button type="submit" data-oper='modify' class="read_button" >수정완료</button>
		<button type="submit" data-oper='remove' class="read_button" >삭제</button>
		<button type="submit" data-oper="list" class="read_button">목록</button>
		</div>
</form>
<%@include file="../includes/footer2.jsp" %>