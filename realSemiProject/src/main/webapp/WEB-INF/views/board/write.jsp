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
            tabsize: 2, // 탭을 누르면 이동할 간격
            height: 200, // 에디터 높이
            minHeight: 200, // 에디터 최소 높이
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

    // 계절 선택 시
    $('select[name="board_categoryweather"]').change(function () {
        var selectedWeather = $(this).val();
        $('#selectedWeather').val(selectedWeather);
    });

    // 지역 선택 시
    $('select[name="board_area"]').change(function () {
        var selectedArea = $(this).val();
        $('#selectedArea').val(selectedArea);
    });
    
  //boardCategory <= 33 정보(계절 지역게시판
  //boardCategory == 34 후기게시판
  //boardCategory == 35 자유게시판
</script>

<script src="/js/boardWrite.js"></script>


<h2>
    <c:choose>
        <c:when test="${boardDto.boardCategory <= 33}">계절 지역 게시글 작성</c:when>
        <c:when test="${boardDto.boardCategory == 34}"> 후기 게시글 작성</c:when>
        <c:when test="${boardDto.boardCategory == 35}"> 자유 게시글 작성</c:when>
    </c:choose>
</h2>

<form action="write" method="post">
    <div class="container w-600">
          
    <c:choose>
    	<c:when test="${boardDto.boardCategory <= 33}"><!-- 정보게시판이면 -->
    		<div class="row">
        		<label>계절</label>
        		<select name="board_categoryweather">
            		<option value="전체" selected>전체</option>
            		<option value="봄">봄</option>
            		<option value="여름">여름</option>
            		<option value="가을">가을</option>
            		<option value="겨울">겨울</option>
            		<option value="후기" style="display: none"></option>
            		<option value="자유" style="ddisplay: none"></option>
        		</select>
        		<label>지역</label>
        		<select name="board_area">
            		<option value="전체" selected>전체</option>
            		<option value="서울">서울</option>
            		<option value="경기">경기</option>
            		<option value="강원">강원</option>
            		<option value="충청">충청</option>
            		<option value="경상">경상</option>
            		<option value="전라">전라</option>
            		<option value="제주">제주</option>
        		</select>
        		<input type="hidden" name="boardCategoryWeather" id="selectedWeather">
        		<input type="hidden" name="boardArea" id="selectedArea">
    		</div>      	  
    	</c:when>
    	<c:when test="${boardDto.boardCategory == 34}"><!-- 후기게시판이면 -->
				<select name="board_categoryweather"  style="display: none">
            		<option value="전체" style="display: none"></option>
            		<option value="봄" style="display: none"></option>
            		<option value="여름" style="display: none"></option>
            		<option value="가을" style="display: none"></option>
            		<option value="겨울" style="display: none"></option>
            		<option value="후기" style="display: none" selected></option>
            		<option value="자유" style="ddisplay: none"></option>
        		</select>
    	</c:when>
    	<c:when test="${boardDto.boardCategory == 35}"><!-- 자유게시판이면 -->
				<select name="board_categoryweather"  style="display: none">
            		<option value="전체" style="display: none"></option>
            		<option value="봄" style="display: none"></option>
            		<option value="여름" style="display: none"></option>
            		<option value="가을" style="display: none"></option>
            		<option value="겨울" style="display: none"></option>
            		<option value="후기" style="display: none"></option>
            		<option value="자유" style="display: none" selected></option>
        		</select>
    	</c:when>
    	<c:otherwise>

    	</c:otherwise>
    </c:choose>
    
    
        <div class="row left">
            <label>제목</label>
            <input type="text" name="boardDto.boardTitle" class="form-input w-100">
        </div>
    </div>
    <div class="container w-600">
        <div class="row left">
            <label>내용</label>
            <textarea type="text" name="boardContent" class="form-input w-100 fixed"></textarea>
        </div>
        <div class="row">
            <button class="btn btn-positive">등록하기</button>
            <a href="list" class="btn">목록보기</a>
        </div>
    </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
