<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	h1{
		font-size: 30px;
		font-weight: bold;
		color: #26C2BF;
	}
	label{
		font-size: 18px;
		font-weight: 500;
	}
	.form-input{
		border-radius: 10px;
		border-width: 3px;
		border-color: #26C2BF;
	}
	.btn{
		border-radius: 10px;
	}
	.selectbox{
		font-size: 18px;
		height: 45px;
		border-radius: 10px;
		border-width: 3px;
		border-color: #26C2BF;
  		padding: 10px 15px;
	}
	.form-input:focus,
	.btn:focus,
	.selectbox:focus{
		border-color: #26C2BF;
	}
</style>
<div class="container w-500">
<div class="row">
	<h1>회원 탈퇴</h1>
</div>

<form action="exit" method="post" autocomplete="off">
	<div class="row left">
	비밀번호 
	</div>
	<div class="row">
	<input class="form-input w-100" type="password" name="inputPw">
	</div>
	<div class="row left">
		<c:if test="${param.error != null}">
			<span class="red">비밀번호가 일치하지 않습니다</span>
		</c:if>
	</div>
	<div class="row">
	<button class="btn btn-positive w-100" type="submit">회원탈퇴</button>
	</div>
	<!-- 팝업창을 띄워서 진짜로탈퇴하시겠습니까? 확인하기 --> 
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>