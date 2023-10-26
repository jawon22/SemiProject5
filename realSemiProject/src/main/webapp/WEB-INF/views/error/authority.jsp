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

<script src="https://code.jQuery.com/jQuery-3.7.1.min.js"></script>

<div class="container w-500">
	<div class="row">
		<img width="80px" src="${pageContext.request.contextPath}/images/x-icon.png">
	</div>

	<div class="row center mt-40 mb-20">
		<h1>권한이 부족합니다</h1>
	</div>
	<div class="row center mb-40">
		<h3>다시 확인하고 이용해주세요</h3>
	</div>
	
	<div class="row center mt-40">
		<a href="${pageContext.request.contextPath}/" class="link ms-10">홈으로 이동</a>
	</div>
	
</div>

    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>