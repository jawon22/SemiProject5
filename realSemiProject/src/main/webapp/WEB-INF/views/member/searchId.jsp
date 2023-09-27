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
	.btn:focus{
		border-color: #26C2BF;
	}
</style>

<script src="https://code.jQuery.com/jQuery-3.7.1.min.js"></script>

<script>
	$(function(){
		
		$(".searchId-form").submit(function(e){
			var email = $(this).val();
			
			$.ajax({
				url:"http://localhost:8080/rest/member/emailCheck",
				method:"post",
				data:{
					memberEmail : email
				},
				success:function(response){
					if(response == "Y"){
						status.email = true;
					}else{
						status.email = false;
						alert("등록된 아이디가 없습니다");
					}
				},
				error: function () {
	                alert("서버와의 통신이 원활하지 않습니다");
	            }
			});
		});
		
	});
</script>

<form class="searchId-form" action="searchId" method="post" autocomplete="off">
	<div class="container w-300">
		<div class="row">
			<h1>아이디 찾기</h1>	
		</div>
	
		<div class="row mt-30">
			<div class="row left mt-30 mb-20">
				<label>이메일 입력</label>
				<input type="text" class="form-input w-100 mt-10" name="memberEmail">
			</div>
			<div class="row mt-30">
				<button class="btn btn-positive w-100" type="submit">찾기</button>
			</div>
		</div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
