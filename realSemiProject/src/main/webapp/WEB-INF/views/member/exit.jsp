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
	.form-input:focus,
	.btn:focus {
		border-color: #26C2BF;
	}
</style>

<script>
	$(function(){
		
		$("[name=inputPw]").blur(function(e){
			var pw = $(this).val();
			
			$.ajax({
				url:"http://localhost:8080/rest/member/pwCorrect",
				method:"post",
				data:{
					inputPw : pw
				},
				success:function(response){
					$(e.target).removeClass("fail");
					if(response == "Y"){
						status.inputPw = true;
					}else{
						$(e.target).addClass("fail");
						status.inputPw = false;
					}
				},
				error: function () {
	                alert("서버와의 통신이 원활하지 않습니다");
	            }
			});
		});
		
		$(".exit-form").submit(function(e){
			alert("정말 탈퇴하시겠습니까?");
		});
		
	});
</script>

<form class="exit-form" action="exit" method="post" autocomplete="off">
	<div class="container w-300">
		<div class="row">
			<h1>회원탈퇴</h1>
		</div>
		
		<div class="row mt-30">
			<div class="row left mb-20">
				<label>비밀번호</label>
				<input class="form-input w-100" type="password" name="inputPw">
				<div class="fail-feedback red">비밀번호가 일치하지 않습니다</div>
			</div>
			<div class="row">
				<button class="btn btn-positive w-100" type="submit">탈퇴하기</button>
			</div>
		</div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>