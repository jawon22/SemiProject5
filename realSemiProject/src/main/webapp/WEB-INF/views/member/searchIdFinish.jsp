<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	h1{
		font-size: 30px;
		font-weight: bold;
	}
	h1,
	h2{
		color: #26C2BF;
	}
</style>

<script src="https://code.jQuery.com/jQuery-3.7.1.min.js"></script>

<div class="container w-500">
	<div class="row">
		<img width="80px" src="/images/check-icon.png">
	</div>

	<div class="row center mt-40 mb-20">
		<h1>아이디를 찾았습니다!</h1>
	</div>
	<div class="row center mb-40">
		<h2>아이디:  ${param.memberId}</h2>
	</div>
	
	<div class="row center mt-40">
		<a href="login" class="link ms-10">로그인 하기</a>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
