<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.title {
	font-size: 30px;
	font-weight: bold;
	color: #26C2BF;
	margin-bottom:20px;
}
</style>

<script>
$(function(){
	
	  var listType = "${vo.listType}";

	    if (listType == "mywritelist") {
	      $("#myForm").attr("action", "myWriteList");
	      $(".title").text("내가 작성한 글")
	    } else if (listType == "mylikelist") {
	      $("#myForm").attr("action", "myLikeList");
	      $(".title").text("내가 좋아요 한 글")
	    } else {
	      $("#myForm").attr("action", "myReplyList");
	      $(".title").text("내가 댓글 단 글")
	    }
	
	
});


</script>

<div class="container w-700">

<div class="row">
	<h1 class="title"></h1>
</div>

<table class="table table-regular center">
<thead>
	<tr>
		<th width="60%">글제목</th>
		<th>작성자</th>
		<th>작성일자</th>
		<th width="10%">조회수</th>
	</tr>
</thead>

<tbody>
	<c:forEach var="boardDto" items="${boardDto}">
		<tr>

			<td class="left">
				<a class="link" href="${pageContext.request.contextPath}/board/detail?boardNo=${boardDto.boardNo}">
				${boardDto.boardTitle}
				</a>
			</td>
			<td>
				${boardDto.memberNickname}
			</td>
			<td>
				${boardDto.boardCtime}
			</td>
			<td>${boardDto.boardReadcount}</td>
		</tr>		
	</c:forEach>
</tbody>
</table>
</div>

<div class="row">
<form id="myForm" method="get" autocomplete="off">
	<select name="type" class="search-select">
		<option value="board_title">제목</option>
	</select>
<!-- 	<input type="select" value="board_title" name="type"> -->
	<input class="search-input" type="search" name="keyword" 
		value="${param.keyword}" 
		placeholder="검색어 입력">
	<button class="search-btn">검색</button>
</form>
</div>


<!-- 페이지 네비게이터 출력(목록) -->
<c:if test="${vo.listType == 'mywritelist'}">
    
	<!-- 이전 버튼 -->
	<div class="row page-navigator">
	<c:if test="${!vo.first}">
		<a href="myWriteList?${vo.prevQueryStringForMemberList}">&lt;</a>	
	</c:if>
	
	<!-- 숫자 부분 -->
	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
	
		<c:choose>
			<c:when test="${vo.page == i}"> <!-- 현재페이지면 -->
				<a style="background-color:rgb(215,241,242)">${i}</a>
			</c:when>
			<c:otherwise>
				<a href="myWriteList?${vo.getQueryStringForMemberList(i)}">${i}</a>		
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<!--  다음버튼 -->
	<c:if test="${!vo.last}">
		<a href="myWriteList?${vo.nextQueryStringForMemberList}">&gt;</a>		
	</c:if>
	</div>
</c:if>

<c:if test="${vo.listType == 'mylikelist'}">
    
<!-- 이전 버튼 -->
	<div class="row page-navigator">
	<c:if test="${!vo.first}">
		<a href="myLikeList?${vo.prevQueryStringForMemberList}">&lt;</a>	
	</c:if>
	
	<!-- 숫자 부분 -->
	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
	
		<c:choose>
			<c:when test="${vo.page == i}"> <!-- 현재페이지면 -->
				<a style="background-color:rgb(215,241,242)">${i}</a>
			</c:when>
			<c:otherwise>
				<a href="myLikeList?${vo.getQueryStringForMemberList(i)}">${i}</a>		
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<!--  다음버튼 -->
	<c:if test="${!vo.last}">
		<a href="myLikeList?${vo.nextQueryStringForMemberList}">&gt;</a>		
	</c:if>
	</div>
</c:if>

<c:if test="${vo.listType == 'myreplylist'}">
    
	<!-- 이전 버튼 -->
	<div class="row page-navigator">
	<c:if test="${!vo.first}">
		<a href="myreplylist?${vo.prevQueryStringForMemberList}">&lt;</a>	
	</c:if>
	
	<!-- 숫자 부분 -->
	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
	
		<c:choose>
			<c:when test="${vo.page == i}"> <!-- 현재페이지면 -->
				<a style="background-color:rgb(215,241,242)">${i}</a>
			</c:when>
			<c:otherwise>
				<a href="myreplylist?${vo.getQueryStringForMemberList(i)}">${i}</a>		
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<!--  다음버튼 -->
	<c:if test="${!vo.last}">
		<a href="myreplylist?${vo.nextQueryStringForMemberList}">&gt;</a>		
	</c:if>
	</div>
</c:if>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
