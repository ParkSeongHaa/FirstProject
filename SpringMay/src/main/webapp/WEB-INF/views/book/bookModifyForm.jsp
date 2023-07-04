<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header2.jsp"%>
<link rel="stylesheet" href="/resources/css/bookModifyForm.css">
<script>
  	$(function(){
  		$("#booktitle").focus();
  		var formObj = $('form');
  		
  		$('button').on("click",function(e){
  			e.preventDefault();
  			var operation = $(this).data("oper");
  			console.log(operation);
  		if(operation === 'list'){												//목록으로
  			let pageNumTag = $("input[name='pageNum']").clone();
  			let amountTag = $("input[name='amoung']").clone();
  			let typeTag = $("input[name='type']").clone();
  			let keywordTag = $("input[name='keywordTag']").clone();
  			formObj.empty();
  			formObj.attr("action","/book/bookModify").attr("method","get");
  			formObj.append(pageNumTag);
  			formObj.append(amountTag);
  			formObj.append(typeTag);
  			formObj.append(keywordTag);
  		} else if(operation === 'modify'){										//수정하기
  			let str = "";
  			let liObj = $(".bookImage");
  			str += "<input type='hidden' name='attachList.filename' value ='"+liObj.data("filename")+"'>"; 
			str += "<input type='hidden' name='attachList.uuid' value ='"+liObj.data("uuid")+"'>"; 
			str += "<input type='hidden' name='attachList.uploadpath' value ='"+liObj.data("path")+"'>"; 
			str += "<input type='hidden' name='attachList.filetype' value ='"+liObj.data("type")+"'>"; 
  			formObj.append(str).submit();
  		}
  		formObj.submit();
  	});

  		let booknumber = '<c:out value="${list.booknumber}"/>';				//등록되어있는 이미지 불러오기
  		$.getJSON("/book/getAttach/"+booknumber,function(attach){
  			console.log(attach);
  			console.log("이미지 불러오기");
  			let str="";
  			let fileCallPath = encodeURIComponent(attach.uploadpath+"\\s_"+attach.uuid+"_"+attach.filename);
			str +="<div data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"''";
			str +=" data-type='"+attach.filetype+"' class='bookImage'>";
			str +=" <div>";
			str +="  <span>" + attach.filename+"</span>";
			str +="   <button type='button' data-file=\'"+fileCallPath+"\' data-type='image'"
			str +="      class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str +="     <img src='/display?filename="+fileCallPath+"' style='width:200px; height:250px;'/>";
			str +="    </div>";
			str +=" </div>";
  			$(".uploadResult").html(str);
  		});
  		
		let regex = new RegExp("^(?!.*\.(jpeg|jpg|png|gif|svg)$).*", "i");  //파일형식확인
		let maxSize = 5 * 1024 * 1024;
		function checkExtension(filename, fileSize) {
		  if (fileSize >= maxSize) {
		    alert("파일 용량 초과");
		    return false;
		  }
		  if (regex.test(filename)) {
		    alert("JPEG, JPG, PNG, GIF, SVG 파일만 업로드 가능합니다.");
		    return false;
		  }
		  return true;
		}
		
		$("#uploadFile").on("change",function(e){                   //파일업로드
			console.log("uploadFile")
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
					showUploadResult(result);
				}
			});
		});

		
		function showUploadResult(result){                   //이미지 화면표시
			if(!result || result.length == 0) {return;}
			let uploadDiv = $(".uploadResult");
			let str="";
			$(result).each(function(i,obj){
				if(obj.image) {
					let fileCallPath = encodeURIComponent(obj.uploadpath+"\\s_"+obj.uuid+"_"+obj.filename);
					str += "<div data-path='"+obj.uploadpath+"'";
					str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"' class='bookImage'>";
					str += "  <div>";
					str += "   <span> "+obj.filename+"</span>"
					/* str += "   <button type='hidden' data-file=\'"+fileCallPath+"\'"; 
					str += "    data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"; */
					str += "   <button";
					str += "     class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					
					str += "   <img src='/display?filename="+fileCallPath+"' style='width:200px; height:250px;'>";
					str += "  </div>";
					str += " </div>"
				}
			});
			uploadDiv.html(str);
		};
		
		$(".uploadResult").on("click","button",function(e){	        //첨부파일 삭제
			console.log("delete file");
			if(confirm("Remove this file?")){
				$(".bookImage").remove();
			}
		})
	
			
		 /* $("#modify_book_finish").on("click",function(e){ 	//수정하기는 상단에서 처리
			e.preventDefault();
			if(registerCheck()){
				let formObj = $(".register_form");
				let str= "";
				var uploaeResult = $(".bookImage")
					str += "<input type='hidden' name='attachList.filename' value='"+uploaeResult.data("filename")+"'>";
					str += "<input type='hidden' name='attachList.uuid' value='"+uploaeResult.data("uuid")+"'>";
					str += "<input type='hidden' name='attachList.uploadpath' value='"+uploaeResult.data("path")+"'>";
					str += "<input type='hidden' name='attachList.filetype' value='"+uploaeResult.data("type")+"'>";
				formObj.append(str).submit();
			}
		});  */ 

		
	}); //end ready
	
	function registerCheck(){
		const title = $("#booktitle");
		const writer = $("#bookwriter");
		const company = $("#bookcompany");
		const year = $("#bookyear");
		if(title === "") {
			alert("제목을 입력하세요");
			return false;
		}
		if(writer === "") {
			alert("저자를 입력하세요");
			return false;
		}
		if(company === "") {
			alert("출판사를 입력하세요");
			return false;
		}
		if(year === "") {
			alert("발행년도를 입력하세요");
			return false;
		}
		return true;
	}
	
</script>

	<form action="/book/bookModifyForm" method="post" class="register_form"r>
        <div id="header3">
            <div id="header3_pic">
                <div id="header3_seleted_menu">
                    <h1>도서관리</h1>
                </div>
                <div id="header3_seleted_menu_bar">
                    <img src="/resources/images/home.png"> > 도서관리
                </div>
            </div>
            <div id="header3_bottom_bar">
                
            </div>
        </div>
        <div id="board">
            <div id="side_menu">
                <ul id="side_ul">
                    <li><a href="/book/bookModify">도서관리</a></li>
                </ul>
            </div>
            <div id="main_board">
                <div id="main_selected_menu">
                    <h1>도서수정</h1>
                </div>
                <div id="register_bookImage">
					<div class="field1 get-th field-style">
						<label><b>첨부파일</b></label>
					</div>
					<div class="field2 get-td">
						<input type="file" name="uploadFile" id="uploadFile" class="file-input" multiple />
					</div>
					<div id="bookImage_show">

					</div>
					<div class="uploadResult">
					
					</div>
				</div>
                <table id="register_book_table">
                      <tr>
                        <td class="book_register_td1">제목</td>
                        <td>
                        	<input type="text" class="book_register_input" name="booktitle" id="booktitle" value= <c:out value="${list.booktitle}"/> >
                        </td>
                      </tr>
                      <tr>
                        <td class="book_register_td1">저자</td>
                        <td><input type="text" class="book_register_input" name="bookwriter" id="bookwriter" value= <c:out value="${list.bookwriter}"/>></td>
                      </tr>
                      <tr>
                        <td class="book_register_td1">출판사</td>
                        <td><input type="text" class="book_register_input" name="bookcompany" id="bookcompany" value= <c:out value="${list.bookcompany}"/>></td>
                      </tr>
                      <tr>
                        <td class="book_register_td1">발행년도</td>
                        <td><input type="text" class="book_register_input" name="bookyear" id="bookyear" maxlength="4" value= <c:out value="${list.bookyear}"/>></td>
                      </tr>
                      <tr>
                        <td class="book_register_td1">위치</td>
                        <td>
                        	<select name="booklocation" class="book_register_input">
                        		<option value='[남부] 종합자료실' <c:out value="${list.booklocation eq '[남부] 종합자료실' ? 'selected' : ''}"/> >[남부] 종합자료실</option>
                        		<option value='[남부] 보존서고1' <c:out value="${list.booklocation eq '[남부] 보존서고1' ? 'selected' : ''}"/> >[남부] 보존서고1</option>
                        		<option value='[남부] 보존서고2' <c:out value="${list.booklocation eq '[남부] 보존서고2' ? 'selected' : ''}"/> >[남부] 보존서고2</option>
                        		<option value='[남부] 보존서고3' <c:out value="${list.booklocation eq '[남부] 보존서고3' ? 'selected' : ''}"/> >[남부] 보존서고3</option>
                        		<option value='[남부] 어린이열람실' <c:out value="${list.booklocation eq '[남부] 어린이열람실' ? 'selected' : ''}"/> >[남부] 어린이열람실</option>
                        		<option value='[남부] 일반인문도서' <c:out value="${list.booklocation eq '[남부] 일반인문도서' ? 'selected' : ''}"/> >[남부] 일반인문도서</option>
                        	</select>
                        </td>
                      </tr>
                      <tr>
                        <td class="book_register_td1">즉시대출 가능여부</td>
                        <td>
                        	<select name="booklental" class="book_register_input">
                        		<option value='대출가능' <c:out value="${list.booklental eq '대출가능' ? 'selected' : ''}"/> >대출가능</option>
                        		<option value='대출불가능' <c:out value="${list.booklental eq '대출불가능' ? 'selected' : ''}"/>>대출불가능</option>
                        	</select>
                        </td>
                      </tr>
                  </table>
                  <div id="register_book_btn_box">
                    <button id="modify_book_finish" data-oper='modify' type="submit">수정</button>
                    <button id="modify_book_list" data-oper='list' type="submit">목록</button>
                  </div>
            </div>
        </div>
        <input type="hidden" name="booknumber" value= <c:out value="${list.booknumber}"/> >
   		<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
   		<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
   		<input type='hidden' name='type' value='<c:out value="${criteria.type}"/>'>
   		<input type='hidden' name='keyword' value='<c:out value="${criteria.keyword}"/>'>
	</form>
	
	
<%@include file="../includes/footer2.jsp"%>
