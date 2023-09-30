<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.thumbnail {
	width: 200px;
	height: 150px;
	object-fit: cover;
	padding-top: none;
	padding-bottom: none;
	padding-left: 10px;
	padding-right: 10px;
}

.thumbnail:hover {
	object-fit: none;
}

.column {
	display: flex;
	flex-direction: column; /* 요소들을 세로로 나란히 배치 */
}

.item {
	margin-bottom: 10px; /* 아이템 사이의 간격 설정 */
}

.thumbnail {
	height: auto;
}
</style>



<div class="container w-1000">
  <div class="left">
    <h1>
      <label><i class="fa-solid fa-fire" style="color: #78bdcf;"></i>계절별 인기 여행지</label>
    </h1>
  </div>
  <div class="flex-container auto-width">
    <c:forEach var="seasonList" items="${seasonList}">
     			<a class="link"
				href="http://localhost:8080/board/detail?boardNo=${seasonList.boardNo}">
				<c:choose>
					<c:when test="${seasonList.attachmentNo == null}">
						<img class="thumbnail"
							src="https://dummyimage.com/200x150/000/fff&text=image">
					</c:when>
					<c:otherwise>
						<img class="thumbnail"
							src="/rest/attachment/download/${seasonList.attachmentNo}">
					</c:otherwise>
				</c:choose> <span style="margin-left: 10px;">${seasonList.boardTitle}</span>
			</a>
    </c:forEach>
  </div>
</div>

<div class="container w-1000">
  <div class="left">
    <h1>
      <label><i class="fa-solid fa-fire" style="color: #78bdcf;"></i>지역별 인기 여행지</label>
    </h1>
  </div>
  <div class="flex-container auto-width">
    <c:forEach var="areaList" items="${areaList}">
          			<a class="link"
				href="http://localhost:8080/board/detail?boardNo=${areaList.boardNo}">
				<c:choose>
					<c:when test="${areaList.attachmentNo == null}">
						<img class="thumbnail"
							src="https://dummyimage.com/200x150/000/fff&text=image">
					</c:when>
					<c:otherwise>
						<img class="thumbnail"
							src="/rest/attachment/download/${areaList.attachmentNo}">
					</c:otherwise>
				</c:choose> <span style="margin-left: 10px;">${areaList.boardTitle}</span>
			</a>
    </c:forEach>
  </div>
</div>





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>