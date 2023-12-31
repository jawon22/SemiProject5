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
<script>
$(function(){
	
    var status = {
			originPw:false,
    		pw:false,
			checkPw:false,
	        ok:function(){
	            return this.originPw && this.pw && this.checkPw;
	        },
     };
    
    $("[name=originPw]").blur(function(){
    		
    	var originPw = $(this).val();
    	
    	$.ajax({
    		url:window.contextPath+"/rest/member/pwCheck",
			method:"post",
			data:{
				memberPw : originPw
			},
			success:function(response){
				
				$("[name=originPw]").removeClass("success fail");
				if(response == "N") {
					$("[name=originPw]").addClass("success");
					status.originPw = true;
				}
				else {
					$("[name=originPw]").addClass("fail");
					status.originPw = false;
				}
			},
			error:function(){
				alert("서버와의 통신이 원활하지 않습니다")				
			}
    	});
    	
    });
    
	
    $("[name=changePw]").blur(function(){
        var Regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
		var pw = $(this).val();
        var isValid = Regex.test($(this).val());
    
        console.log(isValid);
        $(this).removeClass("success fail fail2");
        
        if(isValid) {
        	$.ajax({
        		url:window.contextPath+"/rest/member/pwCheck",
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
    					$("[name=changePw]").removeClass("fail");
    					$("[name=changePw]").addClass("fail2");
    					status.memberPw = false;
    				}
    			},
    			error:function(){
    				alert("서버와의 통신이 원활하지 않습니다")				
    			}
        	});
        	
        }
		
        $("[name=changePw]").addClass("fail");
        
        status.pw = isValid;
    });
    
    $(".checkPw").blur(function(){
   
    	var changePw = $("[name=changePw]").val();
    	var checkPw = $(".checkPw").val()
    	var isValid = changePw == checkPw;
       
    	$(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
    	
        status.checkPw = isValid;
    });	
    
    $(".changeform").submit(function(e){
    	
        if(status.ok() == false){
        	window.alert("모든 항목을 다 입력해 주세요");
            e.preventDefault();
        }
    });
	
});
</script>


<div class="container w-300">
<div class="row">
	<h1>비밀번호 변경</h1>
</div>

<form class="changeform" action="pwChange" method="post" autocomplete="off">
	
	<div class="row left">기존 비밀번호</div>
	<input class="form-input w-100" type="password" name="originPw">
	<div class="fail-feedback left">비밀번호가 일치하지 않습니다.</div>
		<div class="red left">
<%-- 	<c:if test="${param.error != null}"> --%>
<!-- 		<span class="left">비밀번호가 일치하지 않습니다.</span> -->
<%-- 	</c:if> --%>
	</div>
	<div class="row left">새 비밀번호</div> <input class="form-input w-100" type="password" name="changePw">
	<div class="fail-feedback left">형식에 맞지 않습니다.</div>
	<div class="fail2-feedback left">기존 비밀번호와 동일합니다</div>
	<div class="row left">새 비밀번호 확인</div> <input class="form-input w-100 checkPw" type="password" > 
	<div class="fail-feedback left">비밀번호가 일치하지 않습니다.</div>
	
	<button class="btn btn-positive w-100 mt-20" type="submit">비밀번호 변경</button>
	
</form>


</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>