<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>회원 가입</h1>

<form action="join" method="post" autocomplete="off"> <br><br>
	아이디 <input type="text" name="memberId"> <br><br>
	비밀번호 <input type="password" name="memberPw"> <br><br>
	닉네임 <input type="text" name="memberNickname"> <br><br>
	이메일 <input type="email" name="memberEmail"> <br><br>
	생년월일 <input type="date" name="memberBirth"> <br><br>
	
	거주지
	<select name="memberArea">
		<option value="">선택</option>
		<option value="서울">서울</option>
		<option value="부산">부산</option>
		<option value="대구">대구</option>
		<option value="인천">인천</option>
		<option value="광주">광주</option>
		<option value="대전">대전</option>
		<option value="울산">울산</option>
		<option value="세종">세종</option>
		<option value="경기도">경기도</option>
		<option value="경상도">경상도</option>
		<option value="전라도">전라도</option>
		<option value="충청도">충청도</option>
		<option value="제주도">제주도</option>
		<option value="강원도">강원도</option>
	</select>
	
	<button type="submit">가입</button>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
