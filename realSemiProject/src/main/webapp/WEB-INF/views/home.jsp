<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.thumbnail {
	width: 190px;
	height: 250px;
	object-fit: cover;
	/* 	padding-top: none;  */
	/*  	padding-bottom: none;  */
	/*  	padding-left: 10px;  */
	/*  	padding-right: 10px;  */
	margin-left: 2px;
	margin-right: 2px;
	border-radius: 1em;
/* 	box-shadow: 0 0 0 2px gray; */
	box-shadow: 2px 2px 2px 0px gray;
}

.thumbnail:hover {
	object-fit: none;
}

.form-input {
	position: relative;
	display: inline-block;
	width: 500px;
	height: 50px;
	top: 200px;
	background-color: white;
	margin: 0 auto;
	text-align: left;
	vertical-align: middle;
	border-radius: 10px;
	z-index: 999;
}

.fa-magnifying-glass {
	position: relative;
	top: 200px;
	right: 45px;
	margin: 0 auto;
	text-align: left;
	vertical-align: middle;
	border-radius: 5px;
	z-index: 9999;
}

img {
	margin-top: 0px;
	margin-bottom: 0px;
}

.column {
	display: flex;
	flex-direction: column; /* 요소들을 세로로 나란히 배치 */
}

.item {
	margin-bottom: 10px; /* 아이템 사이의 간격 설정 */
}

.swiper {
    height: 900px;
    margin-top: -40px;
}

.title {
	margin-left: 10px;
}

</style>

<script>
	$(function() {
		var swiper = new Swiper('.swiper', {
			loop : true,

			autoplay : {
				delay : 2000,
			},

			effect : "fade",
		});

		//아이콘을 클릭하거나 Enter 키를 눌렀을 때 검색 실행
		var searchForm = document.querySelector('.search-form');

		function search() {
			var searchQuery = document.querySelector('.form-input').value;
			window.location.href = "${pageContext.request.contextPath}/board/list?weather=전체&area=전체&type=board_title&keyword="
					+ searchQuery;
		}

		searchForm.addEventListener('submit', function(e) {
			e.preventDefault();
			search();
		});

		document.querySelector('.fa-magnifying-glass').addEventListener(
				'click', function(e) {
					e.preventDefault();
					search();
				});

		//     $(".title").each(function() {
		//     var originalString = $(this).text();
		//     var limitedString = originalString.slice(0, 8);
		//     $(this).text(limitedString);

		//     }); 
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

<form class="search-form" action="/board/list" method="get"
	autocomplete="off">
	<div>
		<input class="form-input" name="keyword"
			placeholder="가고 싶은 여행지를 입력하세요!"> <i
			class="fa-solid fa-magnifying-glass fa-lg"></i>
	</div>
</form>

<div class="swiper">
	<div class="swiper-wrapper">
		<div class="swiper-slide">
			<img src="${pageContext.request.contextPath}/images/busan.jpg" width="1200px">
		</div>
		<div class="swiper-slide">
			<img src="${pageContext.request.contextPath}/images/danpoong.jpg" width="1200px">
		</div>
		<div class="swiper-slide">
			<img src="${pageContext.request.contextPath}/images/paju.jpg" width="1200px">
		</div>
		<div class="swiper-slide">
			<img src="${pageContext.request.contextPath}/images/jeju-island.jpg" width="1200px">
		</div>
		<div class="swiper-slide">
			<img src="${pageContext.request.contextPath}/images/seoul.jpg" width="1200px">
		</div>
	</div>
</div>


<div class="container w-1000 mb-50">
	<div class="left row">
		<h1>
			<label><i class="fa-solid fa-fire" style="color: #78bdcf;"></i>계절별
				인기 여행지</label>
		</h1>
	</div>
	<div class="right">
		<a class="link" href="${pageContext.request.contextPath}/board/list"> <label class="gray">더보기</label> <i class="fa-regular fa-square-plus" style="color: #9aa1ac;"></i></a>
	</div>
	<div class="flex-container auto-width">
		<c:forEach var="seasonList" items="${seasonList}">
			<a class="link"
				href="${pageContext.request.contextPath}/board/detail?boardNo=${seasonList.boardNo}">
				<c:choose>
					<c:when test="${seasonList.attachmentNo == null}">
						<img class="thumbnail"
							src="https://dummyimage.com/200x150/000/fff&text=image">
					</c:when>
					<c:otherwise>
						<img class="thumbnail"
							src="${pageContext.request.contextPath}/rest/attachment/download/${seasonList.attachmentNo}">
					</c:otherwise>
				</c:choose>
				<div class="left row">
					<span class="title">${seasonList.boardTitle}</span>
				</div>


			</a>
		</c:forEach>
	</div>
</div>


<div class="container w-1000">
	<div class="left row">
		<h1>
			<label><i class="fa-solid fa-fire" style="color: #78bdcf;"></i>지역별
				인기 여행지</label>
		</h1>
	</div>
	<div class="right">
		<a class="link" href="${pageContext.request.contextPath}/board/list"> <label class="gray">더보기</label> <i class="fa-regular fa-square-plus" style="color: #9aa1ac;"></i></a>
	</div>
	<div class="flex-container auto-width">
		<c:forEach var="areaList" items="${areaList}">
			<a class="link"
				href="${pageContext.request.contextPath}/board/detail?boardNo=${areaList.boardNo}">
				<c:choose>
					<c:when test="${areaList.attachmentNo == null}">
						<img class="thumbnail"
							src="https://dummyimage.com/200x150/000/fff&text=image">
					</c:when>
					<c:otherwise>
						<img class="thumbnail"
							style="border-radius: 15px; overflow: hidden;"
							src="${pageContext.request.contextPath}/rest/attachment/download/${areaList.attachmentNo}">
					</c:otherwise>
				</c:choose>
				<div class="left row">
					<span class="title">${areaList.boardTitle}</span>
				</div>
			</a>
		</c:forEach>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>