<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
$(function(){
	$(".profile-chooser").change(function(){
		
		var input = this;
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
					"/rest/member/download?attachmentNo="+response.attachmentNo);
			},
			error:function(){
				window.alert("잠시 후 다시 시도해주세요");
			},
		});
		
	});	
});
</script>

	<div class="container w-500">
	<div class="flex-container auto-width">
		
		<div class="row mv-10 w-25">
			<c:choose>
				<c:when test="${profile == null}">
					<img src="https://dummyimage.com/130x130/000/fff"
						class="image image-circle image-border profile-image">
				</c:when>
				<c:otherwise>
					<img src="/rest/member/download?attachNo=${profile}"
						width="130" height="130" 
						class="image image-circle image-border profile-image">
				</c:otherwise>
			</c:choose>
		<label>
		<input type="file" class="profile-chooser" accept="image/*" style="display:none;">
		<i class="fa-solid fa-user fa-2x"></i>	
		</label>
		</div>
		<div class="row w-75 left" style="margin-top:20%;">	
		<i class="fa-solid fa-trash-can fa-2x profile-delete"></i>
		</div>
		
		</div>
		
		<div class="row">
			<table border="1" class="table-stripe">
				<tr>
					<th>아이디</th>
					<td>${memberDto.memberId}
				</tr>
				<tr>
					<th>닉네임</th>
					<td>${memberDto.memberNickname}
				</tr>
				<tr>
					<th>이메일</th>
					<td>${memberDto.memberEmail}
				</tr>
				<tr>
					<th>지역</th>
					<td>${memberDto.memberArea}
				</tr>
				<tr>
					<th>회원등급</th>
					<td>${memberDto.memberLevel}
				</tr>
				<tr>
					<th>포인트</th>
					<td>${memberDto.memberPoint}
				</tr>
			</table>
			
			<div class="row">
			<a href="exit">탈퇴하기</a>
			</div>
			<div class="row">
			<a href="infoChange">회원정보변경하기</a>
			</div>
			<div class="row">
			<a href="pwChange">비밀번호변경하기</a>
			</div>
			
			<div class="row" > <!-- flex-container로 단을 나눌것임 -->
			<a href="/mylike">내가 좋아요 누른 글 보러가기 > </a>		
			</div>
			<div class="row" > <!-- flex-container로 단을 나눌것임 -->
			<a href="myWriteList">내가 쓴 글 보러가기 > </a>		
			</div>
			<div class="row">
			<a href="logout">로그아웃</a>
			</div>
		</div>
	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
