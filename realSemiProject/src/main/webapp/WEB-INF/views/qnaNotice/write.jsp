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
    	var byteCount = 0; // byteCount를 0으로 초기화
    	
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

                    if (files.length != 1) return;

                    console.log("비동기 파일 업로드 시작");
                    // 1. FormData 2. processdata 3.contentType
                    var fd = new FormData();
                    fd.append("attach", files[0]);

                    $.ajax({
                        url: "${pageContext.request.contextPath}/rest/attachment/upload",
                        method: "post",
                        data: fd,
                        processData: false,
                        contentType: false,
                        success: function(response) {
                            // 에디터에 추가할 이미지 생성
                            var imgNode = $("<img>").attr("src", "${pageContext.request.contextPath}/rest/attachment/download/" + response.attachmentNo);
                            // var imgNode = $("<img>").attr("src", "/rest/attachment/download?attachmentNo" + response.attachmentNo);
                            $("[name=qnaNoticeContent]").summernote("insertNode", imgNode.get(0));
                            

                            // 버튼 상태 업데이트
                            //updateButtonState();
                            
                        },
                        error: function() {
                            alert("통신 오류 발생");
                        }
                    });
                }
            }
      });
             


/*         // 입력 내용이 변경될 때마다 byte 수 업데이트
        $('[name=qnaNoticeTitle], [name=qnaNoticeContent]').on('summernote.change', function () {
            updateByteCount();
        }); */
        
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
            
            var content = $(contentHtml).text(); // HTML 태그를 제외한 텍스트만
            var byteCount = countBytes(content);
			
            //이미지 자리추가
            byteCount += countBytes(contentHtml);
            

            
	
            // 문자열의 byte 수 계산 함수
            function countBytes(str) {
                var byteCount = 0;
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


                
                // byte 수를 버튼 위에 표시
                $('#byteCount').text(byteCount);
                
                // byteCount가 초과하면 클래스 추가
                if (byteCount > 3989) {
                    $('#byteCount').addClass("red");
                } else {
                    $('#byteCount').removeClass("red");
                }

/*                 console.log(title.trim() !== '');
                console.log(content.trim() !== '');
                console.log(content);
                console.log(byteCount <= 3989);
                console.log(byteCount); */
                
             // 버튼을 비활성화
                if (content.trim() !== '' && title.trim() !== '' && byteCount <= 3989) {
                    $('.btn-positive').prop('disabled', false);
                } else {
                    $('.btn-positive').prop('disabled', true);
                }
            }
        }
               
        // 게시글 타입 선택 시
        $('select[name="qnaNotice_type"]').change(function () {
            var selectedType = $(this).val();
            $('#selectedType').val(selectedType);
        });
        
    });
    
    $(document).ready(function() { 	
        
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
        
        
        // 게시글 유형 선택 시
        $('select[name="qnaNoticeType"]').change(function () {
            var selectedType = $(this).val();
            if (selectedType === "1") {
                // 게시글 유형이 공지사항인 경우 비밀글 체크박스 비활성화
                $('input[name="qnaNoticeSecret"]').prop('disabled', true);
                $('input[name="qnaNoticeSecret"]').prop('checked', false);
            } else {
                // 게시글 유형이 다른 경우 비밀글 체크박스 활성화
                $('input[name="qnaNoticeSecret"]').prop('disabled', false);
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
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <h2 class="crudTitle">Q&A</h2>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="row left" style="display: flex; align-items: center;">
            
                	<c:choose>
        				<c:when test="${isReply}">
            				<input type="hidden" name="qnaNoticeType" value="3"> <!-- 답글인 경우 기본값 설정 -->
        				</c:when>
    					<c:otherwise>
        					<c:if test="${sessionScope.level == '관리자'}">
            					<label style="width: 50px;">유형</label>
            					<select name="qnaNoticeType" style="flex: 1; margin-right: 10px;">
                					<option value="2">QnA</option>
                					<option value="1">공지사항</option>
            					</select>
        					</c:if>
        					<c:if test="${sessionScope.level != '관리자'}">
            					<input type="hidden" name="qnaNoticeType" value="2"> <!-- 일반 사용자인 경우 기본값 설정 -->
        					</c:if>
    					</c:otherwise>
    				</c:choose>
    
            <label style="margin-right: 10px; width: 50px;" >제목</label>
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
            <textarea name="qnaNoticeContent" class="form-input w-100 fixed"></textarea>
        </div>
        
<c:choose>
    <c:when test="${!isReply}">
        <div class="row" style="display: flex; justify-content: space-between;">
            <div>
                <input type="checkbox" name="qnaNoticeSecret"> 비밀글
            </div>
            <div>
                <span id="byteCount" class="byteCount">0</span>/ 3988byte
            </div>
        </div>
    </c:when>
</c:choose>
        
        <div class="row">
         
                <c:choose>
                    <c:when test="${isReply && sessionScope.level == '관리자'}">
                      <button class="btn btn-positive">답글작성</button>
                    </c:when>
                    <c:otherwise>
                  		<button class="btn btn-positive">등록하기</button>
                    </c:otherwise>
                </c:choose>

            <a href="list" class="btn">목록보기</a>
        </div>
    </div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
