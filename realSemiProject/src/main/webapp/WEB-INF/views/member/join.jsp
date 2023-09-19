<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>회원 가입</h1>

<form action="join" method="post" autocomplete="off">
	아이디* <input type="text" name="memberId" required>
	비밀번호* <input>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
