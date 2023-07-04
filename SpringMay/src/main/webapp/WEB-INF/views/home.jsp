<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="./includes/header2.jsp" %>
<style>
	#main{
		width:1200px;
		height:700px;
		/* background-color:aqua;
        opacity: 0.2; */
	}
	.itemWrap{
		width:100%;
		display:flex;
		flex-direction:row;
		justify-content:flex-start;
		align-tiems:flex-start;
		flex-wrap:wrap;
		padding:100px 0;
	}
</style>
<script type="text/javascript">
	$(function(){
		let msg = "${msg}"
		console.log(msg);
		if(msg == ""){
			return;
		}
		if(msg == "logout") {
			alert("로그아웃되었습니다.");
		}
		
	});
	
	
</script>
<div class="wrapper_main" id="main">
	<p><h1>Spring Project Main Page</h1>
</div>





<%@include file="./includes/footer.jsp" %>