<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="exit" method="post" autocomplete="off">
	비밀번호 <input type="password" name="inputPw">
	<button type="submit">탈퇴하기</button>
	<!-- 팝업창을 띄워서 진짜로탈퇴하시겠습니까? 확인하기 --> 
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>