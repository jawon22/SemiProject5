<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .note-frame {
        line-height: 2 !important;
    }
</style>

<style>
  .btn-positive[disabled]:hover::before {
    content: '글자 수 제한 초과, 제목 및 내용 미작성등의 이유로 글 작성이 불가능합니다';
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
<!-- summernote 게시글 작성 cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<!-- javascript 작성 공간 -->
<script src="./custom-link.js"></script><!-- 내가 만든 파일-->
<script>
    $(function () {
    	var isExceedingLimit = false; // 글자 수 제한 초과 여부를 나타내는 변수
    	
        $('[name=qnaNoticeContent]').summernote({
            placeholder: '내용을 작성하세요',
            tabsize: 2, // 탭을 누르면 이동할 간격
            height: 200, // 에디터 높이
            minHeight: 300, // 에디터 최소 높이
            // lineHeight: 20, // 기본 줄 간격(px)
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'italic', 'underline']],
                ['color', ['color']],
                ['para', ['paragraph']],
                ['insert', ['link', 'picture']],
            ],
            
            callbacks: {
                onImageUpload: function(files) {
                	
                    if (isExceedingLimit) {
                        alert('용량 제한을 초과하여 이미지를 추가할 수 없습니다.');
                        return;
                    }
                    
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
//                          var input = $("<input>").attr("type", "hidden")
//                                            .attr("name", "attachmentNo")
//                                            .val(response.attachmentNo);
//                          $("form").prepend(input);
                         
                         //에디터에 추가할 이미지 생성
                         var imgNode = $("<img>").attr("src", "${pageContext.request.contextPath}/rest/attachment/download/" + response.attachmentNo);
                         //var imgNode = $("<img>").attr("src", "/rest/attachment/download?attachmentNo" + response.attachmentNo);
                         $("[name=qnaNoticeContent]").summernote("insertNode", imgNode.get(0));
                      },
                      error: function() {
                          alert("통신 오류 발생");
                      }
                  });
              },
              onKeydown: function(e) {
                  var content = $('[name=qnaNoticeContent]').summernote('code');
                  var byteCount = countBytes(content);

/*                   if (byteCount > 3988) {
                      alert('글자 수 제한을 초과하여 텍스트를 추가할 수 없습니다.');
                      e.preventDefault();
                  } */
              }
          }
      });
        
        
     // 입력 내용이 변경될 때마다 byte 수 업데이트
        $('[name=qnaNoticeContent]').on('summernote.change', function () {
            updateByteCount();
        });

        // 초기 byte 수 업데이트
        updateByteCount();

        function updateByteCount() {
            var content = $('#qnaNoticeContent').summernote('code');
            var byteCount = countBytes(content);

            // byte 수를 버튼 위에 표시
            $('#byteCount').text(byteCount);

            // 조건 어길시 추가 글 작성 버튼을 비활성화
            if (byteCount > 3988 || $('input[name="qnaNoticeTitle"]').val().length === 0) {
                $('#addButton').prop('disabled', true);
                isExceedingLimit = true;
            } else {
                $('#addButton').prop('disabled', false);
                isExceedingLimit = false;
            }
        }

        // 문자열의 byte 수 계산 함수
        function countBytes(str) {
            var byteCount = -11;
            for (var i = 0; i < str.length; i++) {
                var charCode = str.charCodeAt(i);
                if (charCode <= 0x007F) {
                    byteCount += 1;
                } else if (charCode <= 0x07FF) {
                    byteCount += 2;
                } else if (charCode <= 0xFFFF) {
                    byteCount += 3;
                } else {
                    byteCount += 4;
                }
            }
            
            // byteCount가 초과하면 클래스 추가
            if (byteCount > 3988) {
                $('#byteCount').addClass("red");
                $('#addButton').addClass("redBackground"); // 배경색을 빨간색으로 변경
                isExceedingLimit = true;
            } else {
                $('#byteCount').removeClass("red");
                isExceedingLimit = false;
            }
            
            return byteCount;
        }
        
        
        // 게시글 타입 선택 시
        $('select[name="qnaNotice_type"]').change(function () {
            var selectedType = $(this).val();
            $('#selectedType').val(selectedType);
        });
    });
    
    $(document).ready(function() {
    	
        // 추가 글 작성 버튼 클릭 시 글자 수 및 용량 제한 확인
        $('#addButton').click(function () {
            var content = $('#qnaNoticeContent').summernote('code');
            var byteCount = countBytes(content);

            if (byteCount > 3988) {
                alert('글자 수 제한을 초과하여 추가 글 작성이 불가능합니다.');
                return false; // 추가 글 작성 막음
            }
        });
        
        // 비밀글 체크박스 상태가 변경될 때 호출되는 함수
        $('input[name="qnaNoticeSecret"]').change(function() {
            if ($(this).is(':checked')) {
                // 비밀글 체크되었을 때
                console.log('비밀글이 선택되었습니다.');
                $('[name="qnaNoticeSecret"]').val('Y');
            } else {
                // 비밀글 체크 해제되었을 때
                console.log('비밀글이 해제되었습니다.');
                $('[name="qnaNoticeSecret"]').val('N');
            }
        });
        
    });
</script>


<script src="/js/boardWrite.js"></script>



<form action="write" method="post" enctype="multipart/form-data">

    <%-- 답글일 때만 추가 정보를 전송--%>
     <c:if test="${isReply}">
        <c:if test="${sessionScope.level == '관리자'}">
            <input type="hidden" name="qnaNoticeParent" value="${originDto.qnaNoticeNo}">
        </c:if>
    </c:if> 
    <div class="container w-800">
        <c:choose>
            <c:when test="${sessionScope.level == '관리자'}">
    			<div class="row">
    			
    			<c:choose>
    				<c:when test="${isReply}">
        				<c:if test="${sessionScope.level == '관리자'}">
            				<h2 class="crudTitle">답글 작성</h2>
            				<input type="hidden" name="qnaNoticeType" value="3">
        				</c:if>
    				</c:when>
    				<c:otherwise>
        				<h2 class="crudTitle">게시글 작성</h2>
        				<label>유형</label>
                    		<select name="qnaNoticeType">
                        		<option value="1">공지사항</option>
                        		<option value="2">QnA</option>
                    		</select> 
                    		<input type="checkbox" name="qnaNoticeSecret" >비밀글
    				</c:otherwise>
				</c:choose>   	
   	 			</div>
   	 			
            </c:when>
            
            <c:otherwise>
            	<div class="row">
            		<h2 class="crudTitle">Q&A</h2>
            	</div>
                <input type="hidden" name="qnaNoticeType" value="2">
                <input type="checkbox" name="qnaNoticeSecret">비밀글
            </c:otherwise>            
		</c:choose>

<!--         <div class="row left">
        <label>
       		<input type="file" name="attach" accept="image/*" multiple>
        </label>
        </div> -->
    	
        <div class="row left">
            <label>제목</label>
            <c:choose>
                <c:when test="${isReply}">
                    <input type="text" name="qnaNoticeTitle" class="form-input w-100" value="RE: ${originDto.qnaNoticeTitle}" required>
                </c:when>
                <c:otherwise>
                    <input type="text" name="qnaNoticeTitle" class="form-input w-100">
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="container w-800">
        <div class="row">
        </div>
        <div class="row left">
            <label>내용</label>
            <textarea id="qnaNoticeContent" name="qnaNoticeContent" class="form-input w-100 fixed"></textarea>
        </div>
        
        <div class="row right">
        	<span id="byteCount" class="byteCount">0</span>/ 3988byte
        </div>
        
        <div class="row">
         
                <c:choose>
                    <c:when test="${isReply && sessionScope.level == '관리자'}">
                      <button class="btn btn-positive" id="addButton">답글작성</button>
                    </c:when>
                    <c:otherwise>
                  		<button class="btn btn-positive" id="addButton">등록하기</button>
                    </c:otherwise>
                </c:choose>

            <a href="list" class="btn">목록보기</a>
        </div>
    </div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
