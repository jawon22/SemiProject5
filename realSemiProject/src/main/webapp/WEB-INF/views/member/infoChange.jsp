<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		color:gray;
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
	
	    var status = {
	        nickname:false,
	        email:false,
			area:false,
			pw:false,
	        ok:function(){
	            return this.nickname && this.email 
	            && this.area && this.pw;
	        },
	    };
	
	
	    $("[name=memberNickname]").blur(function(){
	        var Regex = /^[가-힣0-9]{2,10}$/;
	        var isValid = Regex.test($(this).val());
	
	        $(this).removeClass("success fail fail2");
	        $(this).addClass(isValid ? "success" : "fail");
	
	        status.nickname = isValid;
	    });
	
	    var backupEmail = $("[name=memberEmail]").val();

		$("[name=memberEmail]").blur(function() {
		    var Regex = /^.*@.*$/;
		    var isValid = (Regex.test($(this).val())) && ($(this).val().length != 0); // 이메일 유효성 검사 수정
		    var email = $("[name=memberEmail]").val();
			
// 		    if(backupEmail == email){
// 		    	status.email = true;
		    	
// 		    }
		    
		    $("[name=memberEmail]").removeClass("success fail fail2"); // 유효하지 않은 경우 성공 클래스 제거
		    if (isValid) {
		        $.ajax({
		            url: "http://localhost:8080/rest/member/emailCheck",
		            method: "post",
		            data: {
		                memberEmail: email
		            },
		            success: function (response) {
		                if (response == "Y") {
		//                     $("[name=memberEmail]").removeClass("fail2"); // 실패 클래스 제거
		                    $("[name=memberEmail]").addClass("success");
		                    status.email = true;
		                } 
		                else if ($("[name=memberEmail]").val() == backupEmail) {
		//                     $("[name=memberEmail]").removeClass("fail2"); // 실패 클래스 제거
		                    $("[name=memberEmail]").addClass("success");
		                    status.email = true;
		                } 
		                else {
		                    $("[name=memberEmail]").addClass("fail2");
		                    status.email = false;
		                }
		            },
		            error: function () {
		                alert("서버와의 통신이 원활하지 않습니다");
		            }
		        });
		    } else {
		        $("[name=memberEmail]").addClass("fail");
		        status.email = false;
		    }
		
		});


	    $("[name=memberArea]").click(function(){
	
// 	    	var isValid = $('input[name=memberArea]:checked').val().length != 0;
	    	var isValid = $("[name=memberArea]").val().length != 0;
	    	console.log(isValid)
	        $(this).removeClass("success fail");
	        $(this).addClass(isValid ? "success" : "fail");
	
	        status.area = isValid;
	    });
	    
	    
	    $("[name=memberPw]").blur(function(){
	
	    	var isValid = $(this).val().length != 0;
	    	
	        $(this).removeClass("success fail");
	        $(this).addClass(isValid ? "success" : "fail");
	
	        status.pw = isValid;
	    });
	
// 	    $(".changeform").submit(function(e){
	
// 	        if(status.ok() == false){
// // 	        	window.alert("모든 항목을 다 입력해 주세요");
// 	            e.preventDefault();
// 	        }
// 	    });
	});
</script>

<form class="changeform" action="infoChange" method="post" autocomplete="off">
	<div class="container w-300">

<div class="row mv-20">
	<h1>개인정보 변경</h1>
</div>


		<input type="hidden" name="memberId" value="${memberDto.memberId}">
		<div class="row left">
			<label>닉네임</label>
		</div>
		<div class="row left">
			<input class="form-input w-100" type="text" name="memberNickname"
				value="${memberDto.memberNickname}">
			<div class="fail-feedback">한글/숫자 2~10글자 이내 작성</div>
		</div>
		<div class="row left">
			<label>이메일</label>
		</div>
		<div class="row left">
			<input class="form-input w-100" type="email" name="memberEmail"
				value="${memberDto.memberEmail}">
			<div class="fail-feedback">올바른 이메일 주소를 입력하세요</div>
			<div class="fail2-feedback">이미 등록된 이메일 주소입니다</div>
		</div>
		<div class="row left">
			<label>생년월일</label>
		</div>
		<div class="row">
			<input class="form-input w-100" type="date" name="memberBirth"
				value="${memberDto.memberBirth}">
		</div>
		<div class="row left">
			<label>거주지</label>
		</div>
		<div class="row">
			<select class="form-input w-100" name="memberArea">
				<option value="서울" ${memberDto.memberArea == '서울' ? 'selected' : ''}>서울</option>
				<option value="부산" ${memberDto.memberArea == '부산' ? 'selected' : ''}>부산</option>
				<option value="대구" ${memberDto.memberArea == '대구' ? 'selected' : ''}>대구</option>
		        <option value="인천" ${memberDto.memberArea == '인천' ? 'selected' : ''}>인천</option>
		        <option value="광주" ${memberDto.memberArea == '광주' ? 'selected' : ''}>광주</option>
		        <option value="대전" ${memberDto.memberArea == '대전' ? 'selected' : ''}>대전</option>
		        <option value="울산" ${memberDto.memberArea == '울산' ? 'selected' : ''}>울산</option>
		        <option value="세종" ${memberDto.memberArea == '세종' ? 'selected' : ''}>세종</option>
		        <option value="경기도" ${memberDto.memberArea == '경기도' ? 'selected' : ''}>경기도</option>
		        <option value="경상도" ${memberDto.memberArea == '경상도' ? 'selected' : ''}>경상도</option>
		        <option value="전라도" ${memberDto.memberArea == '전라도' ? 'selected' : ''}>전라도</option>
		        <option value="충청도" ${memberDto.memberArea == '충청도' ? 'selected' : ''}>충청도</option>
		        <option value="제주도" ${memberDto.memberArea == '제주도' ? 'selected' : ''}>제주도</option>
		        <option value="강원도" ${memberDto.memberArea == '강원도' ? 'selected' : ''}>강원도</option>
			</select>
		</div>
		<div class="row left">
			<label>비밀번호 확인</label>
		</div>
		<div class="row">
			<input class="form-input w-100" type="password" name="memberPw">
		</div>
		<div class="row left">
			<c:if test="${param.error != null}">
				<span class="red">비밀번호가 일치하지 않습니다.</span>
			</c:if>
		</div>

		<div class="row">
			<button class="btn btn-positive w-100" type="submit">수정하기</button>
		</div>

	</div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>