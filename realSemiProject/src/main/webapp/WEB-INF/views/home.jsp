<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
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

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>