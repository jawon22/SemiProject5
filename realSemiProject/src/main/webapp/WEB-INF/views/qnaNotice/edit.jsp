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

<script>
    $(document).ready(function () {
        // 에디터 설정
        $('[name=qnaNoticeContent]').summernote({
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
//                              var input = $("<input>").attr("type", "hidden")
//                                                .attr("name", "attachmentNo")
//                                                .val(response.attachmentNo);
//                              $("form").prepend(input);
                             
                             //에디터에 추가할 이미지 생성
                             var imgNode = $("<img>").attr("src", "${pageContext.request.contextPath}/rest/attachment/download/" + response.attachmentNo);
                             //var imgNode = $("<img>").attr("src", "/rest/attachment/download?attachmentNo" + response.attachmentNo);
                             $("[name=qnaNoticeContent]").summernote("insertNode", imgNode.get(0));
                          },
                          error:function(){
                             window.alert("통신 오류 발생");
                          }
                       });
                    }
                 }
                });   
        
        
        // 입력 내용이 변경될 때마다 byte 수 업데이트
        $('[name=qnaNoticeContent]').on('summernote.change', function () {
            updateButtonState();
        });

        $('[name=qnaNoticeTitle]').on('input', function () {
            updateButtonState();
        });

        // 초기 로드 시에도 버튼 상태를 설정
        //updateByteCount();
        updateButtonState();

        function updateButtonState() {
            var title = $('[name=qnaNoticeTitle]').val().trim(); // 제목 값 가져오기
            var contentHtml = $('[name=qnaNoticeContent]').summernote('code').trim();
            
            
            function calculateByteSize(str) {
      			// 문자열을 UTF-8 형식으로 인코딩한 후, 바이트 크기 계산
      			var encoder = new TextEncoder('utf-8');
      			var encodedStr = encoder.encode(str);
      			var byteSize = encodedStr.length;
      			return byteSize;
    			}

    			// 특정 폼 엘리먼트의 값을 가져와서 바이트 크기 계산
    			var contentValue = $("[name=qnaNoticeContent]").val();
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
            $("[name=qnaNoticeContent]").summernote('isEmpty');
            var contentText = !$("[name=qnaNoticeContent]").summernote('isEmpty');
            
            // 버튼을 비활성화
            if (contentText && title.trim() !== '' && totalByteCount <= 4000) {
                $('.btn-positive').prop('disabled', false);
            } else {
                $('.btn-positive').prop('disabled', true);
            }
        }
	});
    
    $(document).ready(function() {
        // 비밀글 체크박스 상태가 변경될 때 호출되는 함수
        $('input[name="qnaNoticeSecret"]').change(function() {
            if ($(this).is(':checked')) {
                // 비밀글 체크되었을 때
                $('[name="qnaNoticeSecret"]').val('Y');
            } else {
                // 비밀글 체크 해제되었을 때
                $('[name="qnaNoticeSecret"]').val('N');
            }
        });      
    });   
    
</script>
<form action="edit" method="post">
	<input type="hidden" name="qnaNoticeNo" value="${qnaNoticeDto.qnaNoticeNo}">
        <div class="container w-800" >
            <div class="row">
                <h2 class="crudTitle">게시글 수정</h2>
            </div>
            

            <div class="row left">
                <label>제목</label>
                <input type="text" name="qnaNoticeTitle" 
                class="form-input w-100" value="${qnaNoticeDto.qnaNoticeTitle}" >
            </div>
            
            <div class="row left">
                <label>내용</label>
                <textarea type="text" name="qnaNoticeContent"
                class="form-input w-100 fixed">${qnaNoticeDto.qnaNoticeContent}</textarea>
            </div>
            
            
<div class="row" style="display: flex; justify-content: space-between;">
	<div class="left">
        <label>비밀글</label>
        <c:choose>
            <c:when test="${qnaNoticeDto.qnaNoticeSecret == 'Y'}">
                <input type="checkbox" name="qnaNoticeSecret" value="Y" checked>
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="qnaNoticeSecret" value="Y">
            </c:otherwise>
        </c:choose>	
	</div>
    <div class="right">
        <span id="byteCount" class="byteCount">0</span>/ 4000byte
    </div>
</div>
            
            <div class="row">
                <button class="btn btn-positive">수정하기</button>
                <a href="detail?qnaNoticeNo=${qnaNoticeDto.qnaNoticeNo}" class="btn">취소</a>
            </div>
        </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>