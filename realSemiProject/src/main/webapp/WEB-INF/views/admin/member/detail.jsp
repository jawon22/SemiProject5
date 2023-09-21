<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>

<script>
$(function(){
	
	$(".profile-delete").click(function(){
		
		$.ajax({
			url:"http://localhost:8080/rest/member/delete",
			method:"post",
			success:function(response) {
				$(".profile-image").attr("src", "https://dummyimage.com/130x130/000/fff");
			},		
		});	
	});	
});
</script>

	<div class="container w-500 mt-20">
	<div class="flex-container auto-width">
		
		<div class="row mv-10 w-25">

			<c:choose>

				<c:when test="${attachNo == null}">
					<img src="https://dummyimage.com/130x130/000/fff" width="130" height="130"
						class="image image-circle image-border profile-image">
				</c:when>
				<c:otherwise>
				<img src="/rest/member/download?attachNo=${attachNo}" width="130" height="130"
				class="image image-circle image-border profile-image">
				</c:otherwise>
			</c:choose>
		<label class="row">
		<i class="fa-solid fa-trash profile-delete" style="color: #78bdcf;"></i>
		</label>
		</div>
		<div class="row w-75 left" style="margin-top:18%; margin-left:5%; margin-bottom:none;">	
		<h1>${memberDto.memberId}</h1>
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
			<a class="link" href="#">차단(토글로설정)</a>
			</div>
			<div class="row">
			<a class="link" href="#">회원정보변경하기(등급만수정)</a>
			</div>
			<div class="row">
				<h1>활동내역</h1>
				<table class="table table-stripe">
					<tbody>
						<c:forEach var="boardDto" items="${boardList}">
							<tr>
								<th>
									${boardDto.boardTitle}	
								</th>
								<th>
									${boardDto.boardWriter}
								</th>
							</tr>		
						</c:forEach>
					</tbody>
				</table>
			</div>

		</div>
	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	