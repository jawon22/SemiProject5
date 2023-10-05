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

.custom-checkbox {
	display: inline-block;
	font-size: 18px;
	cursor: pointer;
	vertical-align: middle;  
}

.custom-checkbox>[type=checkbox] {
	display: none;
}

.custom-checkbox>span {
	display: inline-block;
	width: 1em;
	height: 1.2em;
	background-image: url("/images/fa-chevron-right.png");
	background-size: 55%;
	background-position: center;
	background-repeat: no-repeat;
	margin-right: 5px;
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
							
							$(".profile-delete").show();
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
					$(".profile-delete").hide();
				},
			});
		});

		$(".check").change(function() {
			var check = $(this).prop("checked");

			$(".myList").prop("checed", check);

			if (check) {
				$(".myList").show();
			} else {
				$(".myList").hide();
			}
		});
		
	});

</script>

<div class="container w-700 mt-20">
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

	<c:if test="${blockDto.block == 'Y'}">
		<span class="red" style="margin-top:10px; margin-left:10px; font-weight: bold; font-size:20px;">차단된 계정입니다.</span>
	</c:if>

		</div>

	</div>

	<div class="row">
		<table class="table table-mypage">
			<thead>
				<tr>
					<th width="25%">아이디</th>
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
				<tr>
					<th>포인트</th>
					<td>${memberDto.memberPoint}<label><i
							class="fa-solid fa-p"></i></label></td>
				</tr>
				<tr>
					<th>가입일</th>
					<td><fmt:formatDate value="${memberDto.memberJoin}"
							pattern="y년 M월 d일 E a h시 m분 s초" /></td>

				</tr>
			</tbody>
			<tfoot>
				<tr>
					<th>마지막 접속일</th>
					<td><fmt:formatDate value="${memberDto.memberLogin}"
							pattern="y년 M월 d일 E a h시 m분 s초" /></td>
				</tr>
			</tfoot>
		</table>
	</div>



	<div class="flex-container auto-width">

		<div class="row col-2"></div>
		<div class="row col-2">

			<div class="flex-container auto-width">
				<div class="row col-3">
					<a class="link" href="infoChange">정보수정</a>
				</div>
				<div class="row">|</div>
				<div class="row col-3">
					<a class="link" href="pwChange"> 비밀번호변경 </a>
				</div>
				<div class="row">|</div>
				<div class="row col-3">
					<a class="link" href="exit">회원탈퇴</a>
				</div>
			</div>
		</div>
	</div>
	
	<div class="flex-container">
			<label class="custom-checkbox"><input
				type="checkbox" class="check"> <span></span>
				<h1 style="display:inline-block;">나의 활동내역 보기</h1>
				</label>
	</div>


	<div class="row myList" style="display: none;">



		<div class="container">
			<div class="flex-container auto-width">
			<div class="col-2 left">
				<h4>내가 작성한 글</h4>
			</div>
			<div class="col-2 right">
				<a class="link" href="myWriteList">더보기<i class="fa-regular fa-square-plus" style="color: #9aa1ac;"></i></a>
			</div>
			</div>
			<table class="table table-regular">
				<thead>
				<tr>
					<th width="50%">제목</th>
					<th>작성자</th>
					<th>작성일자</th>
					<th>조회수</th>
				</tr>
				</thead>
				<tbody>
					<c:forEach var="myWriteList" items="${myWriteList}" varStatus="loop">
						<c:if test="${loop.index < 3}">
							<tr>
								<td class="left"><a class="link"
									href="/board/detail?boardNo=${myWriteList.boardNo}">
										${myWriteList.boardTitle}</a></td>
								<td class="center">${myWriteList.memberNickname}</td>
								<td class="center">${myWriteList.boardCtime}</td>
								<td class="center">${myWriteList.boardReadcount}</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
				<div class="container">
							<div class="flex-container auto-width">
			<div class="col-2 left">
				<h4>내가 좋아요 한 글</h4>
			</div>
			<div class="col-2 right">
				<a class="link" href="myLikeList">더보기<i class="fa-regular fa-square-plus" style="color: #9aa1ac;"></i></a>
			</div>
			</div>
			<table class="table table-regular">
				<thead>
				<tr>
					<th width="50%">제목</th>
					<th>작성자</th>
					<th>작성일자</th>
					<th>조회수</th>
				</tr>
				</thead>
				<tbody>
					<c:forEach var="myLikeList" items="${myLikeList}" varStatus="loop">
						<c:if test="${loop.index < 3}">
							<tr>
								<td class="left"><a class="link"
									href="/board/detail?boardNo=${myLikeList.boardNo}">
								${myLikeList.boardTitle}</a></td>
								<td class="center">${myLikeList.memberNickname}</td>
								<td class="center">${myLikeList.boardCtime}</td>
								<td class="center">${myLikeList.boardReadcount}</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div class="container">
			<div class="flex-container auto-width">
			<div class="col-2 left">
				<h4>내가 댓글 단 글</h4>
			</div>
			<div class="col-2 right">
				<a class="link" href="myReplyList">더보기<i class="fa-regular fa-square-plus" style="color: #9aa1ac;"></i></a>
			</div>
			</div>
			<table class="table table-regular">
				<thead>
				<tr>
					<th width="50%">제목</th>
					<th>작성자</th>
					<th>작성일자</th>
					<th>조회수</th>
				<tr>
				</thead>
				<tbody>
					<c:forEach var="myReplyList" items="${myReplyList}" varStatus="loop">
						<c:if test="${loop.index < 3}">
							<tr>
								<td class="left"><a class="link"
									href="/board/detail?boardNo=${myReplyList.boardNo}">
								${myReplyList.boardTitle}</a></td>
								<td class="center">${myReplyList.memberNickname}</td>
								<td class="center">${myReplyList.boardCtime}</td>
								<td class="center">${myReplyList.boardReadcount}</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
				<div class="container">
				<div class="flex-container auto-width">
			<div class="col-2 left">
				<h4>내 문의글</h4>
			</div>
			<div class="col-2 right">
				<a class="link" href="myQnaList">더보기<i class="fa-regular fa-square-plus" style="color: #9aa1ac;"></i></a>
			</div>
			</div>
			<table class="table table-regular">
				<thead>
				<tr>
					<th width="50%">제목</th>
					<th>작성자</th>
					<th>작성일자</th>
				</tr>
				</thead>
				<tbody>
					<c:forEach var="myQnaList" items="${myQnaList}" varStatus="loop">
						<c:if test="${loop.index < 3}">
							<tr>
								<td class="left"><a class="link"
									href="/qnaNotice/detail?qnaNoticeNo=${myQnaList.qnaNoticeNo}">
								${myQnaList.qnaNoticeTitle}</a></td>
								<td class="center">${myQnaList.memberNickname}</td>
								<td class="center">${myQnaList.qnaNoticeTime}</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>



	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
