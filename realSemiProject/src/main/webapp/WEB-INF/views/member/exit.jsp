<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-500">
<form actio="exit" method="post" autocomplete="off">
	<div class="row left">
	비밀번호 
	</div>
	<div class="row">
	<input class="form-input w-100" type="password" name="inputPw">
	</div>
	<div class="row">
	<button class="btn btn-positive w-100" type="submit">탈퇴하기</button>
	</div>
	<!-- 팝업창을 띄워서 진짜로탈퇴하시겠습니까? 확인하기 --> 
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>