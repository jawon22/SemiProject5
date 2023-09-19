<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="cantainer">
	<div class="row">
		<table class="table table-board">
			<thead>
				<tr>
					<th>계절</th>					
					<th>지역</th>					
					<th>제목</th>					
					<th>작성자</th>					
					<th>작성일</th>					
					<th>조회수</th>					
				</tr>			
			</thead>
			<tbody>
			<c:forEach var="boardDto" items="${list}">
				<tr>
					<th>${boardDto.boardCategory}</th>
				<a href="/detail">	<th>${boardDto.boardTitle}</th></a>
					<th>${boardDto.boardWriter}</th>
					<th>${boardDto.boardCtime}</th>
					<th>${boardDto.boardReplycount}</th>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>