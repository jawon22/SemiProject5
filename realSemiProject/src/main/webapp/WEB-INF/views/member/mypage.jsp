<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
$(function(){
	$(".profile-chooser").change(function(){
		
		var input = $(".profile-chooser")[0];
		if(input.files.length == 0) return;
		
		var form = new FormData();
		form.append("attach", input.files[0]);
			
		$.ajax({
			url:"/rest/member/upload",
			method:"post",
			processData:false,
			contentType:false,
			data:form,
			success:function(response) {
				$(".profile-image").attr("src",
					"/rest/member/download?attachNo="+response.attachNo);
			},
			error:function(){
				window.alert("잠시 후 다시 시도해주세요");
			},
		});
			
	});	
	
	$(".profile-delete").click(function() {
		var choice = window.confirm("정말 프로필을 지우시겠습니까?");
		if(choice == false) return;
		$.ajax({
			url:"/rest/member/delete",
			method:"post",
			success:function(response) {
				$(".profile-image").attr("src", "/images/user.png");
			},		
		});	
	});	
});
</script>

	<div class="container w-500 mt-20">
	<div class="flex-container auto-width">
		
		<div class="row mv-10 w-25">
		<label>
			<c:choose>
				<c:when test="${profile == null}">
					<img src="/images/user.png" width="130" height="130"
						class="image image-circle image-border profile-image">
				</c:when>
				<c:otherwise>
				<img src="/rest/member/download?attachNo=${profile}" width="130" height="130"
				class="image image-circle image-border profile-image">
				</c:otherwise>
			</c:choose>
		<input type="file" class="profile-chooser" accept="image/*" style="display:none;">
		</label>
		</div>
		
		<c:if test="${profile != null}">
		<div>
		<i class="fa-solid fa-circle-xmark profile-delete " style="color: #78bdcf; margin-right:100%;"></i>
		</div>
		</c:if>
		
		<div class="row w-75 left" style="margin-top:18%; margin-left:5%; margin-bottom:none;">	
		<h1>${memberDto.memberId} <i class="fa-solid fa-crown fa-bounce" style="color: #74b6c8;"></i></h1>
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
					<td>${memberDto.memberPoint} <label>p</label></td>
				</tr>
				<tr>
					<th>가입일</th>
					<td><fmt:formatDate value="${memberDto.memberJoin}" 
									pattern="y년 M월 d일 E a h시 m분 s초"/></td>
										
				</tr>
				<tr>
					<th>마지막 접속일</th>
					<td><fmt:formatDate value="${memberDto.memberLogin}" 
									pattern="y년 M월 d일 E a h시 m분 s초"/></td>
				</tr>
			</table>
			
			
			<div class="flex-container auto-width"> <!-- flex-container로 단을 나눌것임 -->
			<div class="flex-container col-2">
			<a class="link flex-container row" href="myLikeList">내가 좋아요 누른 글 보러가기 > </a>		
			</div>
			<div class="flex-container col-2">
			<!-- flex-container로 단을 나눌것임 -->
				<a class="link flex-container row" href="myWriteList">내가 쓴 글 보러가기 > </a>		
					<br>
				<div class="row">
					<table>
						<tbody>
		<%-- 					<c:forEach var="boardDto" items="${myWriteList}"> --%>
								<tr>
									<th>
										제목
									</th>
									<th>
										작성자
									</th>
								</tr>		
		<%-- 					</c:forEach> --%>
						</tbody>
					</table>
				</div>
			</div>
			</div>
			<div class="row">
			<a class="link" href="exit">탈퇴하기</a>
			</div>
			<div class="row">
			<a class="link" href="infoChange">회원정보변경하기</a>
			</div>
			<div class="row">
			<a class="link" href="pwChange">비밀번호변경하기</a>
			</div>
			<div class="row">
			<a class="link" href="logout">로그아웃</a>
			</div>
		</div>
	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
