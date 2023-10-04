<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.title{
	font-size: 30px;
	font-weight: bold;
	color: #26C2BF;
}
/* .pagination-move, */
/* .pagination-select { */
/*    display: inline-block; */
/* } */
/* .pagination { */
/* 	color: white; */
/* 	text-decoration: none; */
/* 	transition: background-color .5s; */
/* 	border: 1px solid #DDD; */
/* 	margin: 0 4px; */
/* 	font-size: 20px */
/* } */

	
</style>


<div class="container w-800">

	<div class="row">
		<a href="blockList" class="link" ><span class="title">차단회원</span></a>
	</div>

<table class="table table-slit">
<thead>
	<tr>
		<th>
			닉네임
		</th>
		<th>
			아이디
		</th>
		<th>
			등급
		</th>
		<th>
			차단일
		</th>
		<th>
			관리
		</th>
	</tr>
</thead>

<tbody>
	<c:forEach var="blockList" items="${blockList}">
		<tr>
			<td>
				${blockList.memberNickname}
			</td>
			<td>
				${blockList.memberId}	
			</td>
			<td>
				${blockList.memberLevel}
			</td>
			<td>
				${blockList.blockTime}
			</td>
			<td>
			<a class="link" href="detail?memberId=${blockList.memberId}">
				회원관리 <i class="fa-solid fa-arrow-right" style="color: #78bdcf;"></i></a>
			</td>
		</tr>		
	</c:forEach>
</tbody>
</table>
</div>
<div class="row">
<form action="member/blockList" method="get" autocomplete="off">
	<select name="type" class="search-select">
		<option value="member_id">아이디</option>
		<option value="member_nickname">닉네임</option>
		<option value="member_email">이메일</option>
		<option value="member_birth">생년월일</option>
	</select>	
	<input type="search" name="keyword" 
		value="${param.keyword}" class="search-input"
		placeholder="검색어 입력" required>
	<button class="search-btn">검색</button>
</form>
</div>

<!-- 페이지 네비게이터 출력(목록) -->

<!-- 이전 버튼 -->
<div class="row page-navigator">
<c:if test="${!vo.first}">
	<a href="blockList?${vo.prevQueryStringForMemberList}">&lt;</a>	
</c:if>

<!-- 숫자 부분 -->
<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">

	<c:choose>
		<c:when test="${vo.page == i}"> <!-- 현재페이지면 -->
			<a style="background-color:rgb(215,241,242)">${i}</a>
		</c:when>
		<c:otherwise>
			<a href="blockList?${vo.getQueryStringForMemberList(i)}">${i}</a>		
		</c:otherwise>
	</c:choose>
</c:forEach>

<!--  다음버튼 -->
<c:if test="${!vo.last}">
	<a href="blockList?${vo.nextQueryStringForMemberList}" class="pagination-move">&gt;</a>		
</c:if>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>