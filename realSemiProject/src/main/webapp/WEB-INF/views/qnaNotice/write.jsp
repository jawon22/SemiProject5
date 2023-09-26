<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .note-frame {
        line-height: 2 !important;
    }
</style>

<!-- summernote 게시글 작성 cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<!-- javascript 작성 공간 -->
<script src="./custom-link.js"></script><!-- 내가 만든 파일-->
<script>
    $(function () {
        $('[name=qnaNoticeContent]').summernote({
            placeholder: '내용을 작성하세요',
            tabsize: 2, // 탭을 누르면 이동할 간격
            height: 200, // 에디터 높이
            minHeight: 200, // 에디터 최소 높이
            // lineHeight: 20, // 기본 줄 간격(px)
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'italic', 'underline']],
                ['color', ['color']],
                ['para', ['paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture']],
            ],
            
            callbacks: {
                onImageUpload: function(files) {
                   // upload image to server and create imgNode...
                   //$summernote.summernote('insertNode', imgNode);
                   if(files.length != 1) return;
                   
                   //console.log("비동기 파일 업로드 시작")
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
                         $("[name=qnaContent]").summernote("insertNode", imgNode.get(0));
                      },
                      error:function(){
                         window.alert("통신 오류 발생");
                      }
                   });
                }
             }
            });
        
        
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
        
    });
</script>


<script src="/js/boardWrite.js"></script>



<form action="write" method="post" enctype="multipart/form-data" autocomplete="off">

    <%-- 답글일 때만 추가 정보를 전송--%>
     <c:if test="${isReply}">
        <c:if test="${sessionScope.level == '관리자'}">
            <input type="hidden" name="qnaNoticeParent" value="${originDto.qnaNoticeNo}">
        </c:if>
    </c:if> 
    <div class="container w-600">
        <c:choose>
            <c:when test="${sessionScope.level == '관리자'}">
    			<div class="row">
    			
    			<c:choose>
    				<c:when test="${isReply}">
        				<c:if test="${sessionScope.level == '관리자'}">
            				<h2>답글 작성</h2>
            				<input type="hidden" name="qnaNoticeType" value="3">
        				</c:if>
    				</c:when>
    				<c:otherwise>
        				<h2>게시글 작성</h2>
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
            		<h2>Q&A</h2>
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
    <div class="container w-600">
        <div class="row">
        </div>
        <div class="row left">
            <label>내용</label>
            <textarea name="qnaNoticeContent" class="form-input w-100 fixed"></textarea>
        </div>
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
