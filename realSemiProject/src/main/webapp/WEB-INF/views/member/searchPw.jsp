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

<script>
	$(function(){
		
		$(".cert-wrapper").click(function(){
			$(".cert-wrapper").hide();
		});
		
	});
</script>

<form action="searchPw" method="post" autocomplete="off">
	<div class="container w-300">
	    <div class="row">
	        <h1>비밀번호 찾기</h1>
	    </div>

    	<div class="row mt-30">
	        <div class="row left mt-30 mb-20">
	            <label>아이디</label>
	            <input type="text" class="form-input w-100 mt-10" name="memberId">
	        </div>
	        <div class="row left mb-20">
	            <label>이메일</label>
	            <input type="text" class="form-input w-100 mt-10" name="memberEmail">
	        </div>
	        <div class="row mb-20">
	        	<c:if test="${param.error != null}">
	        		<span class="red">존재하지 않는 회원입니다</span>
	        	</c:if>
	        </div>
	        <div class="row mt-30 cert-wrapper">
	            <button type="submit" class="btn btn-positive w-100">찾기</button>
	        </div>
		</div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
