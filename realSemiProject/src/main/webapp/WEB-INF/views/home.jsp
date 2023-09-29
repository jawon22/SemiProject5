<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-700">

	<div class="flex-container auto-width">
		<c:forEach var="list" items="${list}">
			<div class="flex-container auto-width mv-20">
			<a
					href="http://localhost:8080/board/detail?boardNo=${list.boardNo}">
				<c:choose>
					<c:when test="${list.attachmentCount >= 1}">
						<img src="/rest/attachment/download/${list.firstAttachmentNo}"
							width="120" height="200">
					</c:when>
					<c:otherwise>
						<img src="https://dummyimage.com/100x200/000/fff&text=image" width="120" height="200">
					</c:otherwise>
				</c:choose>
				</a>
			</div>
		</c:forEach>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>