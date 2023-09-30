<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.title{
		font-size: 30px;
		font-weight: bold;
		color: #26C2BF;
	}
</style>

<script>
	$(function(){
		$(".delete-btn").hide();
		
		$(".check-all").change(function(){
			var check = $(this).prop("checked");
			$(".check-all, .check-item").prop("checked",check);
			
			if(check){
				$(".delete-btn").fadeIn("fast");
			}else{
				$(".delete-btn").fadeOut("fast");
			}
		});
		
		$(".check-item").change(function(){
			var allCheck = $(".check-item").length == $(".check-item").filter(":checked").length;
			$(".check-all").prop("checked", allCheck);
			
			if($(".check-item").filter(":checked").length > 0){
				$(".delete-btn").fadeIn("fast");
			}else{
				$(".delete-btn").fadeOut("fast");
			}
		});
		
		$(".delete-form").submit(function(e){
        	return confirm("정말 삭제하시겠습니까?");
        });
		
	});
</script>


<div class="container w-900">
	<div class="row">
		<a href="reportList" class="link" ><span class="title">신고현황</span></a>
	</div>

		<div class="row right">
			<button type="submit" class="btn btn-negative delete-btn">
				<i class="fa-solid fa-trash"></i>삭제
			</button>
		</div>
		
		<div class="row">
			<table class="table table-slit">
				<thead>
					<tr>
						<th>
							<input type="checkbox" class="check-all">
						</th>
						<th>
							신고 번호
						</th>
						<th>
							글 번호
						</th>
						<th>
							글 종류
						</th>
						<th>
							글 제목
						</th>
						<th>
							글 내용
						</th>
						<th>
							글 작성자
						</th>
						<th>
							신고자
						</th>
						<th>
							신고 사유
						</th>
					</tr>
				</thead>
	
				<tbody>
					<c:forEach var="reportList" items="${reportList}">
						<tr>
							<td>
								<input type="checkbox" class="check-item" name="reportNoList" value="${reportList.reportNo}">
							</td>
							<td>
								${reportList.reportNo}
							</td>
							<td>
								<a class="link" href="/board/detail?boardNo=${reportList.boardNo}">${reportList.boardNo}</a>
							</td>
							<td>
								${reportList.boardCategory}
							</td>
							<td>
								${reportList.boardTitle}
							</td>
							<td>
								${reportList.boardContent}
							</td>
							<td>
								${reportList.boardWriter}
							</td>
							<td>
								${reportList.memberId}
							</td>
							<td>
								${reportList.reportReason}
							</td>
						</tr>		
					</c:forEach>
				</tbody>
			</table>
		</div>
	
	<div class="row">
		<form action="reportList" method="get" autocomplete="off">
			<select name="type" class="search-select">
				<option value="board_no">글 번호</option>
				<option value="board_writer">작성자</option>
			</select>	
			<input type="search" name="keyword" 
				value="${param.keyword}"  class="search-input"
				placeholder="검색어 입력" required>
			<button class="search-btn">검색</button>
		</form>
	</div>

	<!-- 페이지 네비게이터 출력(목록) -->
	
	<!-- 이전 버튼 -->
	<div class="row">
		<c:if test="${!vo.first}">
			<a href="reportList?${vo.prevQueryStringForMemberList}" class="prev">&lt;</a>	
		</c:if>

		<!-- 숫자 부분 -->
		<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
		
			<c:choose>
				<c:when test="${vo.page == i}"> <!-- 현재페이지면 -->
					${i}
				</c:when>
				<c:otherwise>
					<a href="reportList?${vo.getQueryStringForMemberList(i)}">${i}</a>		
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<!--  다음버튼 -->
		<c:if test="${!vo.last}">
			<a href="reportList?${vo.nextQueryStringForMemberList}" class="next">&gt;</a>		
		</c:if>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>