<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>아이디 찾기</h1>

<form action="searchId" method="post" autocomplete="off">
	등록된 이메일 입력 <br><br>
	<input type="text" name="memberEmail"> <br><br>
	<button type="submit">찾기</button>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
