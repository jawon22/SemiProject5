<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="pwChange" method="post" autocomplete="off">
	바꿀 비밀번호 <input type="password" name="changePw">
	비밀번호 확인 <input type="password" > <!-- 프론트에서 비동기로 일치하는지 확인하기 -->
	<button type="button">비밀번호확인?</button> <!-- 버튼을 누르면 비밀번호 확인 or 버튼 누르는거 없이 입력창에 입력하면 확인? -->
	
	기존 비밀번호 <input type="password" name="originPw">
	<button type="submit">비밀번호 변경</button>
	
</form>

<c:if test="${param.error != null}">
	비밀번호가 일치하지 않습니다.
</c:if>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>