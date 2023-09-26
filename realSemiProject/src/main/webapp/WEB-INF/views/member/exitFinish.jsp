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
		<img width="80px" src="/images/check-icon.png">
	</div>
	
	<div class="row center mt-40 mb-20">
		<h1>회원탈퇴 완료</h1>
	</div>
	<div class="row center mb-40">
		<h3>안녕히가세요</h3>
	</div>
	
	<div class="row center mt-40">
		<a href="/" class="link me-10">홈으로 이동</a>
		<a href="/member/join" class="link ms-10">회원가입 하기</a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>