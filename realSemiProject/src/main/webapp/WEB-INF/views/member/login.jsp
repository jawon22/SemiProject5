<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	h1 {
		font-size: 30px;
		font-weight: bold;
		color: #26C2BF;
	}
	label {
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
	.form-input:focus,
	.btn:focus {
		border-color: #26C2BF;
	}
</style>

<script>
$(function(){
	
	
	$("[name=memberId]").blur(function(e){
		var id = $(this).val();
		
		$.ajax({
			url:"http://localhost:8080/rest/member/idCheck",
			method:"post",
			data:{
				memberId : id
			},
			success:function(response){
				
				$(e.target).removeClass("success fail2");
				if(response == "Y") {
					$(e.target).addClass("success");
					status.memberId = true;	
				}
				else {
					$(e.target).addClass("fail2");
					status.memberId = false;
				}
			},
			error:function(){
				alert("서버와의 통신이 원활하지 않습니다")				
			}
		});
		
	});
	

	//페이지 이탈 방지
// 	$(window).on("beforeunload", function(){
// 		return false;
// 	});
	
	
	//form에 submit 이벤트 설정 form전송할 때는 beforeunload 이벤트를 제거
// 	$(".login-form").submit(function(e) {
// 		console.table(status);
		
// 		$(".form-input").blur();
// 		if(!status.ok()) {
// 			e.preventDefault();
// 		}
// 		else {
// 			$(window).off("beforeunload");
// 		}
	
// 	});
	
    $(".login-form").submit(function(e) {
	
    	var isValid = $("[name=memberId]").val().length != 0 
    						&& $("[name=memberPw]").val().length != 0;

    	if(!isValid) {
    		e.preventDefault();
       		alert("모든 항목을 입력해야 전송 가능합니다!");
        }
     
    });
});
</script>
<form class="login-form" action="login" method="post" autocomplete="off">
	<div class="container w-300">
		<div class="row">
			<h1>로그인</h1>
		</div>
		
		<div class="row mt-30">
			<div class="row left mb-20">
				<label>아이디</label>
				<input class="form-input w-100 mt-10" type="text" name="memberId">
				<div class="fail2-feedback">존재하지 않는 아이디입니다</div>
			</div>
			<div class="row left mb-20">
				<label>비밀번호</label>
				<input class="form-input w-100 mt-10" type="password" name="memberPw">
				<c:if test="${param.error != null}">
					<span class="red">비밀번호가 일치하지 않습니다</span>
				</c:if>
			</div>
			<div class="row">
				<button class="btn btn-positive w-100" type="submit">로그인</button>
			</div>
		</div>
	</div>	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>