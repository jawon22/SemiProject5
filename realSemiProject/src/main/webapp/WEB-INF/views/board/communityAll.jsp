<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<style>
h1,
h2 {
	color: #26C2BF;
}
h4{
	color: gray;
}
</style>
    
<script>
	$(function(){
		$(".title").each(function() {
			var originalString = $(this).text();
			var maxLength = 10;

			if (originalString.length >= maxLength) {
				// 제한된 길이보다 긴 경우 말줄임표 추가
				var limitedString = originalString.slice(0,
						maxLength)
						+ '<i class="fa-solid fa-ellipsis" style="color: #778192;"></i>';
			} 
			else {
				var limitedString = originalString;
			}
			$(this).html(limitedString);
		});
		
	});

</script>
    
    <div class="container w-900">
    	<div class="row">
			<h1>TRIPEE 인기 게시글</h1>
			<h4>여행자들이 많이 보고 있는 게시글이에요!</h4>
    	</div>
    	
		<div class="flex-container ">
    		<div style="width:425px">
    			<div class="left">
    				<h2>자유게시판</h2>
    			</div>
    			<div class="right">
    				<a class="link" href="/board/freeList">자유게시판 더보기
    					<i class="fa-regular fa-square-plus" style="color: #a6adb9;"></i>
    				</a>
    			</div>
    			
    			<div class="left">
    				<table class="table table-slit table-regular">
    					<thead>
							<tr>
								<th width="15%">순위</th>
								<th width="50%" align="left">제목</th>
								<th align="center">작성자</th>
							</tr>
						</thead>
    				
    					<tbody>
		    				<c:forEach var="boardListDto" items="${freeList}">
								<tr>
									<td align="center">${boardListDto.ranking}</td>
									<td align="left">
											<!--  제목을 누르면 상세페이지로 이동 -->
										<c:choose>
											<c:when test="${boardListDto.reportCount >= 5}">
												<span class="title" style="color:gray;">블라인드 처리된 글입니다</span>
										</c:when>
											<c:otherwise>
												<a class="link" href="/board/detail?boardNo=${boardListDto.boardNo}">
												<span class="title">${boardListDto.boardTitle}</span></a>
											
													<!--  댓글이 있다면 개수를 표시 -->
												<c:if test="${boardListDto.boardReplycount >0}">
													&nbsp;&nbsp;
													<i class="fa-solid fa-comment" style="color: #78bdcf;"></i>
												</c:if>
											</c:otherwise>
										</c:choose>
									</td>
									
									<!-- 작성자 -->
									<td align="center">${boardListDto.getBoardWriterString()}</td>
								</tr>    				
		    				</c:forEach>
    					</tbody>
    				</table>
    			</div>
    			
    		</div>
    		
    		<div style="width:425px; margin-left:50px">
    			<div class="left">
    				<h2>후기게시판</h2>
    			</div>
    			<div class="right">
    				<a class="link" href="/board/reviewList">후기게시판 더보기
    					<i class="fa-regular fa-square-plus" style="color: #a6adb9;"></i>
    				</a>
    			</div>
    			<div class="left">
    				<table class="table table-slit table-regular">
    					<thead>
							<tr>
								<th width="15%">순위</th>
								<th width="50%" align="left">제목</th>
								<th align="center">작성자</th>
							</tr>
						</thead>
    				
    					<tbody>
		    				<c:forEach var="boardListDto" items="${reviewList}">
								<tr>
									<td align="center">${boardListDto.ranking}</td>
									<td align="left">
											<!--  제목을 누르면 상세페이지로 이동 -->
										<c:choose>
											<c:when test="${boardListDto.reportCount >= 5}">
												<span class="title" style="color:gray;">블라인드 처리된 글입니다</span>
											</c:when>
											<c:otherwise>
												<a class="link" href="/board/detail?boardNo=${boardListDto.boardNo}">
												<span class="title">${boardListDto.boardTitle}</span></a>
											
													<!--  댓글이 있다면 개수를 표시 -->
												<c:if test="${boardListDto.boardReplycount >0}">
													&nbsp;&nbsp;
													<i class="fa-solid fa-comment" style="color: #78bdcf;"></i>
												</c:if>
											</c:otherwise>
										</c:choose>
									</td>
									
									<!-- 작성자 -->
									<td align="center">${boardListDto.getBoardWriterString()}</td>
								</tr>    				
		    				</c:forEach>
    					</tbody>
    				</table>
    			</div>
    			
    		</div>
    		
		</div>    	
    </div>
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>