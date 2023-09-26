<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
$(function(){
	
    $("[name=changePw]").blur(function(){
        var Regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
		var pw = $(this).val();
        var isValid = Regex.test($(this).val());
    
        console.log(isValid);
        $(this).removeClass("success fail fail2");
        
        if(isValid) {
        	$.ajax({
        		url:"http://localhost:8080/rest/member/pwCheck",
    			method:"post",
    			data:{
    				memberPw : pw
    			},
    			success:function(response){
    				
    				$("[name=changePw]").removeClass("success fail");
    				if(response == "Y") {
    					$("[name=changePw]").addClass("success");
    					status.memberPw = true;	
    				}
    				else {
    					$("[name=changePw]").addClass("fail2");
    					status.memberPw = false;
    				}
    			},
    			error:function(){
    				alert("서버와의 통신이 원활하지 않습니다")				
    			}
        	});
        	
        }

        status.pw = isValid;
    });
    
    $(".checkPw").blur(function(){
   
    	var changePw = $("[name=changePw]").val();
    	var checkPw = $(".checkPw").val()
    	var isValid = changePw == checkPw;
       
    	$(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
    	
    });	
	
});
</script>


<div class="container w-500">

<form action="pwChange" method="post" autocomplete="off">
	
	<div class="row left">기존 비밀번호</div> <input class="form-input w-100" type="password" name="originPw">
	<div class="row left">바꿀 비밀번호</div> <input class="form-input w-100" type="password" name="changePw">
	<div class="fail-feedback left">형식에 맞지 않습니다.</div>
	<div class="fail2-feedback left">기존 비밀번호와 동일합니다</div>
	<div class="row left">비밀번호 확인</div> <input class="form-input w-100 checkPw" type="password" > <!-- 프론트에서 비동기로 일치하는지 확인하기 -->
	<div class="fail-feedback left">비밀번호가 일치하지 않습니다.</div>
	
	<button class="btn btn-positive w-100 mt-20" type="submit">비밀번호 변경</button>
	
</form>

<c:if test="${param.error != null}">
	비밀번호가 일치하지 않습니다.
</c:if>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>