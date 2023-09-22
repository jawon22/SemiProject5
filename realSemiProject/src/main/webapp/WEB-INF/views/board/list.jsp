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
//            	 $(".delete-btn").css("display","inline-block");
//            	 $(".delete-btn").show();
           	 $(".delete-btn").fadeIn("fast");
            }
            else{
//            	 $(".delete-btn").css("display","none");
//            	 $(".delete-btn").hide();
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
		
//         $(".btn-desc").click(function(e){
//         	$.ajax({
// 				url:"/board/list",        		
// 				data:$(e.target).serialize(),
// 				success:function(response){
// 					$(".rangelist")
// 				}
//         	});
//         });
        
	});

</script>

<div class="container w-800">
	<div class="row">
		<h2>정보게시판 목록</h2>
	</div>

	<c:if test="${vo.search}">
		${vo.keyword}에 대한 검색 결과
	</c:if>

<!-- 카테고리 선택창 -->
	<form action="list" method="get">
		<div class="row">
		<!-- 계절 선택창 -->
<%--  			<c:if test="${param.weather != null}"> 			--%>
				<select name="weather" class="form-input">
					<option value="전체" selected>전체</option>
				    <option value="봄">봄</option>
				    <option value="여름">여름</option>
				    <option value="가을">가을</option>
				    <option value="겨울">겨울</option>
				</select>
<%--  			</c:if> --%> 
				
				<!-- 지역 선택창 -->
	<%-- 		<c:if test="${param.area != null}"> --%> 
				<select name="area" class="form-input">
					<option value="전체" selected>전체</option>
				    <option value="서울">서울</option>
				    <option value="경기">경기</option>
				    <option value="강원">강원</option>
				    <option value="충청">충청</option>
				    <option value="경상">경상</option>
				    <option value="전라">전라</option>
				    <option value="제주">제주</option>
				</select>
<%-- 		</c:if> --%>
		</div>

		<div class="row">
			<!-- 검색창 -->
			<c:choose>
				<c:when test="${param.type == 'board_writer'}">
					<select name="type" class="form-input" required>
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
	
			<input type="search" name="keyword" placeholder="검색어를 입력하세요" value="${param.keyword}" class="form-input">		
			<button class="btn btn-positive" type="submit">
				<i class="fa-solid fa-magnifying-glass"></i>
				검색
			</button>
			
		</div>
	</form>

<div class="row right">
	<a href="http://localhost:8080/board/list" class="btn">최신순</a>
	<a href="http://localhost:8080/board/list/readcount" class="btn">조회수순</a>
	<a href="http://localhost:8080/board/list/likecount" class="btn">좋아요순</a>
</div>

		<!-- action을 아직 지정안했음 -->
<form class="delete-form" action="#" method="post">
	<c:if test="${sessionScope.name !=null}">
			<div class="row right">
				<c:if test="${sessionScope.level == '관리자'}">
				<button type="submit" class="btn btn-negative delete-btn">
					<i class="fa-solid fa-trash-can"></i>
					게시글 일괄삭제
				</button>
				</c:if>
				
				<a href="write?boardCategory=1" class="btn">
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
					<th>계절</th>
					<th>지역</th>
					<th width="25%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="boardListDto" items="${list}">
					<tr>
						<c:if test="${sessionScope.level == '관리자'}">
						<td>
						<!-- 개별항목 체크박스 -->
						<input type="checkbox" class="check-item" name="boardNoList" 
							value="${boardListDto.boardNo}">
							</td>
						</c:if>
						
						<!-- 계절  -->
						<td>${boardListDto.boardCategoryWeather}</td>
						
						<!-- 지역  -->
						<td>${boardListDto.boardArea}</td>
						
						<td align="left">
						<!--  제목을 누르면 상세페이디로 이동 -->
							<a class="link" href="detail?boardNo=${boardListDto.boardNo}">
							${boardListDto.boardTitle}</a>
						
						<!--  댓글이 있다면 개수를 표시 -->
							<c:if test="${boardListDto.boardReplycount >0}">
								&nbsp;&nbsp;
								<i class="fa-solid fa-comment" style="color: #78bdcf;"></i>
								<label>${boardListDto.boardReplycount}</label>
							</c:if>
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


<br>
				<!-- 페이지 네비게이터 -->
	<!-- 이전 버튼 -->
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

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>