<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://code.jQuery.com/jQuery-3.7.1.min.js"></script>

<h1>비밀번호 찾기</h1>

<form action="searchPw" method="post" autocomplete="off">
	아이디 <br><br>
	<input type="text" name="memberId"> <br><br>
	이메일 <br><br>
	<input type="text" name="memberEmail"> <br><br>
	<button type="submit">찾기</button>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
