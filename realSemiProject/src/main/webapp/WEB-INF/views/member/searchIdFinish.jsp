<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>아이디 찾기 결과</h1>

<c:choose>
	<c:when test="${searchId == null}">
		${memberDto.memberId}
	</c:when>
	<c:otherwise>
		${notSearchId}
	</c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
