<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://code.jQuery.com/jQuery-3.7.1.min.js"></script>

<h1>아이디 찾기 결과</h1>


<h2>찾은 아이디: ${param.memberId}</h2>


<br><br>

<a href="/login">로그인 하기</a>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
