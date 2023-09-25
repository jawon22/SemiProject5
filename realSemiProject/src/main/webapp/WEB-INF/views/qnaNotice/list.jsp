<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<script>
$(function(){
	$(".noticehide").change(function(){
		
            var check = $(this).prop("checked");
            $(".mint10").prop("checked",check);

            if(check){
           	 $(".mint10").hide();
            }
            else{
           	 $(".mint10").show();
            }
		
		
	});
});
</script>

<div class="container w-700">

<div class="row">
	<a href="list">	
	<img src="/images/notice.png" width="250">
	</a>
</div>

<div class="row">
	<div class="btn">
	<a href="noticeList"><label>공지사항</label></a></div>
	<div class="btn"><label>Q&A</label></div> 
</div>

<c:if test="${vo.page == 1}">
<div class="row right">
	<input type="checkbox" class="noticehide"> 공지숨기기
</div>
</c:if>


<table class="table table-slit center">
<thead>
		<tr>
			<th width="10%">
				구분	
			</th>
			<th width="45%">
				제목	
			</th>
			<th width="25%">
				작성자	
			</th>
			<th width="20%">
				작성일	
			</th>
		</tr>
</thead>
<tbody>
	
<c:if test="${vo.page == 1}">
	<c:forEach var="noticeListTop5" items="${noticeListTop5}">
		<tr class="mint10">
			<td>
				[공지]
			</td>
			<td class="left">
			<a class="link" href="detail?qnaNoticeNo=${noticeListTop5.qnaNoticeNo}">
				${noticeListTop5.qnaNoticeTitle}	
			</a>
			</td>
			<td>
				${noticeListTop5.memberNickname}
			</td>
			<td>
				${noticeListTop5.qnaNoticeTime}
			</td>
		</tr>		
	</c:forEach>
	</c:if>

	
	<c:forEach var="qnaList" items="${qnaList}">
		<tr>
			<td>
				<c:if test="${qnaList.qnaNoticeType == 2}">
					[문의]
				</c:if>
				<c:if test="${qnaList.qnaNoticeType == 3}">
					[답변]
				</c:if>		
			</td>
			<td class="left">
			<c:forEach var="i" begin="1" 
			end="${qnaList.qnaNoticeDepth}" step="1">
			&nbsp;&nbsp;
			</c:forEach>
		
			<%-- 띄어쓰기 뒤에 화살표 표시 --%>
			<c:if test="${qnaList.qnaNoticeDepth > 0}">
				<i class="fa-solid fa-reply fa-rotate-180" style="color: #3dc1d3;"></i>
			</c:if>
	
			<a class="link" href="detail?qnaNoticeNo=${qnaList.qnaNoticeNo}">
				${qnaList.qnaNoticeTitle}	
			</a>
			
			<c:if test="${qnaList.qnaNoticeSecret == 'Y'}">
				<i class="fa-solid fa-lock" style="color: #3dc1d3;"></i>
			</c:if>

			</td>
			<td>
				${qnaList.memberNickname}
			</td>
			<td>
				${qnaList.qnaNoticeTime}
			</td>
		</tr>		
	</c:forEach>
	
</tbody>
</table>
</div>

<div class="row">
<form action="list" method="get" autocomplete="off">
	<select name="type">
		<option value="qnanotice_title">제목</option>
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
	<a href="list?${vo.prevQueryStringForMemberList}">&lt;</a>	
</c:if>

<!-- 숫자 부분 -->
<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">

	<c:choose>
		<c:when test="${vo.page == i}"> <!-- 현재페이지면 -->
			${i}
		</c:when>
		<c:otherwise>
			<a href="list?${vo.getQueryStringForMemberList(i)}">${i}</a>		
		</c:otherwise>
	</c:choose>
</c:forEach>

<!--  다음버튼 -->
<c:if test="${!vo.last}">
	<a href="list?${vo.nextQueryStringForMemberList}">&gt;</a>		
</c:if>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
