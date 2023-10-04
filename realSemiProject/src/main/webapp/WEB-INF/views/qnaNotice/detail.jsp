<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- 댓글과 관련된 처리를 할 수 있도록 jQuery 코드 구현 -->
<style>
	.note-viewer {
		border:1px solid black;
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
     .content{
  padding:10px;
	/*   overflow:auto; */
	overflow-wrap: break-word;
	word-wrap: break-word;
	height: auto;
  }
  .custom-hr{
  	border:1px solid #26C2BF;
  	opacity: 0.5;
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
	<div class="row mb-50">
		<c:choose>
			<c:when test="${qnaNoticeDto.qnaNoticeType==1}">
				<img class="center" src="/images/notice.png" width="180" height="80">
			</c:when>
			<c:otherwise>
				<img class="center" src="/images/Q&A.png" width="150" height="80">
			</c:otherwise>
		</c:choose>
	</div>
	<div class="flex-container mb-20">
		<div class="left w-50" >
			<h2>${qnaNoticeDto.qnaNoticeTitle}</h2>
		</div>
	
		<div class="right w-50">
			<fmt:formatDate value="${qnaNoticeDto.qnaNoticeTime}" pattern="y년 M월 d일"/>
		</div> 
	</div>
	<div class="row left" >
		<div class="flex-container">
		<div class="left">
		<c:choose>
				<c:when test="${attachNo == null}">
					<img src="/images/user.png" width="50" height="50"
						class="image image-circle image-border profile-image">
				</c:when>
				<c:otherwise>
				<img src="/rest/member/download?attachNo=${attachNo}" width="50" height="50"
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

	
	<hr class="custom-hr">
	<%-- 게시글 내용(본문) --%>
	<div class="row left note-viewer mt-20" style="min-height:250px">
		<pre class="content">${qnaNoticeDto.qnaNoticeContent}</pre>	
	</div>

<div class="right"> 
<!-- 글 수정 및 삭제 버튼은 로그인 상태에서만 표시 -->
<c:if test="${sessionScope.name != null}">
    <!-- 글 수정 및 삭제는 소유자일 경우에만 나와야 한다 -->
    <c:if test="${sessionScope.name == qnaNoticeDto.memberId}">
        <a href="edit?qnaNoticeNo=${qnaNoticeDto.qnaNoticeNo}"><button class="btn btn-positive">수정</button></a>        
        <a href="delete?qnaNoticeNo=${qnaNoticeDto.qnaNoticeNo}"><button class="btn btn-positive">삭제</button></a>
    </c:if>
    
    <!-- 답글 버튼은 관리자일 경우에만 표시 -->
    <c:if test="${sessionScope.level == '관리자'}">
        <a href="write?qnaNoticeParent=${qnaNoticeDto.qnaNoticeNo}"><button class="btn btn-positive">답글</button></a>
    </c:if>
</c:if>
			<a href="list"><button  class="btn btn-positive	">목록</button></a>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>