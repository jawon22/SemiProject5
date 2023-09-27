<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
h1 {
	font-size: 30px;
	font-weight: bold;
	color: #26C2BF;
}

.profile-image:hover {
	cursor: pointer;
}

.custom-checkbox {
	display: inline-block;
	font-size: 18px;
	position: relative;
}

.custom-checkbox>[type=checkbox] {
	display: none;
}

.custom-checkbox>span {
	display: block;
	width: 1em;
	height: 1.2em; background-image : url("/images/fa-chevron-right.png");
	background-size: 55%;
	background-position: center;
	background-repeat: no-repeat;
	background-image: url("/images/fa-chevron-right.png")
}

.custom-checkbox>[type=checkbox]:checked+span {
	background-image: url("/images/fa-chevron-right.png");
}
</style>
<script>
	$(function() {
		
		$(".profile-chooser").change(
				function() {

					var input = $(".profile-chooser")[0];
					if (input.files.length == 0)
						return;

					var form = new FormData();
					form.append("attach", input.files[0]);

					$.ajax({
						url : "/rest/member/upload",
						method : "post",
						processData : false,
						contentType : false,
						data : form,
						success : function(response) {
							$(".profile-image").attr(
									"src",
									"/rest/member/download?attachNo="
											+ response.attachNo);
						},
						error : function() {
							window.alert("잠시 후 다시 시도해주세요");
						},
					});

				});

		$(".profile-delete").click(function() {
			var choice = window.confirm("정말 프로필을 지우시겠습니까?");
			if (choice == false)
				return;
			$.ajax({
				url : "/rest/member/delete",
				method : "post",
				success : function(response) {
					$(".profile-image").attr("src", "/images/user.png");
				},
			});
		});

		
		$(".check").change(function() {
			var check = $(this).prop("checked");
			
			$(".myList").prop("checed", check);
			
			if(check) {
				$(".myList").show();
			}
			else {
				$(".myList").hide();				
			}
		});

	});
</script>

<div class="container w-800 mt-20">
	<div class="flex-container auto-width">

		<div class="mv-10 w-25 inline-flex-container align-center">
			<label> <c:choose>
					<c:when test="${profile == null}">
						<img src="/images/user.png" width="150" height="150"
							class="image image-circle image-border profile-image">
					</c:when>
					<c:otherwise>
						<img src="/rest/member/download?attachNo=${profile}" width="150"
							height="150"
							class="image image-circle image-border profile-image">
					</c:otherwise>
				</c:choose> <input type="file" class="profile-chooser" accept="image/*"
				style="display: none;">
			</label>
		</div>

		<c:if test="${profile != null}">
			<div>
				<i class="fa-solid fa-circle-xmark profile-delete float"
					style="color: #26C2BF; margin-right: 100%;"></i>
			</div>
		</c:if>

		<div class="row w-75 left inline-flex-container"
			style="margin-top: 18%; margin-left: 0; margin-bottom: none;">
			<h1>${memberDto.memberId}
				<i class="fa-solid fa-crown" style="color: #26C2BF;"></i>
			</h1>
		</div>

	</div>

	<div class="row">
		<table class="table table-slit">
			<tr>
				<th>아이디</th>
				<td>${memberDto.memberId}</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>${memberDto.memberNickname}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${memberDto.memberEmail}</td>
			</tr>
			<tr>
				<th>지역</th>
				<td>${memberDto.memberArea}</td>
			</tr>
			<tr>
				<th>회원등급</th>
				<td>${memberDto.memberLevel}</td>
			</tr>
			<tr>
				<th>포인트</th>
				<td>${memberDto.memberPoint} 
				<label><i class="fa-solid fa-p"></i></label></td>
			</tr>
			<tr>
				<th>가입일</th>
				<td><fmt:formatDate value="${memberDto.memberJoin}"
						pattern="y년 M월 d일 E a h시 m분 s초" /></td>

			</tr>
			<tr>
				<th>마지막 접속일</th>
				<td><fmt:formatDate value="${memberDto.memberLogin}"
						pattern="y년 M월 d일 E a h시 m분 s초" /></td>
			</tr>
		</table>

		<c:if test="${expiredListDto.isExpired == 'Y'}">
			<label style="font-size: 40px; color: red;">비밀번호가 변경된지 90일이
				경과되었습니다. <br> 비밀번호를 변경해 주세요.
			</label>
		</c:if>

		<div class="flex-container auto-width">

			<div class="row col-2"></div>
			<div class="row col-2">
			
		<div class="flex-container auto-width">
			<div class="row col-3">
				<a class="link" href="infoChange">정보수정</a>
			</div>
			<div class="row"> | </div>
			<div class="row col-3">
				<a class="link" href="pwChange"> 비밀번호변경 </a>
			</div>
			<div class="row"> | </div>
			<div class="row col-3">
				<a class="link" href="exit">회원탈퇴</a>
			</div>
			</div>
			</div>
			
		</div>
			<div class="row left">
				<h1>
					나의 활동내역 보기
					<label class="custom-checkbox">
					<input type="checkbox" class="check">
					<span></span>
					</label>
				</h1>

			</div>

		<div class="row myList" style="display:none;">
			<div class="flex-container auto-width">
				<!-- flex-container로 단을 나눌것임 -->
				<div class="flex-container col-2">
					<a class="link flex-container row" href="myLikeList">내가 좋아요 누른
						글 보러가기 > </a>
				</div>
				<div class="flex-container col-2">
					<a class="link flex-container row " href="myWriteList">내가 쓴 글
						보러가기 > </a>
				</div>
			</div>
			<div class="flex-container auto-width">
				<div class="flex-container col-2">
					<a class="link flex-container row" href="myReplyList">내가 댓글 단 글
						보러가기 > </a>
				</div>
				<div class="flex-container col-2">
					<a class="link flex-container row " href="myQnaList">내 문의글 보러가기
						> </a>
				</div>
			</div>
	
		<div class="container">
			<table class="table table-stripe">
					<thead>
						<th>제목</th>
						<th>작성자</th>
					</thead>
					<tbody>
						<c:forEach var="myLikeList" items="${myLikeList}">
							<tr>
								<td>${myLikeList.boardTitle}</td>
								<td>${myLikeList.boardWriter}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
		</div>
		
		
		<div class="flex-container auto-width">
			<!-- flex-container로 단을 나눌것임 -->
			<div class="flex-container col-2 align-center">

				<table class="table table-stripe" style="width: 350;">
					<thead>
						<th>제목</th>
						<th>작성자</th>
					</thead>
					<tbody>
						<c:forEach var="myLikeList" items="${myLikeList}">
							<tr>
								<td>${myLikeList.boardTitle}</td>
								<td>${myLikeList.boardWriter}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>


			</div>
			<div class="flex-container col-2 align-center">

				<table class="table table-stripe" style="width: 350;">
					<thead>
						<th>제목</th>
						<th>작성자</th>
					</thead>
					<tbody>
						<c:forEach var="myWriteList" items="${myWriteList}">
							<tr>
								<td>${myWriteList.boardTitle}</td>
								<td>${myWriteList.boardWriter}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
