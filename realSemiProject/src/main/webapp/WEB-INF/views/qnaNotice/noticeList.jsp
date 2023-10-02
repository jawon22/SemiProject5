<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.title{
		font-size: 40px;
		font-weight: bold;
		color: #26C2BF;
	}
</style>

<script>
	$(function() {
		$(".noticehide").change(function() {

			var check = $(this).prop("checked");
			$(".mint10").prop("checked", check);

			if (check) {
				$(".mint10").hide();
			} else {
				$(".mint10").show();
			}
		});

		//전체선택
		$(".checkbox-all").change(function() {
			var check = $(this).prop("checked");
			$(".checkbox-all, .check-item").prop("checked", check);

			if (check) {
				//	        	 $(".delete-btn").css("display","inline-block");
				//	        	 $(".delete-btn").show();
				$(".delete-btn").fadeIn("fast");
			} else {
				//	        	 $(".delete-btn").css("display","none");
				//	        	 $(".delete-btn").hide();
				$(".delete-btn").fadeOut("fast");
			}

		});

		//개별체크 박스
		$(".check-item").change(
				function() {

					//var allCheck - 개별체크박스 개수 == 체크된 개별체크 박스개수;
					// var allCheck = $(".check-item").length == $(".check-item:checked").length;
					var allCheck = $(".check-item").length == $(".check-item")
							.filter(":checked").length;
					$(".checkbox-all").prop("checked", allCheck);

					if ($(".check-item").filter(":checked").length > 0) {
						$(".delete-btn").fadeIn("fast");
					} else {
						$(".delete-btn").fadeOut("fast");
					}
				});

		$(".delete-form").submit(function(e) {
			return confirm("정말 삭제하시겠습니까?");
		});

	});
</script>

<div class="container w-800">

	<div class="row">
		<a class="link" href="list"><h1 class="title">공지사항</h1>
		</a>
	</div>

	<div class="row">
		<div class="btn">
			<a class="link" href="noticeList"><label>공지사항</label></a>
		</div>
		<div class="btn">
			<a class="link" href="qnaList"><label>Q&A</label></a>
		</div>
	</div>

	<div class="row right">

		<form class="delete-form" action="deleteByAdmin" method="post">
			<c:if test="${sessionScope.name !=null}">
				<div class="row right">
					<c:if test="${sessionScope.level == '관리자'}">
						<button type="submit" class="btn btn-negative delete-btn">
							<i class="fa-solid fa-trash-can"></i> 게시글 일괄삭제
						</button>
					</c:if>

					<a href="write" class="btn"> <i class="fa-solid fa-pen"></i>
						게시글 작성
					</a>
				</div>
			</c:if>



			<table class="table table-slit center">
				<thead>
					<tr>
						<c:if test="${sessionScope.level == '관리자'}">
							<th><input type="checkbox" class="checkbox-all"></th>
						</c:if>
						<th width="10%">구분</th>
						<th width="45%">제목</th>
						<th width="25%">작성자</th>
						<th width="20%">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="noticeList" items="${noticeList}">
						<tr>
							<c:if test="${sessionScope.level == '관리자'}">
								<td><input type="checkbox" class="check-item"
									name="qnaNoticeList" value="${noticeList.qnaNoticeNo}"></td>
							</c:if>
							<td><c:choose>
									<c:when test="${noticeList.qnaNoticeType == 1}">
									[공지]
								</c:when>
									<c:when test="${noticeList.qnaNoticeType == 2}">
									[문의]
								</c:when>
									<c:otherwise>
									[답변]							
								</c:otherwise>
								</c:choose></td>
							<td class="left"><c:forEach var="i" begin="1"
									end="${noticeList.qnaNoticeDepth}" step="1">
							&nbsp;&nbsp;
							</c:forEach> <c:if test="${noticeList.qnaNoticeDepth > 0}">
									<i class="fa-solid fa-reply fa-rotate-180"
										style="color: #3dc1d3;"></i>
								</c:if> <a class="link"
								href="detail?qnaNoticeNo=${noticeList.qnaNoticeNo}">
									${noticeList.qnaNoticeTitle} </a> <c:if
									test="${noticeList.qnaNoticeSecret == 'Y'}">
									<i class="fa-solid fa-lock" style="color: #3dc1d3;"></i>
								</c:if></td>
							<td>${noticeList.memberNickname}</td>
							<td>${noticeList.qnaNoticeTime}</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</form>
	</div>

	<div class="row">
		<form
			action="${vo.listType == 'noticelist' ? 'noticeList' : 'qnaList'}"
			method="get" autocomplete="off">
			<select name="type">
				<option value="qnanotice_title">제목</option>
			</select> <input type="search" name="keyword" value="${param.keyword}"
				placeholder="검색어 입력" required>
			<button>검색</button>
		</form>
	</div>


	<!-- 페이지 네비게이터 출력(목록) -->

<%-- 	<c:choose> --%>
<%-- 		<c:when test="${vo.listType == 'noticelist'}"> --%>
<!-- 			<!-- 공지사항 목록인 경우 --> 
<!-- 			<!-- 페이지 번호 목록 --> 
<!-- 			<!-- 이전 버튼 --> 
<!-- 			<div class="row"> -->
<%-- 				<c:if test="${!vo.first}"> --%>
<%-- 					<a href="noticeList?${vo.prevQueryStringForMemberList}">&lt;</a> --%>
<%-- 				</c:if> --%>

<!-- 				숫자 부분 -->
<%-- 				<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1"> --%>

<%-- 					<c:choose> --%>
<%-- 						<c:when test="${vo.page == i}"> --%>
<!-- 							현재페이지면 -->
<%-- 			${i} --%>
<%-- 		</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 							<a href="noticeList?${vo.getQueryStringForMemberList(i)}">${i}</a> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<%-- 				</c:forEach> --%>

<!-- 				 다음버튼 -->
<%-- 				<c:if test="${!vo.last}"> --%>
<%-- 					<a href="noticeList?${vo.nextQueryStringForMemberList}">&gt;</a> --%>
<%-- 				</c:if> --%>
<!-- 			</div> -->
<%-- 		</c:when> --%>
<%-- 		<c:when test="${vo.listType == 'qnalist'}"> --%>
<!-- 			<!-- Q&A 목록인 경우 --> 
<!-- 			<!-- 페이지 번호 목록 --> 
<!-- 			<!-- 이전 버튼 --> 
<!-- 			<div class="row"> -->
<%-- 				<c:if test="${!vo.first}"> --%>
<%-- 					<a href="qnaList?${vo.prevQueryStringForMemberList}">&lt;</a> --%>
<%-- 				</c:if> --%>

<!-- 				숫자 부분 -->
<%-- 				<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1"> --%>

<%-- 					<c:choose> --%>
<%-- 						<c:when test="${vo.page == i}"> --%>
<!-- 							현재페이지면 -->
<%-- 			${i} --%>
<%-- 		</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 							<a href="qnaList?${vo.getQueryStringForMemberList(i)}">${i}</a> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<%-- 				</c:forEach> --%>

<!-- 				 다음버튼 -->
<%-- 				<c:if test="${!vo.last}"> --%>
<%-- 					<a href="qnaList?${vo.nextQueryStringForMemberList}">&gt;</a> --%>
<%-- 				</c:if> --%>
<!-- 			</div> -->
<%-- 		</c:when> --%>
<%-- 	</c:choose> --%>
<c:choose>
    <c:when test="${vo.listType == 'noticelist'}">
        <!-- 공지사항 목록인 경우 -->
        <c:set var="listType" value="noticeList" />
    </c:when>
    <c:when test="${vo.listType == 'qnalist'}">
        <!-- Q&A 목록인 경우 -->
        <c:set var="listType" value="qnaList" />
    </c:when>
</c:choose>

<!-- 페이지 번호 목록 -->
<!-- 이전 버튼 -->
<div class="row page-navigator">
    <c:if test="${!vo.first}">
        <a href="${listType}?${vo.prevQueryStringForMemberList}">&lt;</a>
    </c:if>

    <!-- 숫자 부분 -->
    <c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
        <c:choose>
            <c:when test="${vo.page == i}">
                <!-- 현재페이지면 -->
                <a style="background-color:rgb(215,241,242)">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="${listType}?${vo.getQueryStringForMemberList(i)}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!--  다음버튼 -->
    <c:if test="${!vo.last}">
        <a href="${listType}?${vo.nextQueryStringForMemberList}">&gt;</a>
    </c:if>
</div>



</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
