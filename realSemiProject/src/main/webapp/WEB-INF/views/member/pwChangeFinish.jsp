<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<h1>비밀번호 변경 완료</h1>
	</div>
	
	<div class="row center mt-40">
		<a href="${pageContext.request.contextPath}/" class="link me-10">로그인 상태 유지</a>
		<a href="logout" class="link ms-10">로그아웃</a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>