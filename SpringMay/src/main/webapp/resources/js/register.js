$(function(){
	  var currentDate = new Date();  //현재날짜입력
      var year = currentDate.getFullYear();
      var month = ("0" + (currentDate.getMonth() + 1)).slice(-2);
      var day = ("0" + currentDate.getDate()).slice(-2);
      var formattedDate = year + "-" + month + "-" + day;
      $("#date_input").text(formattedDate);

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
		
		$("#uploadFile").on("change",function(e){			//파일첨부
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
					/*console.log(result);*/
					showUploadResult(result);
				}
			});
		});
		
		function showUploadResult(result){					//이미지 미리보기 및 이미지데이터 설정
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
		
		$(".uploadResult").on("click","li button",function(e){      //첨부파일 삭제
			e.preventDefault();
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
			if(registerCheck()){
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
				alert("등록완료!")
				formObj.append(str).submit();	
			}
		}); 
		
		$("a[href='/board/list']").on("click", function(e) {  //목록으로
  			e.preventDefault();
  			window.location.href = "/board/list";		
		});
		
		
});	 // ready end

function registerCheck(){
	const title = $("#title_write").val();
	const content = CKEDITOR.instances.board_textarea.getData()
	console.log(title);
	console.log(content);
	if(title === "") {
		alert("제목을 입력하세요");
		return false;
	}
	if(content === "") {
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}





