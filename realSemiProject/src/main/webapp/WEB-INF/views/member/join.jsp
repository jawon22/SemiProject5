<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form class="join-form mt-30" action="join" method="post" autocomplete="off">
<!-- 	<div class="container w-600"> -->
<!-- 		<div class="row"> -->
<!-- 			<h1>회원 가입</h1> -->
<!-- 		</div> -->
		
<!-- 		<hr> -->
		
<!-- 		<div class="row"> -->
<!-- 			<div class="row"> -->
<!-- 				<label>아이디</label> -->
<!-- 				<input class="form-input w-100" type="text" name="memberId" placeholder="영문 소문자, 숫자 5~18자"> -->
<!-- 				<div class="success-feedback">사용 가능한 아이디입니다</div> -->
<!-- 				<div class="fail-feedback">사용할 수 없는 아이디입니다</div> -->
<!-- 				<div class="fail-feedback">이미 사용 중인 아이디입니다</div> -->
<!-- 			</div> -->
<!-- 			<div class="row"> -->
<!-- 				<label>비밀번호</label> -->
<!-- 				<input class="form-input w-100" type="password" name="memberPw" placeholder="영문 대•소문자, 숫자, 특수문자(!@#$) 포함 8~16자"> -->
<!-- 				<div class="success-feedback">사용 가능한 비밀번호입니다</div> -->
<!-- 				<div class="fail-feedback">사용할 수 없는 비밀번호입니다</div> -->
<!-- 			</div> -->
<!-- 			<div class="row"> -->
<!-- 				<label>비밀번호 확인</label> -->
<!-- 				<input class="form-input w-100" type="password" name="checkPw"  -->
<!-- 			</div> -->
		
		
<!-- 		</div> -->
		
		
		
	
	</div>
	
	
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
