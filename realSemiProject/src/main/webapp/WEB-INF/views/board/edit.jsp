<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <style>
        .note-frame {
            line-height: 2 !important;
        }
    </style>
    
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
                toolbar: [
                    ['style', ['style']],
                    ['font', ['bold', 'italic', 'underline']],
                    ['color', ['color']],
                    ['para', ['paragraph']],
                    ['table', ['table']],
                    ['insert', ['link']],
                ]
            });
        });
    </script>
<form action="edit" method="post"> 
    <div class="container w-600">
        <div class="row left">
            <label>제목</label>
            <input type="text" name="boardTitle" class="form-input w-100">
        </div>
    </div>
    <div class="row left">
        <label>계절</label>
        <select name="board_categoryweather">
            <option value="전체">전체</option>
            <option value="봄">봄</option>
            <option value="여름">여름</option>
            <option value="가을">가을</option>
            <option value="겨울">겨울</option>
        </select>
        <label>지역</label>
        <select name="board_area">
            <option value="전체">전체</option>
            <option value="서울">서울</option>
            <option value="경기도">경기도</option>
            <option value="강원도">강원도</option>
            <option value="충청도">충청도</option>
            <option value="경상도">경상도</option>
            <option value="전라도">전라도</option>
            <option value="제주도">제주도</option>
        </select>
        <input type="hidden" name="boardCategoryWeather" id="selectedWeather">
        <input type="hidden" name="boardArea" id="selectedArea">
    </div>
    <div class="container w-600">
        <div class="row left">
            <label>내용</label>
            <textarea type="text" name="boardContent" class="form-input w-100 fixed"></textarea>
        </div>
        <div class="row">
            <button class="btn btn-positive">수정</button> 
            <a href="list" class="btn">목록보기</a>
        </div>
    </div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>