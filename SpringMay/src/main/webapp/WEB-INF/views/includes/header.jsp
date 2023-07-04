<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" type="text/css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
<title>Spring project</title>
</head>
<style>
.container_header {
  background-color: #333;
  padding-top: 20px;
  height:60px;
}

.wrapper {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.wrapper_head {
  font-size: 24px;
  font-weight: bold;
  color: #white;
}

.wrapper_menu {
  display: flex;
  align-items: center;
}

.menu-item {
  margin: 0 10px;
  text-decoration: none;
  color: #fff;
  font-weight: bold;
}

.menu-item:hover {
  color: #ccc;
}


</style>
<body>
	<div class="container_header">
		<div class="wrapper">
			<div class="wrapper_head">
				<a href="/"><span>Spring project</span></a>
			</div>
			<nav class="wrapper_menu">
				<a href="/board/list"><span class="menu-item">게시판</span></a>
				<c:choose>
				<c:when test="${not empty auth}">
					<span class="menu-item"><c:out value="${auth.userid}"/>님</span>
					<a href="/member/logout"><span class="menu-item">로그아웃</span></a>	
				</c:when>
				<c:otherwise>
					<a href="/member/login"><span class="menu-item">로그인</span></a>
					<a href="/member/signup"><span class="menu-item">회원가입</span></a>
				</c:otherwise>
				</c:choose>
				
			</nav>
		</div>
	
	</div>
</body>
</html>