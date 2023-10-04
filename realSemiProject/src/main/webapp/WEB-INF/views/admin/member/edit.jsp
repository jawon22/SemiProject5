<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
$(function(){
	
	$("[name=memberLevel]").change(function(e){
		
		window.comfirm("진짜로?");
		
	});
	
});

</script>


<div class="container w-400">
<form action="edit" method="post" autocomplete="off">
	<input type="hidden" name="memberId" value="${memberDto.memberId}">
	<div class="row left">
	닉네임 <input class="form-input w-100" type="text" name="memberNickname" value="${memberDto.memberNickname}">
	</div>
	<div class="row left">
	포인트 <input class="form-input w-100" type="number" name="memberPoint" value="${memberDto.memberPoint}">
	</div>
	<div class="row left">
	등급 
		<select name="memberLevel" value="${memberDto.memberLevel}">
		<option value="beginner" ${memberDto.memberLevel == 'beginner' ? 'selected' : ''}>beginner</option>
		<option value="tripper" ${memberDto.memberLevel == 'tripper' ? 'selected' : ''}>tripper</option>
		<option value="관리자" ${memberDto.memberLevel == '관리자' ? 'selected' : ''}>관리자</option>
		</select>
	</div>	
	
	<div class="row">
	<button type="submit" class="btn btn-positive w-100"> 수정하기 </button>
	</div>
	
</form>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>