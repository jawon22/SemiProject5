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
    				<table class="table table-slit">
    					<thead>
							<tr>
								<th width="10%">순위</th>
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
										<a class="link" href="/board/detail?boardNo=${boardListDto.boardNo}">
										${boardListDto.boardTitle}</a>
									
											<!--  댓글이 있다면 개수를 표시 -->
										<c:if test="${boardListDto.boardReplycount >0}">
											&nbsp;&nbsp;
											<i class="fa-solid fa-comment" style="color: #78bdcf;"></i>
											<%-- <label>${boardListDto.boardReplycount}</label> --%>
										</c:if>
										<c:if test="${boardListDto.attachmentNo !=0}">
											<i class="fa-regular fa-image"></i>
										</c:if>
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
    				<table class="table table-slit">
    					<thead>
							<tr>
								<th width="10%">순위</th>
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
										<a class="link" href="/board/detail?boardNo=${boardListDto.boardNo}">
										${boardListDto.boardTitle}</a>
									
											<!--  댓글이 있다면 개수를 표시 -->
										<c:if test="${boardListDto.boardReplycount >0}">
											&nbsp;&nbsp;
											<i class="fa-solid fa-comment" style="color: #78bdcf;"></i>
											<%-- <label>${boardListDto.boardReplycount}</label> --%>
										</c:if>
										<c:if test="${boardListDto.attachmentNo !=0}">
											<i class="fa-regular fa-image"></i>
										</c:if>
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