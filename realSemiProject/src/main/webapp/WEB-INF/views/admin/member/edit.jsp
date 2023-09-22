<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-500">
<form action="infoChange" method="post" autocomplete="off">
	<input type="hidden" name="memberId" value="${memberDto.memberId}">
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
	</div>
	
	<div class="row">
	<button type="submit"> 수정하기 </button>
	</div>
	
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>