<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
$(function(){
	
	var originMemberPoint = ${memberDto.memberPoint};
	
	$("[name=memberLevel]").change(function(){
		
		var memberLevel = $(this).val();
		var memberPointInput = $("[name=memberPoint]");
		
		if(memberLevel == 'tripper') {
			memberPointInput.val(1000);
		}
		else {
            memberPointInput.val(originMemberPoint);
        }
		
	});
	
    $("[name=memberNickname]").blur(function(){
        var Regex = /^[가-힣0-9]{2,10}$/;
        var isValid = Regex.test($(this).val());

        $(this).removeClass("success fail fail2");
        $(this).addClass(isValid ? "success" : "fail");

    });
	
	
});

</script>


<div class="container w-300">
<form action="edit" method="post" autocomplete="off">
	<input type="hidden" name="memberId" value="${memberDto.memberId}">
	<div class="row left">
	닉네임 
	</div>
	<div class="row left">	
	<input class="form-input w-100" type="text" name="memberNickname" value="${memberDto.memberNickname}">
	<div class="fail-feedback">올바른 닉네임을 입력하세요</div>
	</div>
	<div class="row left">
	포인트 
	</div>
	<div class="row left">
	<input class="form-input w-100" type="number" name="memberPoint" value="${memberDto.memberPoint}" min="0">
	</div>
	<div class="row left">
	등급 
	</div>	
	<div class="row">
		<select class="form-input w-100" name="memberLevel" value="${memberDto.memberLevel}">
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