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
	/* 가운데 정렬 스타일 */
     /* 부모 컨테이너 스타일 */
     .center-container {
         display: flex; /* 요소를 flex 컨테이너로 지정 */
         justify-content: center; /* 수평 가운데 정렬 */
         align-items: center; /* 수직 가운데 정렬 */
         height: 100vh; /* 뷰포트 높이와 같은 높이로 설정 */
     }

     /* 가운데로 정렬할 요소의 스타일 */
     .centered-element {
         /* 원하는 스타일을 여기에 추가 */
     }
</style>

<div class="container w-800">
	

<!-- 	<div class="row left"> -->
<!-- 		<h3> -->
<!-- 			<i class="fa-solid fa-user"></i> -->
<%-- 			${qnaNoticeDto.qnaNoticeMemberId} --%>
<%-- 			<%-- 탈퇴한 사용자가 아닐 경우 닉네임을 옆에 추가로 출력 --%>
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
		<div class="flex-container">
		<div class="left">
		<c:choose>
				<c:when test="${attachNo == null}">
					<img src="https://dummyimage.com/50x50/000/fff" width="50" height="50"
						class="image image-circle image-border profile-image">
				</c:when>
				<c:otherwise>
				<img src="/rest/member/download?attachNo=${attachDto.attachNo}" width="80" height="80"
				class="image image-circle image-border profile-image">
				</c:otherwise>
			</c:choose>	
		</div>
			<div class="left">
				<h2 class="mt-10 ms-10">${qnaNoticeDto.memberId}</h2>
			</div>
		</div>
	</div>
	
	<%-- 사진이 있으면 --%>

<%-- 	<c:if test="${qnaNoticeDto.image}">
	<img src="image?qnaNoticeNo=${qnaNoticeDto.qnaNoticeNo}" width="200" height="200">
	</c:if> --%>

	
	
	<%-- 게시글 내용(본문) --%>
	<div class="row left note-viewer" style="min-height:250px">
		<pre>${qnaNoticeDto.qnaNoticeContent}</pre>	
	</div>

		 
<!-- 글 수정 및 삭제 버튼은 로그인 상태에서만 표시 -->
<c:if test="${sessionScope.name != null}">
    <!-- 글 수정 및 삭제는 소유자일 경우에만 나와야 한다 -->
    <c:if test="${sessionScope.name == qnaNoticeDto.memberId}">
        <a href="edit?qnaNoticeNo=${qnaNoticeDto.qnaNoticeNo}">글 수정</a>        
        <a href="delete?qnaNoticeNo=${qnaNoticeDto.qnaNoticeNo}">글 삭제</a>
    </c:if>
    
    <!-- 답글 버튼은 관리자일 경우에만 표시 -->
    <c:if test="${sessionScope.level == '관리자'}">
        <a href="write?qnaNoticeParent=${qnaNoticeDto.qnaNoticeNo}">답글</a>
    </c:if>
</c:if>
			<a href="list">목록으로</a>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>