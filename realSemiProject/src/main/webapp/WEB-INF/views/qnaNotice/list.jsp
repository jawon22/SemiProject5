<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.title {
	font-size: 40px;
	font-weight: bold;
	color: #26C2BF;
}

/* .table.table-regular>tbody>tr:hover { */
/* 	filter: brightness(98%); */
/* 	box-shadow: 0 0 0 1px lightgray; */
/* } */

/* .table.table-regular>thead { */
/* 	background-color: #26c2bf28; */
/* } */

/* .table.table-regular>thead>tr>th, .table.table-regular>thead>tr>td { */
/* 	padding: 0.5em; */
/* 	border-top: 1px solid #2c3e50; */
/* 	border-bottom: 1px solid #2c3e50; */
/* } */

/* .table.table-regular>tbody>tr>th, .table.table-regular>tbody>tr>td { */
/* 	background-color: white; */
/* 	padding: 0.5em; */
/* 	border-bottom: 1px solid lightgray; */
/* } */

/* .table.table-regular>tfoot>tr, .table.table-regular>tfoot>tr { */
/* 	border-bottom: 1.5px solid #2c3e50; */
/* } */

.table.table-regular>tbody>tr.notice>td {
	background-color: #26c2bf28 !important;
}

</style>

<script>
	$(function() {
		$(".noticehide").change(function() {

			var check = $(this).prop("checked");
			$(".notice").prop("checked", check);

			if (check) {
				$(".notice").hide();
				$(".status").text("공지 보기");
			} else {
				$(".notice").show();
				$(".status").text("공지 숨기기");
			}

		});

		$(".status").click(function() {
			var check = $(".noticehide").prop("checked");
			$(".noticehide").prop("checked", !check).change();
		});

	});
</script>

<div class="container w-800">

	<div class="row">
		<a class="link" href="list">
			<h1 class="title">공지사항</h1>
		</a>
	</div>

	<div class="row">
		<a class="link" href="noticeList"><button class="btn">공지사항</button></a>
		<a class="link" href="qnaList"><button class="btn">Q&A</button></a>
	</div>

	<c:if test="${vo.page == 1}">
		<div class="row right">
			<label class="custom-checkbox"> <input type="checkbox"
				class="noticehide"> <span></span></label><label class="status">공지
				숨기기</label>
		</div>
	</c:if>

	<c:if test="${sessionScope.name !=null}">
		<div class="row right">
			<a href="write" class="btn"> <i class="fa-solid fa-pen"></i> 게시글
				작성
			</a>
		</div>
	</c:if>
	<table class="table table-regular  center">
		<thead>
			<tr>
				<th width="10%">구분</th>
				<th width="45%">제목</th>
				<th width="25%">작성자</th>
				<th width="20%">작성일</th>
			</tr>
		</thead>
		<tbody>

			<c:if test="${vo.page == 1}">
				<c:forEach var="noticeListTop5" items="${noticeListTop5}">
					<tr class="notice">
						<td>[공지]</td>
						<td class="left"><a class="link"
							href="detail?qnaNoticeNo=${noticeListTop5.qnaNoticeNo}">
								${noticeListTop5.qnaNoticeTitle} </a></td>
						<td>${noticeListTop5.memberNickname}</td>
						<td>${noticeListTop5.qnaNoticeTime}</td>
					</tr>
				</c:forEach>
			</c:if>


			<c:forEach var="qnaList" items="${qnaList}">
				<tr>
					<td><c:if test="${qnaList.qnaNoticeType == 2}">
					[문의]
				</c:if> <c:if test="${qnaList.qnaNoticeType == 3}">
					[답변]
				</c:if></td>
					<td class="left"><c:forEach var="i" begin="1"
							end="${qnaList.qnaNoticeDepth}" step="1">
			&nbsp;&nbsp;
			</c:forEach> <%-- 띄어쓰기 뒤에 화살표 표시 --%> <c:if test="${qnaList.qnaNoticeDepth > 0}">
							<i class="fa-solid fa-reply fa-rotate-180"
								style="color: #3dc1d3;"></i>
						</c:if> <a class="link" href="detail?qnaNoticeNo=${qnaList.qnaNoticeNo}">
							${qnaList.qnaNoticeTitle} </a> <c:if
							test="${qnaList.qnaNoticeSecret == 'Y'}">
							<i class="fa-solid fa-lock" style="color: #3dc1d3;"></i>
						</c:if></td>
					<td>${qnaList.getQnaNoticeWriterString()}</td>
					<td>${qnaList.getQnaNoticeTimeString()}</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
</div>

<div class="row">
	<form action="list" method="get" autocomplete="off">
		<select name="type" class="search-select">
			<option value="qnanotice_title" class="search-input">제목</option>
			<option value="member_nickname" class="search-input">작성자</option>
		</select> <input type="search" name="keyword" value="${param.keyword}"
			class="search-input" placeholder="검색어 입력" required>
		<button class="search-btn">검색</button>
	</form>
</div>


<!-- 페이지 네비게이터 출력(목록) -->

<!-- 이전 버튼 -->
<div class="row page-navigator">

	<c:if test="${!vo.first}">
		<a href="list?${vo.prevQueryStringForMemberList}" class="prev">&lt;</a>
	</c:if>

	<!-- 숫자 부분 -->
	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">

		<c:choose>
			<c:when test="${vo.page == i}">
				<!-- 현재페이지면 -->
				<a style="background-color:rgb(215,241,242)">${i}</a>
			</c:when>
			<c:otherwise>
				<a href="list?${vo.getQueryStringForMemberList(i)}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<!--  다음버튼 -->
	<c:if test="${!vo.last}">
		<a href="list?${vo.nextQueryStringForMemberList}" class="next">&gt;</a>
	</c:if>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
