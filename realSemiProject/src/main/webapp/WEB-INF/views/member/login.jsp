<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

.form-input {
	border-radius: 10px;
	border-width: 3px;
	border-color: #26C2BF;
}

.btn {
	border-radius: 10px;
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

.popup {
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 100;
	background-color: rgba(0, 0, 0, 0.6);
	position: fixed;
}

.popup-wrap {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	border-radius: 10px;
	background-color: white;
	width: 500px;
	height: 400px;
	padding: 20px;
	border: 1px solid #012D5C;
}



.popupbody {
	font-size: 16px;
	line-height: 30px;
}



</style>


<script>
	$(function() {

		$("[name=memberId]").blur(function(e) {
			var id = $(this).val();

			$.ajax({
				url : "http://localhost:8080/rest/member/idCheck",
				method : "post",
				data : {
					memberId : id
				},
				success : function(response) {

					$(e.target).removeClass("success fail2");
					if (response == "Y") {
						$(e.target).addClass("success");
						status.memberId = true;
					} else {
						$(e.target).addClass("fail2");
						status.memberId = false;
					}
				},
				error : function() {
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

		$(".login-form").submit(
				function(e) {

					var isValid = $("[name=memberId]").val().length != 0
							&& $("[name=memberPw]").val().length != 0;

					if (!isValid) {
						e.preventDefault();
						alert("모든 항목을 입력해야 전송 가능합니다!");
					}

				});

	});
</script>

<div class="row">
	<a class="link" href="/"> <img src="/images/logo.png"
		width="200px;">
	</a>
</div>

<form class="login-form" action="login" method="post" autocomplete="off">
	<div class="container w-400">
		<div class="row left">
			아이디 <input class="form-input w-100" type="text" name="memberId">
			<div class="fail2-feedback">존재하지 않는 아이디입니다</div>
		</div>
		<div class="row left">
			비밀번호 <input class="form-input w-100" type="password" name="memberPw">
			<c:if test="${param.error != null}">
				<span class="red">비밀번호가 일치하지 않습니다</span>
			</c:if>
		</div>
		<div class="row">
			<button class="btn btn-positive w-100" type="submit">로그인하기</button>
		</div>
	</div>
</form>
<div class="inline-flex-container auto-width w-400">
	<a class="link col-3" href="join">회원가입</a> | <a class="link col-3"
		href="searchId">아이디 찾기</a> | <a class="link col-3" href="searchPw">비밀번호
		찾기</a>
</div>


<c:if test="${param.expire != null}">
<div class="popup">
	<div class="popup-wrap">

	
				<div class="popupbody">
					<form>
					<div class="row mv-20">
						<img src="/images/lock.png">
					</div>
					<div class="row">
					<h1>비밀번호를 변경해주세요</h1>
					<label style="font-size:16px;">회원님께서는 3개월 동안 비밀번호를 변경하지 않았습니다. <p>
					개인정보를 보호하고 개인정보도용의 피해를 예방하기 위해 <p>
					3개월마다 주기적으로 비밀번호 변경을 안내하고 있습니다.</label> 
					</div>
					<div class="flex-container auto-width">
					<div class="col-2">			
					<a class="btn btn-negative link" href="/member/delay">나중에 변경하기</a>
					</div>
					<div class="col-2">
					<a class="btn btn-positive link" href="/member/pwChange">지금 변경하기</a> 
					</div>
					</div>
					</form>
				</div>

	</div>
</div>
</c:if>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>