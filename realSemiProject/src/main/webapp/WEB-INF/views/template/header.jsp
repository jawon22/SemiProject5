<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Tripee</title>
	<!-- favicon 설정 -->
	<!-- <link rel="shortcut icon" href="/images/favicon.ico"> -->

	<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
	
	<!--css 불러오기-->
	<link rel="stylesheet" type="text/css" href="/css/reset.css">

<!-- 	<link rel="stylesheet" type="text/css" href="/css/test.css"> -->

	<link rel="stylesheet" type="text/css" href="/css/layout.css">
	<link rel="stylesheet" type="text/css" href="/css/commons.css">
	
	<!-- swiper cdn -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
	
	<!-- 	jQuary 불러오기 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


	
	<style>
		li.adminMenu,
		li.adminMenu ul{
			list-style:none;
			margin: 0px;
			padding: 0px;
		}
		
		li.adminMenu ul> li{
			display: none;
		}
		li.adminMenu ul{
			position: absolute;
			z-index:9999;
		}
		li.adminMenu:hover > ul >li{
			display: inline-block;
		}
		
		.header {
			margin-top: -20px;
			 border: 2px solid #79BFD0;
			 
		}
		span.separator {
    		font-weight: bold; /* 두껍게 설정 */
    		color: #26C2BF; /* 원하는 색상으로 설정 */
		}

		.line {
			position:absolute;
			margin-top:-10px;
		}
	
	</style>
	
	<script>
		$(function(){
			
			$.ajax({
				url: window.contextPath+"/rest/member/checkProfile",
				method: "post",
				success: function(response){
					if(response != 0){
						$(".header-image").attr("src", "${pageContext.request.contextPath}/rest/member/download?attachNo=" + response);
					}else{
						$(".header-image").attr("src", "${pageContext.request.contextPath}/images/user.png");
					}
				},
				error: function(){
	                $(".header-image").attr("src", "${pageContext.request.contextPath}/images/user.png");
	            }
			});
		});
	</script>
	
	
</head>
	<body>
		<main>
			<header class="flex-container" >
				<div class="logo" style="margin-left : 150px;">
					<a class="link" href="/"><img width=50% src="${pageContext.request.contextPath}/images/logo.png"></a>
				</div>
				
				<div class="etc" style="margin-left : 220px; font-weight:bolder; width:400px;">
					<c:choose>
						<c:when test="${sessionScope.name == null}">
							<a class="link me-10" href="${pageContext.request.contextPath}/member/join">회원가입</a>
						    <a class="link me-10" href="${pageContext.request.contextPath}/member/login">로그인</a>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${sessionScope.level == '관리자'}">
									<a class="link me-20" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
									<li class="adminMenu">
									    <a class="link mb-20" href="${pageContext.request.contextPath}/member/mypage">
									    	<div class="flex-container">
									    		<div style="padding: 5px 5px;">
									    			<c:choose>
											    		<c:when test="${profile != null}">
											    			<img src="${pageContext.request.contextPath}/rest/member/download?profile=${profileNo}" width="30" height="30"
																	class="image image-circle image-border header-image">
														</c:when>
														<c:otherwise>
															<img src="${pageContext.request.contextPath}/images/user.png" width="30" height="30"
																	class="image image-circle image-border header-image">
														</c:otherwise>
									    			</c:choose>
									    		</div>
									    		<div style="margin-top: 10px; margin-start: 10px;">
									    			<span style="margin-top: 10px">${sessionScope.name}</span>
									    		</div>
									    	</div>
										</a>	
									    <ul style="width:300px">
									    	<li><a class="link" href="${pageContext.request.contextPath}/admin/member/list">회원목록</a></li>
									    	<li><a class="link" href="${pageContext.request.contextPath}/admin/member/blockList">차단회원</a></li>
									    	<li><a class="link" href="${pageContext.request.contextPath}/admin/board/reportList">신고현황</a></li>
									    	<li><a class="link" href="${pageContext.request.contextPath}/admin/member/stat">회원통계</a></li>
									    </ul>
									</li>
								</c:when>
								<c:otherwise>
					                <a class="link me-10" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
								    <a class="link" href="${pageContext.request.contextPath}/member/mypage">
								    	<div class="flex-container">
								    		<div style="padding: 5px 5px;">
								    			<c:choose>
										    		<c:when test="${profile != null}">
										    			<img src="${pageContext.request.contextPath}/rest/member/download?attachNo=${profile}" width="30" height="30"
																class="image image-circle image-border header-image">
													</c:when>
													<c:otherwise>
														<img src="${pageContext.request.contextPath}/images/user.png" width="30" height="30"
																class="image image-circle image-border header-image">
													</c:otherwise>
								    			</c:choose>
								    		</div>
								    		<div style="margin-top: 10px; margin-start: 10px;">
								    			<span style="margin-top: 10px">${sessionScope.name}</span>
								    		</div>
								    	</div>
								    </a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</div>
	        </header>
			    <hr class="header">
        <nav>
        	<div style="margin-left:150px;">
        		<a class="link me-10" href="${pageContext.request.contextPath}/board/all">여행정보</a>
        		<a class="link me-10" href="${pageContext.request.contextPath}/board/communityAll">커뮤니티</a>
        		<a class="link me-10" href="${pageContext.request.contextPath}/qnaNotice/list">QnA</a>

        		<img class="line" src="${pageContext.request.contextPath}/images/line.png" height="30px;" style="vertical-align: top;">

        	</div>
       </nav>

<section class="center">