<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- 댓글과 관련된 처리를 할 수 있도록 jQuery 코드 구현 -->
<style>
	.note-viewer {
	    line-height: 5 !important;
	}
</style>

<div class="container w-800">
	

<!-- 	<div class="row left"> -->
<!-- 		<h3> -->
<!-- 			<i class="fa-solid fa-user"></i> -->
<%-- 			${qnaNoticeDto.qnaNoticeMemberId} --%>
<%-- 			<%-- 탈퇴한 사용자가 아닐 경우 닉네임을 옆에 추가로 출력 --%> --%>
<%-- 			<c:if test="${qnaNoticeDto. != null}"> --%>
<%-- 			(${writerDto.memberNickname}) --%>
<%-- 			</c:if> --%>
<!-- 		</h3> -->
<!-- 	</div> -->
	
	<div class="row right">
		<fmt:formatDate value="${qnaNoticeDto.qnaNoticeTime}" pattern="y년 M월 d일 E a h시 m분 s초"/>
	</div>
	
	<div class="row left mint" >
		<h2>${qnaNoticeDto.qnaNoticeTitle}</h2>
	</div>
	<div class="row left" >
		<h2>${qnaNoticeDto.memberId}</h2>
	</div>
	
	<%-- 사진이 있으면 --%>

	<c:if test="${qnaNoticeDto.image}">
	<img src="image?qnaNoticeNo=${qnaNoticeDto.qnaNoticeNo}" width="200" height="200">
	</c:if>

	
	
	<%-- 게시글 내용(본문) --%>
	<div class="row left note-viewer" style="min-height:250px">
		<pre>${qnaNoticeDto.qnaNoticeContent}</pre>	
	</div>

		 
<%-- 글쓰기는 로그인 상태인 경우에만 출력 --%>

		<c:if test="${sessionScope.level == '관리자'}">
			<a href="write?qnaNoticeParent=${qnaNoticeDto.qnaNoticeNo}">답글</a>		
<!-- 		수정/삭제는 소유자일 경우에만 나와야 한다  -->
		<c:if test="${sessionScope.name == qnaNoticeDto.memberId}">
			<a href="edit?boardNo=${qnaNoticeDto.qnaNoticeDtoNo}">글수정</a>		
			<a href="delete?boardNo=${qnaNoticeDto.qnaNoticeDtoNo}">글삭제</a>
		</c:if>
		</c:if>
			<a href="list">목록으로</a>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>