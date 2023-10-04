<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.btn {
	font-size: 12px;
	padding: 0.3em;
}

.table-mypage>thead>tr>th, .table-mypage>tbody>tr>th, .table-mypage>tfoot>tr>th
	{
	border-right: 2px solid black;
}

.table-mypage>thead>tr>th, .table-mypage>thead>tr>td {
	border-top: 2px solid black;
	border-bottom: 1px solid black;
	border-bottom: 1px solid black;
	padding: 0.5em;
}

.table-mypage>tbody>tr>th, .table-mypage>tbody>tr>td {
	border-bottom: 1px solid black;
	padding: 0.5em;
}

.table-mypage>tfoot>tr>th, .table-mypage>tfoot>tr>td {
	border-top: 1px solid black;
	border-bottom: 2px solid black;
	padding: 0.5em;
}
</style>

<script>
	$(function() {

		$(".profile-delete").click(
				function() {

					var choice = window.confirm("정말 프로필을 지우시겠습니까?");
					if (choice == false)
						return;
					$.ajax({
						url : "http://localhost:8080/rest/member/delete",
						method : "post",
						success : function(response) {
							$(".profile-image").attr("src",
									"https://dummyimage.com/130x130/000/fff");
						},
					});
				});
	});
</script>

<div class="container w-800 mt-20">
	<div class="flex-container auto-width">

		<div class="row mv-10 w-25 inline-flex-container align-center">

			<c:choose>

				<c:when test="${attachNo == null}">
					<img src="/images/user.png" width="150" height="150"
						class="image image-circle image-border profile-image">
				</c:when>
				<c:otherwise>
					<img src="/rest/member/download?attachNo=${attachNo}" width="150"
						height="150" class="image image-circle image-border profile-image">
				</c:otherwise>
			</c:choose>

		</div>
		<div class="row w-75"
			style="margin-top: 18%; margin-left: 5%; margin-bottom: none;">
		<div class="flex-container col-2 left">

				<h1>${memberDto.memberId}
					<i class="fa-solid fa-crown" style="color: #74b6c8;"></i>
				</h1>

		</div>
		<div class="flex-container col-2 right">
				<c:if test="${attachNo != null}">
					<span class="right"> <i class="fa-solid fa-circle-xmark profile-delete"
							style="color: #78bdcf;">프로필 삭제</i>
					</span>
				</c:if>
		</div>
		</div>


	</div>
	

	<div class="row">
		<table class="table-mypage w-100">
			<thead>
				<tr>
					<th>아이디</th>
					<td>${memberDto.memberId}</td>
				</tr>
			</thead>
			<tbody>
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
			</tbody>
			<tr>
				<th>포인트</th>
				<td>${memberDto.memberPoint}<i class="fa-solid fa-p fa-xs"
					style="color: #001c40;"></i></td>
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
			<tfoot>
				<tr>
					<th>마지막 비밀번호 변경일</th>
					<td><fmt:formatDate value="${memberDto.memberPwChange}"
							pattern="y년 M월 d일 E a h시 m분 s초" /></td>
				</tr>
			</tfoot>
		</table>

		<div class="flex-container auto-width">

			<div class="row col-2"></div>
			<div class="row col-2">

				<div class="flex-container auto-width">
					<div class="row col-3">
						<a class="link" href="edit?memberId=${memberDto.memberId}">회원정보변경</a>
					</div>
					<div class="row">|</div>
					<div class="row col-3">
						<c:choose>
							<c:when test="${blockDetailList[0].block == 'Y'}">
								<a class="link" href="cancel?memberId=${memberDto.memberId}">해제</a>
							</c:when>
							<c:otherwise>
								<a class="link" href="block?memberId=${memberDto.memberId}">차단</a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="row">|</div>
					<div class="row col-3">
						<a class="link" href="list">목록</a>
					</div>
				</div>
			</div>

		</div>



		<div class="row right"></div>

		<div class="row left">
			<h1>활동내역</h1>
			<table class="table table-regular">
				<tbody>
					<c:forEach var="boardDto" items="${boardList}">
						<tr>
							<th><a class="link"
								href="/board/detail?boardNo=${boardDto.boardNo}">
									${boardDto.boardTitle}</a></th>
							<th>${boardDto.boardWriter}</th>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
