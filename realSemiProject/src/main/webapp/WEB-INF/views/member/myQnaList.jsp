<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.title {
	font-size: 30px;
	font-weight: bold;
	color: #26C2BF;
	margin-bottom:20px;
}

</style>


<div class="container w-700">

<div class="row">
	<h1 class="title">내 문의글</h1>
</div>

	<table class="table table-regular">
		<thead>
			<tr>

				<th width="65%">글제목</th>
				<th width="20%">작성자</th>
				<th width="15%">작성일자</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="qnaNoticeDto" items="${qnaNoticeDto}">
				<tr>

					<td class="left"><a class="link"
						href="${pageContext.request.contextPath}/qnaNotice/detail?qnaNoticeNo=${qnaNoticeDto.qnaNoticeNo}">
							${qnaNoticeDto.qnaNoticeTitle} </a></td>
					<td class="center">${memberDto.memberNickname}</td>
					<td class="center">${qnaNoticeDto.qnaNoticeTime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>



<div class="row">
<form action="myQnaList" method="get" autocomplete="off">
		<select name="type" class="search-select">
		<option value="qnanotice_title">제목</option>		
		</select>
		<input class="search-input" type="search" name="keyword" 
		value="${param.keyword}" 
		placeholder="검색어 입력">
	<button class="search-btn">검색</button>
</form>
</div>

<!-- 페이지 네비게이터 출력(목록) -->

<!-- 이전 버튼 -->
<div class="row page-navigator">
<c:if test="${!vo.first}">
	<a href="myQnaList?${vo.prevQueryStringForMemberList}">
		<i class="fa-solid fa-angle-left"></i>
	</a>	
</c:if>

<!-- 숫자 부분 -->
<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">

	<c:choose>
		<c:when test="${vo.page == i}"> <!-- 현재페이지면 -->
			<a style="background-color:rgb(215,241,242)">${i}</a> 
		</c:when>
		<c:otherwise>
			<a href="myQnaList?${vo.getQueryStringForMemberList(i)}">${i}</a>		
		</c:otherwise>
	</c:choose>
</c:forEach>
<!--  다음버튼 -->
<c:if test="${!vo.last}">
	<a href="myQnaList?${vo.nextQueryStringForMemberList}">
	<i class="fa-solid fa-angle-right"></i></a>		
</c:if>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
