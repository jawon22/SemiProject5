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
	h3,
	h4{
		color: #26C2BF;
	}
</style>

<div class="container w-500">
	<div class="row">
		<img width="80px" src="${pageContext.request.contextPath}/images/check-icon.png">
	</div>
	
	<div class="row center mt-40 mb-20">
		<h1>비밀번호 찾기</h1>
	</div>
	<div class="row center mb-10">
		<h3>임시 비밀번호를 보냈습니다.</h3>
	</div>
	<div class="row center mb-40">
		<h4>이메일을 확인해주세요.</h4>
	</div>
	
	<div class="row center mt-40">
		<a href="login" class="link">로그인하기</a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>