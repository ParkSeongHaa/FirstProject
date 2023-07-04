<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header2.jsp" %>

<script type="text/javascript"></script>
<script>
	$(function(){
		$(".write_btn").on("click",function(){
			/* let form = $("<form></form>");
			form.attr("method","get");
			form.attr("action","/board/register");
			form.appendTo('body');
			form.submit(); */
			self.location = "/board/register";
		});
		let result = '<c:out value="${result}"/>';
		if(result == "modify") {
			result = "글이 수정되었습니다."
			alert(result);
		} else if(result =="remove"){
			result ="글이 삭제되었습니다.";
			alert(result);
		} else if(result !=""){
			result +="번 글이 등록되었습니다.";
			alert(result);
		}
		
		$(".a").on("click",function(e){
			e.preventDefault()
			let form = $("<form></form>");
			form.attr("method","get");
			form.attr("action","/board/get");
			form.append("<input type='hidden' name='bno' value='"+$(this).attr('href')+"'>");
			form.append("<input type='hidden' name='pageNum' value='"+<c:out value="${pageDTO.criteria.pageNum}"/>+"'>");
			form.append("<input type='hidden' name='amount' value='"+<c:out value="${pageDTO.criteria.amount}"/>+"'>");
			form.appendTo('body');
			form.submit(); 
		}) 
		
		$(".paginate_button a").on("click",function(e){
			e.preventDefault();
		let form = $('<form></form>');
		form.attr("method","get");
		form.attr("action","/board/list");
		form.append("<input type='hidden' name='pageNum' value='" + $(this).attr("href") + "'>");
		form.append("<input type='hidden' name='amount' value='" + <c:out value="${pageDTO.criteria.amount}"/>+"'>");
		form.appendTo('body');
		form.submit();
		
		})
	})
</script>

<style>
	.table-container {
		/* box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
		border-radius: 6px;
		overflow: hidden; */
	}

	.table-container table {
		width: 50%;
		border-collapse: collapse;
		margin:2% auto;
	}

	.table-container th,
	.table-container td {
		padding: 10px;
		text-align: center;
		border: 1px solid grey;
	}

	.table-container th {
		background-color: #f2f2f2;
	}

	.table-container td a {
		color: #333;
		text-decoration: none;
	}

	.table-container tr:hover {
		background-color: #f9f9f9;
	}
	#write_btn {
  background-color: #4caf50;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  margin-top: 10px;
  margin-bottom : 10px;
}

#write_btn:hover {
  background-color: #45a049;
}

.pagination {
	margin:0 auto;
}
.pagination > li {
 float:left;
 margin-right:15px;
}

ul{
 list-style-type:none;
}
.board_page{
display:flex;
align-items:center;
}
#write_box{
width:1300px;
height:50px;
margin:0 auto;
}
</style>

<div class="table-container">
	<table>
		<thead>
			<tr>
				<th>No</th>
				<th>Title</th>
				<th>Writer</th>
				<th>Update Date</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${list}">
				<tr>
					<td>${list.bno}</td>
					<td>
						<a class = "a" href="<c:out value='${list.bno}'/>">
							<c:out value="${list.title}" />
						</a>
					</td>
					<td><c:out value="${list.writer}" /></td>
					<td><fmt:formatDate value="${list.updatedate}" pattern="yyyy.MM.dd HH:mm" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="board_page">
	<ul class="pagination">
		<c:if test="${pageDTO.prev}">
			<li class="paginate_button previous">
				<a href="${pageDTO.startPage-1}">Prev</a>
			</li>
		</c:if>
		<c:forEach var="num" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
			<li class="paginate_button ${pageDTO.criteria.pageNum==num ? 'active_list' :'' }">
				<a href="${num}">${num}</a>
			</li>
		</c:forEach>
		<c:if test="${pageDTO.next}">
			<li class="paginate_button next">
				<a href="${pageDTO.endPage+1}">Next</a>
			</li>
		</c:if>
	</ul>
</div>
<br>
<div id="write_box">
<button class="write_btn" id="write_btn">글쓰기</button>
</div>

	


<%@include file="../includes/footer2.jsp" %>