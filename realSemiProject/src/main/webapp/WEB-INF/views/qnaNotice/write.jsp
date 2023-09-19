<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <style>
        .note-frame {
            line-height: 2 !important;
        }
    </style>
    
<!-- summernote 게시글작성 cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    <!-- javascript 작성 공간 -->
    <script src="./custom-link.js"></script><!-- 내가 만든 파일-->
    <script>
        $(function () {
            $('[name=boardContent]').summernote({
                placeholder: '내용을 작성하세요',
                tabsize: 2,//탭을 누르면 이동할 간격
                height: 200,//에디터 높이
                minHeight:200,//에디터 최소 높이
                //lineHeight:20,//기본 줄간격(px)
                toolbar: [
                    ['style', ['style']],
                    ['font', ['bold', 'italic', 'underline']],
                    ['color', ['color']],
                    ['para', ['paragraph']],
                    ['table', ['table']],
                    //['insert', ['link', 'picture']],
                    ['insert', ['link']],
                ]
            });
        });
    </script>
    
<script src="/js/boardWrite.js"></script>

<c:choose>
	<c:when test="${isReply}">
		<h2>답글 작성</h2>
	</c:when>
	<c:otherwise>
		<h2>게시글 작성</h2>
	</c:otherwise>
</c:choose>

<form action="write" method="post">
		<div class="container w-600">
            	<div class="row left">
                	<label>제목</label>
                	<input type="text" name="boardTitle" 
                	class="form-input w-100">
            	</div>
            </div>
        <div class="container w-600">
            <div class="row">
            </div>

            <div class="row left">
                <label>내용</label>
                <textarea type="text" name="boardContent"
                class="form-input w-100 fixed"></textarea>
            </div>
            <div class="row">
                <button class="btn btn-positive">등록하기</button>
                <a href="list" class="btn">목록보기</a>
            </div>
        </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>