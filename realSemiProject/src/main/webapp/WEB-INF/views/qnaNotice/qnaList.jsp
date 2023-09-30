<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<div class="container w-800">

	<div class="row">
		<a class="link" href="list">
			<h2 class="crudTitle">Q&A</h2>
		</a>
	</div>

	<div class="row">

		<a class="link" href="noticeList"><span class="btn">공지사항</span></a> 
		<a class="link" href="qnaList"><span class="btn">Q&A</span></a>

	</div>

	<div class="row right">
		<div class="row right">
			<a class=" btn link" href="write">글쓰기</a>
		</div>

		<table class="table table-slit center">
			<thead>
				<tr>
					<th width="10%">구분</th>
					<th width="45%">제목</th>
					<th width="25%">작성자</th>
					<th width="20%">작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="qnaList" items="${qnaList}">
					<tr>
						<td><c:if test="${qnaList.qnaNoticeType == 2}">
					[문의]
				</c:if> <c:if test="${qnaList.qnaNoticeType == 3}">
					[답변]
				</c:if></td>
						<td class="left">
						<c:forEach var="i" begin="1"
								end="${qnaList.qnaNoticeDepth}" step="1">
			&nbsp;&nbsp;
			</c:forEach> 띄어쓰기 뒤에 화살표 표시 <c:if test="${qnaList.qnaNoticeDepth > 0}">
								<i class="fa-solid fa-reply fa-rotate-180"
									style="color: #3dc1d3;"></i>
							</c:if> <a class="link" href="detail?qnaNoticeNo=${qnaList.qnaNoticeNo}">
								${qnaList.qnaNoticeTitle} </a> <c:if
								test="${qnaList.qnaNoticeSecret == 'Y'}">
								<i class="fa-solid fa-lock" style="color: #3dc1d3;"></i>
							</c:if></td>
						<td>${qnaList.memberNickname}</td>
						<td>${qnaList.qnaNoticeTime}</td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
	</div>
</div>

<div class="row">
	<form action="qnaList" method="get" autocomplete="off">
		<select name="type" class="search-input">
			<option value="qnanotice_title">제목</option>
		</select> <input type="search" name="keyword" value="${param.keyword}"
			class="search-input" placeholder="검색어 입력" required>
		<button class="search-btn">검색</button>
	</form>
</div>



<div class="row">
	<c:if test="${!vo.first}">
		<a href="qnaList?${vo.prevQueryStringForMemberList}" class="prev">&lt;</a>
	</c:if>


	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">

		<c:choose>
			<c:when test="${vo.page == i}">

			${i}
		</c:when>
			<c:otherwise>
				<a href="qnaList?${vo.getQueryStringForMemberList(i)}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>


	<c:if test="${!vo.last}">
		<a href="qnaList?${vo.nextQueryStringForMemberList}" class="next">&gt;</a>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
