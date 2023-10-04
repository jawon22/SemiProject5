<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
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

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    <!-- javascript 작성 공간 -->
    <script src="./custom-link.js"></script><!-- 내가 만든 파일-->
<script>
    $(document).ready(function () {
        // 에디터 설정
        $('[name=boardContent]').summernote({
            placeholder: '내용을 작성하세요',
            tabsize: 2, // 탭을 누르면 이동할 간격
            height: 200, // 에디터 높이
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
                       
                       console.log("비동기 파일 업로드 시작")
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
                             //var imgNode = $("<img>").attr("src", "/rest/attachment/download?attachmentNo" + response.attachmentNo);
                             $("[name=boardContent]").summernote("insertNode", imgNode.get(0));
                          },
                          error:function(){
                             window.alert("통신 오류 발생");
                          }
                       });
                    }
                 }
                });     
       
         

         // 페이지 로드 시 초기값 설정
         updateBoardCategory();

        // 사용자가 계절 또는 지역을 변경할 때 호출되는 함수
        function updateBoardCategory() {
        
        // 계절과 지역 선택값 가져오기
        var selectedSeason = $("select[name='board_categoryweather']").val();
        var selectedArea = $("select[name='board_area']").val();
        var boardCategory;     
        
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
        console.log("boardCategory 파라미터 값: " + boardCategory);

        // 사용자가 계절 또는 지역을 변경할 때 업데이트 함수 호출
        $("select[name='board_categoryweather'], select[name='board_area']").change(function () {
            updateBoardCategory();
            //updateButtonState(); // updateBoardCategory 함수 호출 후에 updateButtonState 함수도 호출
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
    			console.log("바이트 크기: " + totalByteCount);
    			
            /* // 이미지 태그를 추출하여 이미지 HTML 코드와 텍스트 HTML 코드를 나눕니다.
            var imagesHtml = contentHtml.match(/<img[^>]+>/g) || [];
            var textHtml = contentHtml.replace(/<img[^>]+>/g, '');

            // 이미지 HTML 코드의 바이트 수 계산
            var imagesByteCount = imagesHtml.map(function (image) {
                return unescape(encodeURIComponent(image)).length;
            }).reduce(function (a, b) {
                return a + b;
            }, 0);

            // 텍스트 HTML 코드의 바이트 수 계산
            var textByteCount = unescape(encodeURIComponent(textHtml)).length;

            // 총 바이트 수 계산
            var totalByteCount = imagesByteCount + textByteCount;

            console.log("텍스트와 이미지의 바이트 수: " + totalByteCount); */
            
            // byte 수를 버튼 위에 표시
            $('#byteCount').text(totalByteCount);
            
            // byteCount가 초과하면 클래스 추가
            if (totalByteCount > 3989) {
                $('#byteCount').addClass("red");
                $('.btn-positive').addClass("red")
            } else {
                $('#byteCount').removeClass("red");
            }

            // 썸머노트 내용이 있으면 true 없으면 false
            $("[name=boardContent]").summernote('isEmpty');
            var contentText = !$("[name=boardContent]").summernote('isEmpty');
            
            
            console.log(title.trim() !== '');
            console.log(contentText);
            console.log(totalByteCount <= 3989)
            /* console.log(content); */
            
            // 버튼을 비활성화
            if (contentText && title.trim() !== '' && totalByteCount <= 3989) {
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
<form action="edit" method="post">
	<input type="hidden" name="boardNo" value="${boardDto.boardNo}">
        <div class="container w-800" >
            <div class="row">
                <h2 class="crudTitle">게시글 수정</h2>
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
        <c:when test="${boardDto.boardCategory == 2}"><!-- 정보게시판이면 -->
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
                <option value="전체">전체</option>
                <option value="서울" selected>서울</option>
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
        <c:when test="${boardDto.boardCategory == 3}"><!-- 정보게시판이면 -->
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
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기" selected>경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
        <c:when test="${boardDto.boardCategory == 4}"><!-- 정보게시판이면 -->
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
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원" selected>강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
        <c:when test="${boardDto.boardCategory == 5}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체"  selected>전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청" selected>충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
        <c:when test="${boardDto.boardCategory == 6}"><!-- 정보게시판이면 -->
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
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상" selected>경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
    <c:when test="${boardDto.boardCategory == 7}"><!-- 정보게시판이면 -->
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
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라" selected>전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
       <c:when test="${boardDto.boardCategory == 8}"><!-- 정보게시판이면 -->
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
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주" selected>제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
       <c:when test="${boardDto.boardCategory == 9}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄" selected>봄</option>
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
           <c:when test="${boardDto.boardCategory == 10}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄" selected>봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울" selected>서울</option>
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
           <c:when test="${boardDto.boardCategory ==11}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄" selected>봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기" selected>경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 12}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄" selected>봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원" selected>강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 13}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄" selected>봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청" selected>충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 14}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄" selected>봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상"  selected>경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 15}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄" selected>봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라"  selected>전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 16}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄" selected>봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주" selected>제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 17}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름"  selected>여름</option>
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
           <c:when test="${boardDto.boardCategory == 18}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름" selected>여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울" selected>서울</option>
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
           <c:when test="${boardDto.boardCategory ==19}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름" selected>여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기" selected>경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 20}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름" selected>여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원" selected>강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 21}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름" selected>여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청" selected>충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 22}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름" selected>여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상"  selected>경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 23}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름" selected>여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라"  selected>전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 24}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름" selected>여름</option>
                <option value="가을">가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주" selected>제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 25}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을" selected>가을</option>
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
           <c:when test="${boardDto.boardCategory == 26}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을" selected>가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울" selected>서울</option>
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
           <c:when test="${boardDto.boardCategory ==27}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을" selected>가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기" selected>경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 28}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을" selected>가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원" selected>강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 29}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을" selected>가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청" selected>충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 30}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을" selected>가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상"  selected>경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 31}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을" selected>가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라"  selected>전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 32}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을" selected>가을</option>
                <option value="겨울">겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주" selected>제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 33}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울" selected>겨울</option>
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
           <c:when test="${boardDto.boardCategory == 34}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울" selected>겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울" selected>서울</option>
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
           <c:when test="${boardDto.boardCategory ==35}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울" selected>겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기" selected>경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 36}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울" selected>겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원" selected>강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 37}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울" selected>겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청" selected>충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 38}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울" selected>겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상"  selected>경상</option>
                <option value="전라">전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 39}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울" selected>겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라"  selected>전라</option>
                <option value="제주">제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
           <c:when test="${boardDto.boardCategory == 40}"><!-- 정보게시판이면 -->
        <div class="row">
            <label>계절</label>
            <select name="board_categoryweather">
                <option value="전체">전체</option>
                <option value="봄">봄</option>
                <option value="여름">여름</option>
                <option value="가을">가을</option>
                <option value="겨울" selected>겨울</option>
            </select>
            <label>지역</label>
            <select name="board_area">
                <option value="전체">전체</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충청">충청</option>
                <option value="경상">경상</option>
                <option value="전라">전라</option>
                <option value="제주" selected>제주</option>
            </select>
            <input type="hidden" name="boardCategory" id="boardCategory">
        </div>      	  
    </c:when>
    <c:when test="${boardDto.boardCategory == 41}"><!-- 후기게시판이면 -->
        <select name="board_categoryweather" style="display: none;">
            <option value="후기" selected></option>
        </select>
        <!-- <input type="hidden" name="boardCategory" id="boardCategory"> -->
    </c:when>
    <c:when test="${boardDto.boardCategory == 42}"><!-- 자유게시판이면 -->
        <select name="board_categoryweather" style="display: none;">
            <option value="자유" selected></option>
        </select>
        <!-- <input type="hidden" name="boardCategory" id="boardCategory"> -->
    </c:when>
    <c:otherwise>
        <!-- 다른 경우 처리 -->
    </c:otherwise>
</c:choose>

            <div class="row left">
                <label>제목</label>
                <input type="text" name="boardTitle" 
                class="form-input w-100" value="${boardDto.boardTitle}" >
            </div>
            <input type="hidden" name="boardCategory" value="${boardDto.boardCategory}">
            <div class="row left">
                <label>내용</label>
                <textarea type="text" name="boardContent"
                class="form-input w-100 fixed">${boardDto.boardContent}</textarea>
            </div>
            
            <div class="row right">
        		<span id="byteCount" class="byteCount">0</span>/ 3989byte
        	</div>
            
            <div class="row">
                <button class="btn btn-positive">수정하기</button>
                
                <c:choose>
    			<c:when test="${boardDto.boardCategory == 41}"><!-- 후기게시판이면 -->
        			<a href="http://localhost:8080/board/reviewList" class="btn">목록보기</a> 
    			</c:when>
    			<c:when test="${boardDto.boardCategory == 42}"><!-- 자유게시판이면 -->
					<a href="http://localhost:8080/board/freeList" class="btn">목록보기</a> 
    			</c:when>
    			<c:otherwise>
            		<a href="list" class="btn">목록보기</a> 
    			</c:otherwise>
            </c:choose>
            
            </div>
        </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>