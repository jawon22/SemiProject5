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
	.star{
		color: #26C2BF;
	}
</style>

<script>
	$(function(){
	
	    var status = {
	        id:false,
	        pw:false,
	        checkPw:false,
	        nickname:false,
	        email:false,
	        area:false,
	
	        ok:function(){
	            return this.id && this.pw && this.checkPw && this.nickname && this.email
	                         && this.area;
	        },
	    };
	
	    $("#inputId").blur(function(){
	    	var id = $(this).val();
	    	
	        var Regex = /^[a-z][a-z0-9]{4,15}$/;
	        var isValid = Regex.test($(this).val());
	
	        $(this).removeClass("success fail fail2");
	        
	        if(isValid && id.length != 0){
	        	
	        	$.ajax({
	        		url:"http://localhost:8080/rest/member/idCheck",
	        		method:"post",
	        		data:{memberId : id},
	        		success: function(response){
	        			if(response == "Y"){
	        				$("[name=memberId]").addClass("fail2");
	        			}else{
	        				$("[name=memberId]").addClass("success");
	        			}
	        		},
	        	});
	        }else if(!isValid || id.length == 0){
	        	$("[name=memberId]").addClass("fail");
	        }
	        
	        status.id = isValid;
	    });
	
	    $("[name=memberPw]").blur(function(){
	        var Regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
	        var isValid = Regex.test($(this).val());
	
	        $(this).removeClass("success fail");
	        $(this).addClass(isValid ? "success" : "fail");
	
	        status.pw = isValid;
	    });
	
	    $("[name=checkPw]").blur(function(){
	        var originPw = $("[name=memberPw]").val();
	        var checkPw = $(this).val();
	
	        $(this).removeClass("success fail fail2");
	        if(originPw.length == 0){
	            $(this).addClass("fail2");
	            status.checkPw = false;
	        }else if(originPw == checkPw){
	            $(this).addClass("success");
	            status.checkPw = true;
	        }else{
	            $(this).addClass("fail");
	            status.checkPw = false;
	        }
	    });
	
	    $("[name=memberNickname]").blur(function(){
	        var Regex = /^[가-힣0-9]{2,10}$/;
	        var isValid = Regex.test($(this).val());
	
	        $(this).removeClass("success fail fail2");
	        $(this).addClass(isValid ? "success" : "fail");
	
	        status.nickname = isValid;
	    });
	
	    $("[name=memberEmail]").blur(function(){
	        var Regex = /^(.*?)@(.*?)$/;
	        var isValid = Regex.test($(this).val()) && $(this).val().length != 0;
	        var email = $("[name=memberEmail]").val();
	        
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
	    
	    $("[name=memberArea]").change(function(){
	    	var isValid = $(this).val().length != 0;
	    	
	        $(this).removeClass("success fail");
	        $(this).addClass(isValid ? "success" : "fail");
	    	
	        status.area = isValid;
	    });
	    
	    
	
	    $(".join-form").submit(function(e){
	        console.table(status);
	
	        if(status.ok() == false){
	            e.preventDefault();
	            alert("모든 항목을 입력해야 합니다!");
	        }
	    });
	});
	
	function checkCapsLock(event)  {
		
		  if (event.getModifierState("CapsLock")) {
		    document.getElementById("message").innerText 
		      = "<CapsLock>이 켜져있습니다."
		  }else {
		    document.getElementById("message").innerText 
		      = ""
		  }
		}
</script>

<form class="join-form" action="join" method="post" autocomplete="off">
	<div class="container w-300">
		<div class="row">
			<h1>회원 가입</h1>
		</div>
		
		<div class="row mt-30">
			<div class="row left mb-20">
				<label>아이디<span class="star">*</span></label>
				<input class="form-input w-100 mt-10" type="text" name="memberId" id="inputId" placeholder="영문 소문자, 숫자 5~18자">
				<div class="success-feedback">사용 가능한 아이디입니다</div>
				<div class="fail-feedback">사용할 수 없는 아이디입니다</div>
				<div class="fail2-feedback">이미 사용 중인 아이디입니다</div>
			</div>
			<div class="row left mb-20">
				<label>비밀번호<span class="star">*</span></label>
				<input class="form-input w-100 mt-10" type="password" name="memberPw" placeholder="영문 대소문자, 숫자, 특수문자(!@#$) 포함 8~16자" onkeyup="checkCapsLock(event)">
				<span id="message" class="red"></span>
				<div class="success-feedback">사용 가능한 비밀번호입니다</div>
				<div class="fail-feedback">사용할 수 없는 비밀번호입니다</div>
			</div>
			<div class="row left mb-20">
				<label>비밀번호 확인<span class="star">*</span></label>
				<input class="form-input w-100 mt-10" type="password" name="checkPw" onkeyup="checkCapsLock(event)" >
				<span id="message" class="red"></span>
				<div class="success-feedback">비밀번호가 일치합니다</div>
				<div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
				<div class="fail2-feedback">비밀번호를 먼저 입력해주세요</div>
			</div>
			<div class="row left mb-20">
				<label>이메일<span class="star">*</span></label>
				<input class="form-input w-100 mt-10" type="email" name="memberEmail" placeholder="example@tripee.com">
				<div class="success-feedback" >사용 가능한 이메일입니다</div>
				<div class="fail-feedback">사용할 수 없는 이메일입니다</div>
				<div class="fail2-feedback">이미 등록된 이메일 주소입니다</div>		
			</div>
			<div class="row left mb-20">
				<label>닉네임<span class="star">*</span></label>
				<input class="form-input w-100 mt-10" type="text" name="memberNickname" placeholder="한글 2~10자">
				<div class="success-feedback" >사용 가능한 아이디입니다</div>
				<div class="fail-feedback">사용할 수 없는 닉네임입니다</div>
				<div class="fail2-feedback">사용 중인 닉네임입니다</div>
			</div>
			<div class="row left mb-20">
				<label>생년월일</label>
				<input class="form-input w-100 mt-10" type="date" name="memberBirth">
				<div class="fail-feedback">날짜를 정확하게 입력해주세요</div>
			</div>
			<div class="row left mb-20">
				<label>거주지<span class="star">*</span></label>
				<select class="w-100 mt-10 selectbox" name="memberArea">
					<option value="">선택</option>
					<option value="서울">서울</option>
					<option value="부산">부산</option>
					<option value="대구">대구</option>
					<option value="인천">인천</option>
					<option value="광주">광주</option>
					<option value="대전">대전</option>
					<option value="울산">울산</option>
					<option value="세종">세종</option>
					<option value="경기도">경기도</option>
					<option value="경상도">경상도</option>
					<option value="전라도">전라도</option>
					<option value="충청도">충청도</option>
					<option value="제주도">제주도</option>
					<option value="강원도">강원도</option>
				</select>
			</div>
			<div class="row">
				<button type="submit" class="btn btn-positive w-100">가입</button>
			</div>
		</div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
