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
	h3{
		color: #26C2BF;
	}
</style>

<div class="container w-500">
	<div class="row">
		<img width="80px" src="${pageContext.request.contextPath}/images/check-icon.png">
	</div>
	
	<div class="row center mt-40 mb-20">
		<h1>회원가입 완료</h1>
	</div>
	<div class="row center mb-40">
		<h3>환영합니다</h3>
	</div>
	
	<div class="row center mt-40">
		<a href="${pageContext.request.contextPath}/" class="link me-10">홈으로 이동</a>
		<a href="${pageContext.request.contextPath}/member/login" class="link ms-10">로그인하기</a>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
