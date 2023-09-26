<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 카카오 지도 cdn -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c18c138c3ab7eb5251102708e8a79c47"></script>
<script>
	$(function(){
		var container = document.querySelector("#map");
		var cantainer = $("#map")
		
		var options = {
			center: new kakao.maps.LatLng(37.533912575657915, 126.89675054040399),
			//지도의 배율(zoom level : 1~14) //몇 층에서 보는 느낌
			level: 13
		};
	
		//범위 제한을 없애고 싶다면 외부에 만들거나 window에 추가한다
        window.map = new kakao.maps.Map(container,options);
		
	});
</script>


<style>
	.text-position{
		position: relative;
		z-index:9999;
		margin-top:100px;
		margin-left:180px;
	}

</style>

<!-- 이거는 가로가 크게 보여줘야 할 것 같아서 1000으로 지정함 -->

<div class="container w-1000">
	<div class="flex-container">
	
		<div class="row" style="width:450px"> 
			<h1>계절 게시판</h1>
			<div class="flex-container">
				<div>
					<span>
						<a class="text-position link" href="/board/list?weather=봄&area=전체&type=board_title&keyword=">봄
							<img style="height:225px; width:225px;" src="/images/weather/spring.jpg">
						</a>
					</span>
				</div>
				<div>
					<span>
						<a class="text-position link" href="/board/list?weather=여름&area=전체&type=board_title&keyword=">여름
							<img style="height:225px; width:225px" src="/images/etc/cry.gif">
						</a>
					</span>
				</div>
			</div>
			<div class=flex-container>
				<div>
					<span>
						<a class="text-position link" href="/board/list?weather=가을&area=전체&type=board_title&keyword=">가을
							<img style="height:225px; width:225px" src="/images/etc/cry.gif">
						</a>
					</span>
				</div>
				<div>
					<span>
						<a class="text-position link" href="/board/list?weather=겨울&area=전체&type=board_title&keyword=">겨울
							<img style="height:225px; width:225px" src="/images/etc/cry.gif">
						</a>
					</span>
				</div>
			</div>
		</div>
		
<!-- 		일단 지도만 띄워놓음 -->
		<div class="row ms-20" style="width:450px">
			<h1>지역 게시판</h1>
			<div id="map" style="width:450px;height:450px;"></div>
		</div>

	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>