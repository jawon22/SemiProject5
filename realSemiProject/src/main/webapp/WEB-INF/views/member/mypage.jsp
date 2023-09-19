<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


	<div class="container w-500">
		<div class="row">
			프로필사진공간
		</div>
		<div class="row">
			<table border="1">
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
			<a href="/member/exit">탈퇴하기</a>
			</div>
			<div class="row">
			<a href="/infochange">회원정보변경하기</a>
			</div>
			<div class="row">
			<a href="/pwchange">비밀번호변경하기</a>
			</div>
			
			<div class="row" > <!-- flex-container로 단을 나눌것임 -->
			<a href="/mylike">내가 좋아요 누른 글 보러가기 > </a>		
			</div>
			<div class="row" > <!-- flex-container로 단을 나눌것임 -->
			<a href="/mywrite">내가 쓴 글 보러가기 > </a>		
			</div>
		</div>
	</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
