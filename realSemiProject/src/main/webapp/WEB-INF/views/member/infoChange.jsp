<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>


</script>

<form action="infoChange" method="post" autocomplete="off">
<div class="container w-300">
	<input type="hidden" name="memberId" value="${memberDto.memberId}">
	<div class="row left">
	닉네임 
	</div>
	<div class="row">
	<input class="form-input w-100" type="text" name="memberNickname" value="${memberDto.memberNickname}">
	</div>
	<div class="row left">
	이메일 
	</div>
	<div class="row">
	<input class="form-input w-100" type="email" name="memberEmail" value="${memberDto.memberEmail}">
	</div>
	<div class="row left">
	생년월일 
	</div>
	<div class="row">
	<input class="form-input w-100" type="date" name="memberBirth" value="${memberDto.memberBirth}">
	</div>
	<div class="row left">
	거주지 
	</div>
	<div class="row">
	<select class="form-input w-100" name="memberArea">
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
	</div>
	<div class="row left">
	비밀번호 확인 
	</div>
	<div class="row">
	<input class="form-input w-100" type="password" name="memberPw">
	</div>
	<div class="row">
		<c:if test="${param.error != null}">
			<span class="red">비밀번호가 일치하지 않습니다.</span>
		</c:if>
	</div>
	
	<div class="row">
	<button  class="btn btn-positive w-100" type="submit"> 수정하기 </button>
	</div>
	
</div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>