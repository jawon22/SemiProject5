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
		

		//버튼 요소들 가져오기
		var descButton = document.querySelector(".btn-desc");
		var readcountButton = document.querySelector(".btn-readcount");
		var likecountButton = document.querySelector(".btn-likecount");
		
		// 클릭 이벤트 핸들러 등록
		descButton.addEventListener('click', function(event) {
		  event.preventDefault(); // 기본 링크 동작 방지
		  navigateToSort('latest');
		});
		
		readcountButton.addEventListener('click', function(event) {
		  event.preventDefault(); // 기본 링크 동작 방지
		  navigateToSort('readcount');
		});
		
		likecountButton.addEventListener('click', function(event) {
		  event.preventDefault(); // 기본 링크 동작 방지
		  navigateToSort('likecount');
		});
		
		// 정렬 방식에 따라 새로운 주소로 이동하는 함수
		function navigateToSort(sortType) {
		  var currentURL = window.location.href;
		  var newURL = '<%= request.getContextPath() %>/board/list?sort=' + sortType; // 새로운 주소
		
		  // 현재 URL에서 정렬 방식 파라미터 제거 -> 주소 뒤에 붙는거 삭제
		  currentURL = removeURLParameter(currentURL, 'sort');
		
		  // 검색어 및 검색 타입 쿼리 매개변수 유지
		  if (currentURL.includes('?')) {
		    var searchParams = currentURL.split('?')[1];
		    newURL += '&' + searchParams;
		  }
		
		  window.location.href = newURL;
		}
		
		// URL에서 파라미터 제거하는 함수
		function removeURLParameter(url, parameter) {
		  var urlparts = url.split('?');
		  if (urlparts.length >= 2) {
		    var prefix = encodeURIComponent(parameter) + '=';
		    var params = urlparts[1].split(/[&;]/g);
		
		    // 파라미터 중에서 해당 파라미터 제거
		    for (var i = params.length - 1; i >= 0; i--) {
		      if (params[i].lastIndexOf(prefix, 0) !== -1) {
		        params.splice(i, 1);
		      }
		    }
		
		    // 제거된 파라미터를 합쳐서 새로운 URL 생성
		    url = urlparts[0] + (params.length > 0 ? '?' + params.join('&') : '');
		    return url;
		  } else {
		    return url;
		  }
		}
	});

</script>

<div class="container w-800">
	<div class="row">
		<a class="link" href="list"><h2 class="crudTitle">여행정보</h2></a>
	</div>

	<c:if test="${vo.search}">
		${vo.keyword}에 대한 검색 결과
	</c:if>

	<form id="listForm" action="list" method="get">
		<div class="row">
			<!-- 계절 선택창 -->
<%--  			<c:if test="${param.weather != null}"> 			--%>
				<select name="weather" class="form-input">
					<option value="전체" selected>전체</option>
				    <option value="봄" ${param.weather =='봄' ? 'selected' :''}>봄</option>
				    <option value="여름" ${param.weather =='여름' ? 'selected' :''}>여름</option>
				    <option value="가을" ${param.weather =='가을' ? 'selected' :''}>가을</option>
				    <option value="겨울" ${param.weather =='겨울' ? 'selected' :''}>겨울</option>
				</select>
<%--  			</c:if> --%> 
				
			<!-- 지역 선택창 -->
	<%-- 		<c:if test="${param.area != null}"> --%> 
				<select name="area" class="form-input">
					<option value="전체" selected>전체</option>
				    <option value="서울" ${param.area =='서울' ? 'selected' :''}>서울</option>
				    <option value="경기" ${param.area =='경기' ? 'selected' :''}>경기</option>
				    <option value="강원" ${param.area =='강원' ? 'selected' :''}>강원</option>
				    <option value="충청" ${param.area =='충청' ? 'selected' :''}>충청</option>
				    <option value="경상" ${param.area =='경상' ? 'selected' :''}>경상</option>
				    <option value="전라" ${param.area =='전라' ? 'selected' :''}>전라</option>
				    <option value="제주" ${param.area =='제주' ? 'selected' :''}>제주</option>
				</select>
<%-- 		</c:if> --%>

		</div>

			<!-- 검색창 -->
		<div class="row">
			<c:choose>
				<c:when test="${param.type == 'board_writer'}">
					<select style="height:35px;" name="type" class="form-input" required>
						<option value="board_title">제목</option>
						<option value="board_writer" selected>작성자</option>
					</select>
				</c:when>
				<c:otherwise>
						<select style="height:35px;" class="form-input" name="type" required>
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
    
   	<a href="<%= request.getContextPath() %>/board/list?sort=latest" class="btn btn-desc">최신순</a>
	<a href="<%= request.getContextPath() %>/board/list?sort=readcount" class="btn btn-readcount">조회수순</a>
	<a href="<%= request.getContextPath() %>/board/list?sort=likecount" class="btn btn-likecount">좋아요순</a>

</div>

<form class="delete-form" action="deleteByAdmin" method="post">
	<c:if test="${sessionScope.name !=null}">
			<div class="row right">
				<c:if test="${sessionScope.level == '관리자'}">
					<button type="submit" class="btn btn-negative delete-btn">
						<i class="fa-solid fa-trash-can"></i>
						게시글 삭제
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
					<tr class="row">
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
										<i class="fa-solid fa-comment" style="color: #78bdcf; z-index:99">
										</i>
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

<br>
				<!-- 페이지 네비게이터 -->
	<!-- 이전 버튼 -->
	<div class="row mv-30 page-navigator">
		<c:if test="${vo.first ==false}">
			<a href="list?${vo.prevQueryString}">
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
					<a href="list?${vo.getQueryString(i)}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다음 버튼 -->
		<c:if test="${!vo.last}">
			<%-- 링크는 검색과 목록을 따로 구현 --%>
				<a href="list?${vo.nextQueryString}">
					<i class="fa-solid fa-angle-right"></i>
				</a>
		</c:if>
	</div>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>