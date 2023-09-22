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


<div class="container w-500">
<form action="edit" method="post" autocomplete="off">
	<input type="hidden" name="memberId" value="${memberDto.memberId}">
	<div class="row">
	닉네임 <input type="text" name="memberNickname" value="${memberDto.memberNickname}">
	</div>
	<div class="row">
	포인트 <input type="number" name="memberPoint" value="${memberDto.memberPoint}">
	</div>
	<div class="row">
	등급 
		<select name="memberLevel" value="${memberDto.memberLevel}">
		<option value="beginner">beginner</option>
		<option value="관리자">관리자</option>
		</select>
	</div>	
	
	<div class="row">
	<button type="submit" class="btn btn-positive"> 수정하기 </button>
	</div>
	
</form>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>