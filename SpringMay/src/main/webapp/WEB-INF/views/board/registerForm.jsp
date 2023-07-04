<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header2.jsp" %>

<script type="text/javascript">
$(function(){
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
					str += "   <img src='/resources/imgages/attach.png'/>";
					str += "  </div>";
					str += " </li>"
				}
			});
			uploadUL.append(str);
		};
		
		$(".uploadResult").on("click","li button",function(e){
			console.log("delete file");
			let targetFile = $(this).data("file");
			let type= $(this).data("type");
			let targetLi = $(this).parent().closest("li");
			let attach = {filename:targetFile, type:type};
			$.ajax({
				type:'delete',
				url: '/deleteFile',
				data:JSON.stringify(attach),
				contentType : "application/json; charset=utf-8",
				success:function(result) {
					alert(result);
					targetLi.remove();
				}
			});
		});
		
		$("button[type='submit']").on("click",function(e){
			e.preventDefault();
			let formObj = $(".register_form");
			let str= "";
			$(".uploadResult ul li").each(function(i , listItem){
				let liObj = $(listItem);
				console.log("--------------------");
				console.log(liObj.data("filename"));
				str += "<input type='hidden' name='attachList["+i+"].filename' value='"+liObj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+liObj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='"+liObj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+liObj.data("type")+"'>";
			});
			console.log(str);
			alert(str);
			formObj.append(str).submit();	
		});
		
		
		
		
});	
</script>
<style>
.wrapper_register {
  max-width: 500px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f7f7f7;
  border: 1px solid #ccc;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.register_head {
  text-align: center;
  margin-bottom: 20px;
}

.register_head h3 {
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.register_line {
  height: 1px;
  background-color: #ccc;
  margin-bottom: 20px;
}

.register_form {
  display: flex;
  flex-direction: column;
}

.register_title {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
}

.title_area {
  flex-grow: 1;
  padding: 10px;
  font-size: 18px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.title_area[readonly] {
  background-color: #eee;
  cursor: not-allowed;
}

.register_written {
  margin-bottom: 20px;
}

.written_area {
  width: 100%;
  height: 200px;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.register_submit {
  display: flex;
  justify-content: flex-end;
}

.register_submit_btn {
  padding: 10px 20px;
  font-size: 16px;
  color: #fff;
  background-color: #333;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-left: 10px;
}

.register_submit_btn[type="reset"] {
  background-color: #ccc;
}
.article-bottom{
width:1400px;
margin:0 auto;
}
</style>

<div class="wrapper_register">
	<div class="register_head">
		<h3>게시글 작성</h3>
	</div>
	<div class="register_line"></div>
	<div class="register_body">
		<form class="register_form" method="post" action="/board/register">
			<div class="register_title">
				<input class="title_area" maxlength="50" placeholder="제목" name="title" required="required"/>
				<input class="title_area" maxlength="50" readonly="readonly" name="writer" value="${auth.userid}"/>
			</div>
			<div class="register_written">
				<textarea type="text" class="written_area" placeholder="내용" name="content" required="required"></textarea>
			</div>
			<div class="register_submit">
				<button class="register_submit_btn" type="submit">작성</button>
				<button class="register_submit_btn" type="reset">취소</button>
			</div>
		</form>
	</div>
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





<%@include file="../includes/footer2.jsp" %>