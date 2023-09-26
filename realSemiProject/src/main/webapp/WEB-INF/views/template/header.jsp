<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>세미 홈페이지</title>
	<!-- favicon 설정 -->
	<!-- <link rel="shortcut icon" href="/images/favicon.ico"> -->

	<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
	
	<!--css 불러오기-->
	<link rel="stylesheet" type="text/css" href="/css/reset.css">
	<link rel="stylesheet" type="text/css" href="/css/layout.css">
	<link rel="stylesheet" type="text/css" href="/css/commons.css">
	
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
		
	
	</style>
</head>
	<body>
		<main>
			<header class="flex-container" >
				<div class="logo" style="margin-left : 150px;">
					<a class="link" href="/"><img width=50% src="images/logo.png"></a>
				</div>
				
				<div class="etc" style="margin-left : 220px; font-weight:bolder; width:400px;">
					<c:choose>
						<c:when test="${sessionScope.name == null}">
							<a class="link me-10" href="/member/join">회원가입</a>
						    <a class="link me-10" href="/member/login">로그인</a>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${sessionScope.level == '관리자'}">
									<a class="link me-10" href="/member/logout">로그아웃</a>
									<li class="adminMenu">
									    <a class="link" href="/member/mypage">회원이미지</a>
									    <ul style="width:300px">
									    	<li><a class="link" href="/admin/member/list">회원목록</a></li>
									    	<li><a class="link" href="/admin/member/blockList">차단회원</a></li>
									    	<li><a class="link" href="/admin/board/reportList">신고현황</a></li>
									    	<li><a class="link" href="/admin/member/stat">회원통계</a></li>
									    </ul>
									</li>
								</c:when>
								<c:otherwise>
					                <a class="link me-10" href="/member/logout">로그아웃</a>
								    <a class="link" href="/member/mypage">회원이미지</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</div>
	        </header>
				    <hr>
        <nav>
        	<div style="margin-left:150px;">
        		<a class="link me-10" href="/board/all">여행정보</a>
        		<a class="link me-10" href="#">커뮤니티</a>
        		<a class="link me-10" href="#">QnA</a>
        	</div>
       </nav>

<section class="center">