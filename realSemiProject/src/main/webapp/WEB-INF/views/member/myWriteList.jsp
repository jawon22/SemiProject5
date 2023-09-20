<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<table>
<tbody>
	<c:forEach var="boardDto" items="${myWriteList}">
		<tr>
			<th>
				${boardDto.boardTitle}	
			</th>
			<th>
				${boardDto.boardWriter}
			</th>
		</tr>		
	</c:forEach>
</tbody>
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
