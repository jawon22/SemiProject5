<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	$(function(){
		$(".delete-btn").hide();
		 
		 	//전체선택
	    $(".checkbox-all").change(function(){
	        var check = $(this).prop("checked");
	        $(".checkbox-all, .check-item").prop("checked",check);
	
	        if(check){
	//        	 $(".delete-btn").css("display","inline-block");
	//        	 $(".delete-btn").show();
	       	 $(".delete-btn").fadeIn("fast");
	        }
	        else{
	//        	 $(".delete-btn").css("display","none");
	//        	 $(".delete-btn").hide();
	       	 $(".delete-btn").fadeOut("fast");
	        }
	        
	    });
		
		 	//개별체크 박스
	    $(".check-item").change(function(){
	
	        //var allCheck - 개별체크박스 개수 == 체크된 개별체크 박스개수;
	        // var allCheck = $(".check-item").length == $(".check-item:checked").length;
	        var allCheck = $(".check-item").length == $(".check-item").filter(":checked").length;
	        $(".checkbox-all").prop("checked",allCheck);
	        
	        if($(".check-item").filter(":checked").length >0){
	       	 $(".delete-btn").fadeIn("fast");
	        }
	        else{
	       	 $(".delete-btn").fadeOut("fast");
	        }
	    });
		 
	    $(".delete-form").submit(function(e){
	    	return confirm("정말 삭제하시겠습니까?");
	    });
	
	});

</script>

<div class="container w-800">
	<div class="row">
		<a class="link" href="reviewList"><h2 class="crudTitle">후기게시판</h2></a>
	</div>
	
	<c:if test="${vo.search}">
		${vo.keyword}에 대한 검색 결과
	</c:if>
	
	<!--  검색창 -->
	<form action="reviewList" method="get">
		<div class="row">
			<select style="height:35px;" name="type" required class="form-input">
				<option value="board_title" ${param.type =='board_title' ? 'selected' :''}>제목</option>
				<option value="board_writer" ${param.type =='board_writer' ? 'selected' :''}>작성자</option>
			</select>
	
			<input type="search" name="keyword" placeholder="검색어를 입력하세요" value="${param.keyword}" class="form-input" required>		
			<button class="btn btn-positive" type="submit">
				<i class="fa-solid fa-magnifying-glass"></i>
				검색
			</button>
				
		</div>
	</form>
	
	<!-- 후기 게시글 목록  -->
	<form class="delete-form" action="deleteByAdmin" method="post">
		<c:if test="${sessionScope.name !=null}">
				<div class="row right">
					<c:if test="${sessionScope.level == '관리자'}">
					<button type="submit" class="btn btn-negative delete-btn">
						<i class="fa-solid fa-trash-can"></i>
						게시글 일괄삭제
					</button>
					</c:if>
					
					<a href="/board/write?boardCategory=41" class="btn">
						<i class="fa-solid fa-pen"></i>
						게시글 작성
					</a>
				</div>
		</c:if>

	<div class="row">
		<table class="table table-slit">
			<thead>
				<tr>
					<c:if test="${sessionScope.level =='관리자'}">
						<th>
						<!-- 전체선택 체크박스 -->
							<input type="checkbox" class="checkbox-all">
						</th>			
					</c:if>
					<th width="25%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="boardListDto" items="${list}">
					<tr class="row">
						<c:if test="${sessionScope.level == '관리자'}">
						<td>
						<!-- 개별항목 체크박스 -->
						<input type="checkbox" class="check-item" name="boardNoList" 
							value="${boardListDto.boardNo}">
							</td>
						</c:if>
						
						
						<td align="left">
						<!--  제목을 누르면 상세페이디로 이동 -->
							<c:choose>
								<c:when test="${boardListDto.reportCount >= 5}">
									<span style="color:gray;">블라인드 처리된 글입니다</span>
								</c:when>
								
								<c:otherwise>
									<a class="link" href="detail?boardNo=${boardListDto.boardNo}">
									${boardListDto.boardTitle}</a>
								
								<!--  댓글이 있다면 개수를 표시 -->
									<c:if test="${boardListDto.boardReplycount >0}">
										&nbsp;&nbsp;
										<i class="fa-solid fa-comment" style="color: #78bdcf;"></i>
										<%-- <label>${boardListDto.boardReplycount}</label> --%>
									</c:if>
									<%-- <c:if test="${boardListDto.attachmentNo !=0}">
										<i class="fa-regular fa-image"></i>
									</c:if> --%>
								
								</c:otherwise>
							</c:choose	>
						</td>
						
						<!-- 작성자 -->
						<td>${boardListDto.getBoardWriterString()}</td>
						
						<!-- 작성일 -->
						<td>${boardListDto.getBoardCtimeString()}</td>
						
						<!-- 조회수 -->
						<td>${boardListDto.boardReadcount}</td>
							
					</tr>
					</c:forEach>
				
				</tbody>
			</table>
		</div>
	</form>
	
	<div class="right">
		<a class="link" href="freeList">자유게시판으로></a>
	</div>
	
				<!-- 페이지 네비게이터 -->
	<!-- 이전 버튼 -->
	<div class="row mv-30 page-navigator">
		<c:if test="${!vo.first}">
			<a href="reviewList?${vo.prevQueryStringForMemberList}">
				<i class="fa-solid fa-angle-left"></i>
			</a>
		</c:if>
	
		<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
			<c:choose>
				<c:when test="${vo.page ==i}">  <!-- 현재 페이지면 --> 
					<a style="background-color:rgb(215,241,242)">${i}</a>			
				</c:when>
				<c:otherwise>
					<%-- 링크는 검색과 목록을 따로 구현 --%>
					<a href="reviewList?${vo.getQueryStringForMemberList(i)}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다음 버튼 -->
		<c:if test="${!vo.last}">
			<%-- 링크는 검색과 목록을 따로 구현 --%>
				<a href="reviewList?${vo.nextQueryStringForMemberList}">
					<i class="fa-solid fa-angle-right"></i>
				</a>
		</c:if>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>