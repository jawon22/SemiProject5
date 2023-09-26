<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-700">
<table class="table table-slit">
<thead>
	<tr>
		<th>글제목</th>
		<th>작성자</th>
		<th>작성일자</th>
	</tr>
</thead>

<tbody>
	<c:forEach var="boardDto" items="${boardDto}">
		<tr>
			<th class="left">
				<a class="link" href="/board/detail?boardNo=${boardDto.boardNo}">
				${boardDto.boardTitle}	
				</a>
			</th>
			<th>
				${memberDto.memberNickname}
			</th>
			<th>
				${boardDto.boardCtime}
			</th>
		</tr>		
	</c:forEach>
</tbody>
</table>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
