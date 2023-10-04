<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
h1 {
	font-size: 30px;
	font-weight: bold;
	color: #26C2BF;
	margin-bottom:15px;
}

label {
	font-size: 18px;
	font-weight: 500;
}

.form-input {
	border-radius: 10px;
	border-width: 3px;
	border-color: #26C2BF;
}

.btn {
	border-radius: 10px;
}
.btn.btn-positive:hover {
	color:white;
}

.selectbox {
	font-size: 18px;
	height: 45px;
	border-radius: 10px;
	border-width: 3px;
	border-color: #26C2BF;
	padding: 10px 15px;
}

.form-input:focus, .btn:focus, .selectbox:focus {
	border-color: #26C2BF;
}

.popup-expire {
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 99999; 
	background-color: rgba(0, 0, 0, 0.6);
	position: fixed;
}

.popup-wrap-expire {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	border-radius: 10px;
	background-color: white;
	width: 500px;
	height: 420px;
	padding: 20px;
	border: 1px solid #012D5C;
	z-index: 999999;
}


.popupbody-expire {
	font-size: 16px;
	line-height: 30px;
}



</style>

<script>
	$(function() {

		$(".login-form").submit(
				function(e) {

					var isValid = $("[name=memberId]").val().length != 0
							&& $("[name=memberPw]").val().length != 0;

					if (!isValid) {
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

<div class="row">
	<a class="link" href="/"> <img src="/images/logo.png"
		width="200px;">
	</a>
</div>

<form class="login-form" action="login" method="post" autocomplete="off">
	<div class="container w-300">
		
		<div class="row mt-30">
			<div class="row left mb-20">
				<label>아이디</label>
				<input class="form-input w-100 mt-10" type="text" name="memberId">
			</div>
			<div class="row left mb-20">
				<label>비밀번호</label>
				<input class="form-input w-100 mt-10" type="password" name="memberPw" onkeyup="checkCapsLock(event)">
					<span id="message" class="red"></span>
				<c:if test="${param.error != null}">
					<span class="red">아이디나 비밀번호가 일치하지 않습니다</span>
				</c:if>
			</div>
			<div class="row">
				<button class="btn btn-positive w-100" type="submit">로그인</button>
			</div>
		</div>
	</div>
</form>
<div class="inline-flex-container auto-width w-400">
	<a class="link col-3" href="join">회원가입</a> | <a class="link col-3"
		href="searchId">아이디 찾기</a> | <a class="link col-3" href="searchPw">비밀번호
		찾기</a>
</div>


<c:if test="${param.pwexpire != null}">
<div class="popup-expire">
	<div class="popup-wrap-expire">

	
				<div class="popupbody-expire">
					<form>
					<div class="row mv-20">
						<img src="/images/lock.png">
					</div>
					<div class="row mv-20">
					<h1>비밀번호를 변경해주세요</h1>
					<div style="font-size:16px;">회원님께서는 3개월 동안 비밀번호를 변경하지 않았습니다. 
					<p>개인정보를 보호하고 개인정보도용의 피해를 예방하기 위해 </p>
					3개월마다 주기적으로 비밀번호 변경을 안내하고 있습니다.</div> 
					</div>
					<div class="flex-container auto-width">
					<div class="col-2 ">			
					<a class="btn btn-negative link w-100" href="/member/delay">나중에 변경하기</a>
					</div>
					<div class="col-2">
					<a class="btn btn-positive link w-100" href="/member/pwChange">지금 변경하기</a> 
					</div>
					</div>
					</form>
				</div>

	</div>
</div>
</c:if>

<c:if test="${param.idexpire != null}">
<div class="popup-expire">
	<div class="popup-wrap-expire">
				<div class="popupbody-expire">
					<div class="row">
						<img src="/images/lock.png">
					</div>
					<div class="row mv-20">
					<h1>회원님은 휴면계정 상태입니다.</h1>
					<div style="font-size:16px;"> 1년동안 로그인 기록이 없는 회원은<p>
					 휴면계정으로 자동 변경되고 있습니다.</p>
					 <p>휴면계정 해제를 원하시는 경우, </p>
					wwoooorrii@gmail.com 로 휴면계정해제요청을 보내주시면
					<p>처리해드리겠습니다</p>
					</div> 
					</div>
<!-- 					<div class="container left"> -->
<!-- 					<input class="form-input w-100" type="text" name="checkId" placeholder="아이디를 입력하세요">  -->
<!-- 					<input class="form-input w-100" type="text" name="checkEmail" placeholder="이메일을 입력하세요">  -->
<!-- 					</div> -->
<!-- 					<a class="btn link w-100" href="/">확인하기</a> -->
<!-- 					<button class="btn btn-positive w-100 activate" href="activate">휴면 해제하기</button>>  -->
					<div class="flex-container auto-width">
					<div class="col2">
						<a class="btn btn-negative link w-100" href="/">메인화면 가기</a>
					</div>
					<div class="col2">
						<input type="hidden" name="memberId" value="${findId}">
						<a class="btn btn-positive link w-100" href="/member/activate">로그인 화면 가기</a>					
					</div>
					</div>
				</div>
</div>
	</div>
</c:if>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>