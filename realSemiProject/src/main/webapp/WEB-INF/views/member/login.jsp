<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<form action="login" method="post" autocomplete="off">
		아이디 <input type="text" name="memberId">
		비밀번호 <input type="password" name="memberPw">
		<button type="submit">로그인하기</button>
	</form>
	<c:if test="${param.error != null}">
		비밀번호가 일치하지 않습니다
	</c:if>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>