<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" type="text/css" rel="stylesheet">
	<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<title>Spring project</title>
<style>
footer {
  background-color: #333;
  color: #fff;
  padding: 20px 0;
  max-height:100px;
}

.container_footer {
  margin: 0 auto;
  padding: 0 20px;
}

.footer_content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.footer_menu a {
  color: #fff;
  text-decoration: none;
  margin-right: 10px;
}

.footer_menu a:hover {
  color: #ccc;
}

</style>
</head>
<body>
<footer>

      <div class="container_footer">

      <div class="footer_content">
   
      <p>&copy; 2023 Your Company. All rights reserved.</p>
    
      <nav class="footer_menu">
              
      </nav>
             
      <a href="/about">About</a>

      <a href="/contact">Contact</a>
                
      <a href="/privacy">Privacy Policy</a>

    </div>
      </div>

    </footer>
</body>
</html>