<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.btn {
	font-size:12px;
	padding:0.3em;
}
</style>

<script>
$(function(){
	
	$(".profile-delete").click(function(){
		
		var choice = window.confirm("정말 프로필을 지우시겠습니까?");
		if(choice == false) return;
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

		</div>
		<div class="row w-75 left" style="margin-top:18%; margin-left:5%; margin-bottom:none;">	
			<h1>${memberDto.memberId} <i class="fa-solid fa-crown" style="color: #74b6c8;"></i></h1>
		</div>
		<c:if test="${attachNo != null}">
			<div>
				<i class="fa-solid fa-circle-xmark profile-delete" style="color: #78bdcf; margin-right:100%;"></i>
			</div>
		</c:if>
		
		</div>
			
		<div class="row">
				<table class="table table-stripe">
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
					<i class="fa-solid fa-p fa-xs" style="color: #001c40;"></i></td>
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
			
			<div class="row">
			<a class="link" href="list">목록</a>
			</div>
			<div class="row">
			<a class="link" href="#">차단(토글로설정)</a>
			</div>
			<div class="row">
			<a class="link" href="edit?memberId=${memberDto.memberId}">회원정보변경하기(등급만수정)</a>
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
	