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


</style>

<script>
$(function () {
    var swiper = new Swiper('.swiper', {
        loop: true,

        autoplay: {
            delay: 2000,
        },

        effect: "fade",
    });
    
    //아이콘을 클릭하거나 Enter 키를 눌렀을 때 검색 실행
    var searchForm = document.querySelector('.search-form');
    
    function search(){
    	var searchQuery = document.querySelector('.form-input').value;
    	window.location.href = "/board/list?weather=전체&area=전체&type=board_title&keyword=" + searchQuery;
    }
    
    searchForm.addEventListener('submit', function(e){
    	e.preventDefault();
    	search();
    });
    
    document.querySelector('.fa-magnifying-glass').addEventListener('click', function(e){
    	e.preventDefault();
    	search();
    });
});
</script>

	<form class="search-form" action="/board/list" method="get" autocomplete="off">
	    <div>
	        <input class="form-input" name="keyword" placeholder="가고 싶은 여행지를 입력하세요!">
	        <i class="fa-solid fa-magnifying-glass fa-lg"></i>
	    </div>
	</form>
	
    <div class="swiper">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <img src="./images/busan.jpg" width="1200px">
            </div>
            <div class="swiper-slide">
                <img src="./images/danpoong.jpg" width="1200px">
            </div>
            <div class="swiper-slide">
                <img src="./images/paju.jpg" width="1200px">
            </div>
            <div class="swiper-slide">
                <img src="./images/jeju-island.jpg" width="1200px">
            </div>
            <div class="swiper-slide">
                <img src="./images/seoul.jpg" width="1200px">
            </div>
        </div>
    </div>






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