<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .note-frame {
        line-height: 2 !important;
    }
</style>

    <style>
  .btn-positive[disabled]:hover::before {
    content: '제목 및 내용에 글을 적지 않거나 용량을 초과하셨습니다.';
    position: absolute;
    background-color: red;
    color: white;
    padding: 5px;
    border-radius: 5px;
    font-size: 14px;
    margin-top: -30px;
    margin-left: -10px;
    width: auto; /* 팝업의 너비를 자동으로 설정합니다. */
    white-space: nowrap; /* 텍스트가 넘칠 경우 줄 바꿈을 방지합니다. */
  }
  
</style>

<!-- summernote 게시글작성 cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    <!-- javascript 작성 공간 -->

    
<script>
    $(document).ready(function () {
        // 에디터 설정
        $('[name=boardContent]').summernote({
            placeholder: '내용을 작성하세요',
            tabsize: 2, // 탭을 누르면 이동할 간격
            height: 400, // 에디터 높이
            minHeight: 300, // 에디터 최소 높이
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'italic', 'underline']],
                ['color', ['color']],
                ['para', ['paragraph']],
                ['insert', ['link', 'picture']],
                ],
                
                callbacks: {
                    onImageUpload: function(files) {
                       // upload image to server and create imgNode...
                       //$summernote.summernote('insertNode', imgNode);
                       if(files.length != 1) return;
                       
                       //1. FormData 2. processdata 3.contentType
                       var fd = new FormData();
                       fd.append("attach", files[0]);
                       
                       $.ajax({
                          url:"${pageContext.request.contextPath}/rest/attachment/upload",
                          method:"post",
                          data:fd,
                          processData:false,
                          contentType:false,
                          success:function(response){
                             //서버로 전송할 이미지 번호 정보 생성
                             var input = $("<input>").attr("type", "hidden")
                                               .attr("name", "attachmentNo")
                                               .val(response.attachmentNo);
                             
                             $("form").prepend(input);
                             
                             //에디터에 추가할 이미지 생성
                             var imgNode = $("<img>").attr("src", "${pageContext.request.contextPath}/rest/attachment/download/" + response.attachmentNo);
                             $("[name=boardContent]").summernote("insertNode", imgNode.get(0));
                          },
                          error:function(){
                             window.alert("통신 오류 발생");
                          }
                       });
                    }
                 }
                });
        
        
        
/*      // 이미지 삽입 함수
        function insertImage(response) {
            if (response && response.attachmentNo) {
                // 이미지 업로드가 완료되었을 때만 실행
                var imgNode = $("<img>").attr("src", "${pageContext.request.contextPath}/rest/attachment/download/" + response.attachmentNo);
                $("[name=boardContent]").summernote("insertNode", imgNode.get(0));
            }
        } */
        
        // 페이지 로드 시 초기값 설정
        updateBoardCategory();

        // 사용자가 계절 또는 지역을 변경할 때 호출되는 함수
        function updateBoardCategory() {
        
        // 계절과 지역 선택값 가져오기
        var selectedSeason = $("select[name='board_categoryweather']").val();
        var selectedArea = $("select[name='board_area']").val();
        
        // 현재 페이지 URL을 가져와서
        var url = new URL(window.location.href);

        // URLSearchParams 객체를 생성
        var params = new URLSearchParams(url.search);

        // 파라미터를 읽어서
        var boardCategory = params.get('boardCategory');
        
        
        
        if (selectedSeason == "전체") {
            if (selectedArea == "전체") {
                boardCategory = 1;
            } else if (selectedArea == "서울") {
                boardCategory = 2;
            } else if (selectedArea == "경기") {
                boardCategory = 3;
            } else if (selectedArea == "강원") {
                boardCategory = 4;
            } else if (selectedArea == "충청") {
                boardCategory = 5;
            } else if (selectedArea == "경상") {
                boardCategory = 6;
            } else if (selectedArea == "전라") {
                boardCategory = 7;
            } else if (selectedArea == "제주") {
                boardCategory = 8;
            } 
            
        } else if (selectedSeason == "봄") {
        	
            if (selectedArea == "전체") {
                boardCategory = 9;
            } else if (selectedArea == "서울") {
                boardCategory = 10;
            } else if (selectedArea == "경기") {
                boardCategory = 11;
            } else if (selectedArea == "강원") {
                boardCategory = 12;
            } else if (selectedArea == "충청") {
                boardCategory = 13;
            } else if (selectedArea == "경상") {
                boardCategory = 14;
            } else if (selectedArea == "전라") {
                boardCategory = 15;
            } else if (selectedArea == "제주") {
                boardCategory = 16;
            } 
            
        } else if (selectedSeason == "여름") {
        	
            if (selectedArea == "전체") {
                boardCategory = 17;
            } else if (selectedArea == "서울") {
                boardCategory = 18;
            } else if (selectedArea == "경기") {
                boardCategory = 19;
            } else if (selectedArea == "강원") {
                boardCategory = 20;
            } else if (selectedArea == "충청") {
                boardCategory = 21;
            } else if (selectedArea == "경상") {
                boardCategory = 22;
            } else if (selectedArea == "전라") {
                boardCategory = 23;
            } else if (selectedArea == "제주") {
                boardCategory = 24;
            } 
            
        } else if (selectedSeason == "가을") {
        	
            if (selectedArea == "전체") {
                boardCategory = 25;
            } else if (selectedArea == "서울") {
                boardCategory = 26;
            } else if (selectedArea == "경기") {
                boardCategory = 27;
            } else if (selectedArea == "강원") {
                boardCategory = 28;
            } else if (selectedArea == "충청") {
                boardCategory = 29;
            } else if (selectedArea == "경상") {
                boardCategory = 30;
            } else if (selectedArea == "전라") {
                boardCategory = 31;
            } else if (selectedArea == "제주") {
                boardCategory = 32;
            } 
        } else if (selectedSeason == "겨울") {
        	
            if (selectedArea == "전체") {
                boardCategory = 33;
            } else if (selectedArea == "서울") {
                boardCategory = 34;
            } else if (selectedArea == "경기") {
                boardCategory = 35;
            } else if (selectedArea == "강원") {
                boardCategory = 36;
            } else if (selectedArea == "충청") {
                boardCategory = 37;
            } else if (selectedArea == "경상") {
                boardCategory = 38;
            } else if (selectedArea == "전라") {
                boardCategory = 39;
            } else if (selectedArea == "제주") {
                boardCategory = 40;
            } 
             else if (selectedArea == "전체") {     	
                if (selectedSeason == "후기") {
                    boardCategory = 41;
                } else if (selectedAreaSeason == "자유") {
                    boardCategory = 42;
                } 
            }              
        }
        
        $("input[name='boardCategory']").val(boardCategory);
        }

        // 사용자가 계절 또는 지역을 변경할 때 업데이트 함수 호출
        $("select[name='board_categoryweather'], select[name='board_area']").change(function () {
            updateBoardCategory();
        });
        
        
            
        // 입력 내용이 변경될 때마다 byte 수 업데이트
        $('[name=boardContent]').on('summernote.change', function () {
            updateButtonState();
        });

        $('[name=boardTitle]').on('input', function () {
            updateButtonState();
        });

        // 초기 로드 시에도 버튼 상태를 설정
        //updateByteCount();
        updateButtonState();

        function updateButtonState() {
            var title = $('[name=boardTitle]').val().trim(); // 제목 값 가져오기
            var contentHtml = $('[name=boardContent]').summernote('code').trim();
            
            
            function calculateByteSize(str) {
      			// 문자열을 UTF-8 형식으로 인코딩한 후, 바이트 크기 계산
      			var encoder = new TextEncoder('utf-8');
      			var encodedStr = encoder.encode(str);
      			var byteSize = encodedStr.length;
      			return byteSize;
    			}

    			// 특정 폼 엘리먼트의 값을 가져와서 바이트 크기 계산
    			var contentValue = $("[name=boardContent]").val();
    			var totalByteCount = calculateByteSize(contentValue);
    			
            
            // byte 수를 버튼 위에 표시
            $('#byteCount').text(totalByteCount);
            
            // byteCount가 초과하면 클래스 추가
            if (totalByteCount > 4000) {
                $('#byteCount').addClass("red");
                $('.btn-positive').addClass("red")
            } else {
                $('#byteCount').removeClass("red");
            }

            // 썸머노트 내용이 있으면 true 없으면 false
            $("[name=boardContent]").summernote('isEmpty');
            var contentText = !$("[name=boardContent]").summernote('isEmpty');
            
            // 버튼을 비활성화
            if (contentText && title.trim() !== '' && totalByteCount <= 4000) {
                $('.btn-positive').prop('disabled', false);
            } else {
                $('.btn-positive').prop('disabled', true);
            }
        }
             

    });

    
    /* 정보게시판: http://localhost:8080/board/write?boardCategory=1
    후기 게시판: http://localhost:8080/board/write?boardCategory=41
    자유게시판: http://localhost:8080/board/write?boardCategory=42  */  	
    	
</script>
    
   	






<form action="write" method="post">
    <div class="container w-800">
<div class="row">
<h2 class="crudTitle">
    <c:choose>
        <c:when test="${boardDto.boardCategory == 1}">여행정보 게시글 작성</c:when>
        <c:when test="${boardDto.boardCategory == 41}"> 후기 게시글 작성</c:when>
        <c:when test="${boardDto.boardCategory == 42}"> 자유 게시글 작성</c:when>
    </c:choose>
</h2>
</div>
                   
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
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
    <c:when test="${boardDto.boardCategory == 41}"><!-- 후기게시판이면 -->
        <input type="hidden" name="boardCategory" id="boardCategory" value="41">
    </c:when>
    <c:when test="${boardDto.boardCategory == 42}"><!-- 자유게시판이면 -->
<input type="hidden" name="boardCategory" id="boardCategory" value="42">
    </c:when>
    <c:otherwise>
        <!-- 다른 경우 처리 -->
    </c:otherwise>
</c:choose>
    
    
        <div class="row left">
            <label>제목</label>
            <input type="text" name="boardTitle" class="form-input w-100">
        </div>
    </div>
    <div class="container w-800">
        <div class="row left">
            <label>내용</label>
            <textarea type="text" name="boardContent" class="form-input w-100 fixed"></textarea>
        </div>
        
        <div class="row right">
        	<span id="byteCount" class="byteCount">0</span>/ 4000byte
        </div>
        
        <div class="row">
            <button class="btn btn-positive">등록하기</button>
            <c:choose>
    			<c:when test="${boardDto.boardCategory == 41}"><!-- 후기게시판이면 -->
        			<a href="${pageContext.request.contextPath}/board/reviewList" class="btn">목록보기</a> 
    			</c:when>
    			<c:when test="${boardDto.boardCategory == 42}"><!-- 자유게시판이면 -->
					<a href="${pageContext.request.contextPath}/board/freeList" class="btn">목록보기</a> 
    			</c:when>
    			<c:otherwise>
            		<a href="list" class="btn">목록보기</a> 
    			</c:otherwise>
            </c:choose>
        </div>
    </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
