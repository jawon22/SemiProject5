<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-700">

	<table class="table table-slit">
		<thead>
			<tr>

				<th width="50%">글제목</th>
				<th>작성자</th>
				<th>작성일자</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="qnaNoticeDto" items="${qnaNoticeDto}">
				<tr>

					<td class="left"><a class="link"
						href="/qnaNotice/detail?qnaNoticeNo=${qnaNoticeDto.qnaNoticeNo}">
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
	<select name="type">
		<option value="qnanotice_title">제목</option>
		<option value="member_nickname">닉네임</option>
	</select>	
	<input type="search" name="keyword" 
		value="${param.keyword}" 
		placeholder="검색어 입력" required>
	<button>검색</button>
</form>
</div>

<!-- 페이지 네비게이터 출력(목록) -->

<!-- 이전 버튼 -->
<div class="row">
<c:if test="${!vo.first}">
	<a href="myQnaList?${vo.prevQueryStringForMemberList}">&lt;</a>	
</c:if>

<!-- 숫자 부분 -->
<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">

	<c:choose>
		<c:when test="${vo.page == i}"> <!-- 현재페이지면 -->
			${i}
		</c:when>
		<c:otherwise>
			<a href="myQnaList?${vo.getQueryStringForMemberList(i)}">${i}</a>		
		</c:otherwise>
	</c:choose>
</c:forEach>
<!--  다음버튼 -->
<c:if test="${!vo.last}">
	<a href="myQnaList?${vo.nextQueryStringForMemberList}">&gt;</a>		
</c:if>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
