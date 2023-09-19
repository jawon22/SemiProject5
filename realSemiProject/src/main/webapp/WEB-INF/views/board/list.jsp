<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="cantainer">
	<div class="row">
		<table class="table table-board">
			<thead>
				<tr>
					<th>계절</th>					
					<th>지역</th>					
					<th>제목</th>					
					<th>작성자</th>					
					<th>작성일</th>					
					<th>조회수</th>					
				</tr>			
			</thead>
			<tbody>
			<c:forEach var="boardDto" items="${list}">
				<tr>
					<th>${boardDto.boardCategory}</th>
				<a href="/detail">	<th>${boardDto.boardTitle}</th></a>
					<th>${boardDto.boardWriter}</th>
					<th>${boardDto.boardCtime}</th>
					<th>${boardDto.boardReplycount}</th>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<h2>정보게시판 목록</h2>

<c:if test="${vo.search}">
	&quot;${vo.keyword}"에 대한 검색 결과
</c:if>

<c:if test="${sessionScope.name !=null}">
		
			<c:if test="${sessionScope.level == '관리자'}">
			<button type="submit" class="btn btn-negative delete-btn">
				<i class="fa-solid fa-trash-can"></i>
				게시글 일괄삭제
			</button>
			</c:if>
			
			<a href="write" class="btn">
				<i class="fa-solid fa-pen"></i>
				게시글 작성
			</a>
			
</c:if>



<table>
	<thead>
		<tr>
			<c:if test="${sessionScope.lever =='관리자'}">
				<th>
				<!-- 전체선택 체크박스 -->
					<input type="checkbox" class="cb-all">
				</th>			
			</c:if>
			<th>계절</th>
			<th>지역</th>
			<th width="25%">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="boardDto" items="${list}">
			<tr>
				<c:if test="${sessionScope.level == '관리자'}">
				<td>
				<!-- 개별항목 체크박스 -->
				<input type="checkbox" class="check-item" name="boardNoList" 
					value="${boardDto.boardNo}">
					</td>
				</c:if>
				
				<!-- 계절  -->
				<td></td>
				
				<!-- 지역  -->
				<td></td>
				
				<td align="left">
				<!--  제목을 누르면 상세페이디로 이동 -->
					<a class="link" href="detail?boardNo=${boardDto.boardNo}">${boardDto.boardTitle}</a>
				
				<!--  댓글이 있다면 개수를 표시 -->
					<c:if test="${boardDto.boardReplycount >0}">
						&nbsp;&nbsp;
						<i class="fa-solid fa-comment blue"></i>
						${boardDto.boardReplycount}
					</c:if>
				</td>
				
				<!-- 작성자 -->
				<td>${boardListDto.getBoardWriterString()}</td>
				
				<!-- 작성일 -->
				<td>${boardDto.getBoardCtimeString()}</td>
				
				<!-- 조회수 -->
				<td>${boardDto.boardReadcount}</td>
			</tr>
		</c:forEach>
	
	</tbody>
</table>

<br>
	<c:if test="${vo.first ==false}">
		<a href="list?${vo.prevQueryString}">&lt;</a>
	</c:if>

	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
		<c:choose>
			<c:when test="${vo.page ==i}">  <!-- 현재 페이지면 --> 
				${i}			
			</c:when>
			<c:otherwise>
				<%-- 링크는 검색과 목록을 따로 구현 --%>
				<a href="list?${vo.getQueryString(i)}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	
	<!-- 다음 버튼 -->
	<c:if test="${!vo.last}">
		<%-- 링크는 검색과 목록을 따로 구현 --%>
			<a href="list?${vo.nextQueryString}">&gt;</a>
	</c:if>


	<!--  검색창 -->
	<form action="list" method="get">
		<div class="row">
			<c:choose>
				<c:when test="${param.type == 'board_writer'}">
					<select name="type" required class="form-input">
						<option value="board_title">제목</option>
						<option value="board_writer" selected>작성자</option>
					</select>
				</c:when>
				<c:otherwise>
						<select class="form-input" name="type" required>
							<option value="board_title">제목</option>
							<option value="board_writer">작성자</option>
						</select>
				</c:otherwise>
			</c:choose>
	
			<input type="search" name="keyword" placeholder="검색어를 입력하세요" value="${param.keyword}" class="form-input" required>		
			<button class="btn btn-positive" type="submit">
				<i class="fa-solid fa-magnifying-glass"></i>
				검색
			</button>
				
		</div>
	</form>
		







<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>