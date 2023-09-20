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

<script>
    $(document).ready(function () {
        // 계절과 지역 선택값 가져오기
        var selectedSeason = $("select[name='board_categoryweather']").val();
        var selectedArea = $("select[name='board_area']").val();
        
        // URL에서 boardCategory 매개변수 값을 읽어옴
        var urlParams = new URLSearchParams(window.location.search);
        var boardCategory = urlParams.get('boardCategory');
        
        if (boardCategory == 1) { // 예시: 1일 때
            $("select[name='board_categoryweather']").val("전체");
            $("select[name='board_area']").val("전체");
        } else if (boardCategory == 34) { // 예시: 34일 때
            // 선택 상태 변경 없음
        } else if (boardCategory == 35) { // 예시: 35일 때
            // 선택 상태 변경 없음
        }
        
        if (selectedSeason == "봄") {
        	
            if (selectedArea == "전체") {
                boardCategory = 2;
            } else if (selectedArea == "서울") {
                boardCategory = 3;
            } else if (selectedArea == "경기") {
                boardCategory = 4;
            } else if (selectedArea == "강원") {
                boardCategory = 5;
            } else if (selectedArea == "충청") {
                boardCategory = 6;
            } else if (selectedArea == "경상") {
                boardCategory = 7;
            } else if (selectedArea == "전라") {
                boardCategory = 8;
            } else if (selectedArea == "제주") {
                boardCategory = 9;
            } 

        } else if (selectedSeason == "여름") {
        	
            if (selectedArea == "전체") {
                boardCategory = 10;
            } else if (selectedArea == "서울") {
                boardCategory = 11;
            } else if (selectedArea == "경기") {
                boardCategory = 12;
            } else if (selectedArea == "강원") {
                boardCategory = 13;
            } else if (selectedArea == "충청") {
                boardCategory = 14;
            } else if (selectedArea == "경상") {
                boardCategory = 15;
            } else if (selectedArea == "전라") {
                boardCategory = 16;
            } else if (selectedArea == "제주") {
                boardCategory = 17;
            } 
            
        } else if (selectedSeason == "가을") {
        	
            if (selectedArea == "전체") {
                boardCategory = 18;
            } else if (selectedArea == "서울") {
                boardCategory = 19;
            } else if (selectedArea == "경기") {
                boardCategory = 20;
            } else if (selectedArea == "강원") {
                boardCategory = 21;
            } else if (selectedArea == "충청") {
                boardCategory = 22;
            } else if (selectedArea == "경상") {
                boardCategory = 23;
            } else if (selectedArea == "전라") {
                boardCategory = 24;
            } else if (selectedArea == "제주") {
                boardCategory = 25;
            } 
            
        } else if (selectedSeason == "겨울") {
        	
            if (selectedArea == "전체") {
                boardCategory = 26;
            } else if (selectedArea == "서울") {
                boardCategory = 27;
            } else if (selectedArea == "경기") {
                boardCategory = 28;
            } else if (selectedArea == "강원") {
                boardCategory = 29;
            } else if (selectedArea == "충청") {
                boardCategory = 30;
            } else if (selectedArea == "경상") {
                boardCategory = 31;
            } else if (selectedArea == "전라") {
                boardCategory = 32;
            } else if (selectedArea == "제주") {
                boardCategory = 33;
            } 
        }
        
        // 설정한 boardCategory 값을 숨겨진 필드에 설정
        $("input[name='boardCategory']").val(boardCategory);
    });
    
/*  // URL에서 매개변수 값을 읽어오는 함수
    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    } */ 
    //이거처럼 url에서 변수 값을 받게 하지말고 정보게시판에서 글쓰기 누르면 boardCategory1
    //http://localhost:8080/board/write?boardCategory=1
    //후기 게시판에서 글쓰기 누르면 boardCategory34 
    //http://localhost:8080/board/write?boardCategory=34
    //자유게시판에서 글쓰기 누르면 boardCategory35로 
    //http://localhost:8080/board/write?boardCategory=35
    		//이걸로 설정되게 하고싶음
    		
/* 정보게시판: http://localhost:8080/board/write?boardCategory=1
후기 게시판: http://localhost:8080/board/write?boardCategory=34
자유게시판: http://localhost:8080/board/write?boardCategory=35  */  		
 
</script>

<script src="/js/boardWrite.js"></script>


<h2>
    <c:choose>
        <c:when test="${boardDto.boardCategory == 1}">계절 지역 게시글 작성</c:when>
        <c:when test="${boardDto.boardCategory == 34}"> 후기 게시글 작성</c:when>
        <c:when test="${boardDto.boardCategory == 35}"> 자유 게시글 작성</c:when>
    </c:choose>
</h2>

<form action="write" method="post">
    <div class="container w-600">
          
<c:choose>
    <c:when test="${boardDto.boardCategory == 1}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체" selected>전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
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
        <select name="board_categoryweather" style="display: none;">
            <option value="후기" selected></option>
        </select>
    </c:when>
    <c:when test="${boardDto.boardCategory == 35}"><!-- 자유게시판이면 -->
        <select name="board_categoryweather" style="display: none;">
            <option value="자유" selected></option>
        </select>
    </c:when>
    <c:otherwise>
        <!-- 다른 경우 처리 -->
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
