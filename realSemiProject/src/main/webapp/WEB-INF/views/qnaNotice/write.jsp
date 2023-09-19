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
        $('[name=boardContent]').summernote({
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
                ['insert', ['link']],
            ]
        });

        // 게시글 타입 선택 시
        $('select[name="qnaNotice_type"]').change(function () {
            var selectedType = $(this).val();
            $('#selectedType').val(selectedType);
        });
    });
</script>

<script src="/js/boardWrite.js"></script>

<c:choose>
    <c:when test="${isReply}">
        <c:if test="${sessionScope.level == '관리자'}">
            <h2>답글 작성</h2>
        </c:if>
    </c:when>
    <c:otherwise>
        <h2>게시글 작성</h2>
    </c:otherwise>
</c:choose>

<form action="write" method="post">
    <%-- 답글일 때만 추가 정보를 전송--%>
    <c:if test="${isReply}">
        <c:if test="${sessionScope.level == '관리자'}">
            <input type="hidden" name="boardParent" value="${originDto.boardNo}">
        </c:if>
    </c:if>
    <div class="container w-600">
        <c:choose>
            <c:when test="${sessionScope.level == '관리자'}">
                <div class="row left">
                    <label>유형</label>
                    <select name="qnaNotice_type">
                        <option value="1">QnA</option>
                        <option value="2">공지사항</option>
                    </select>
                </div>
            </c:when>
            <c:otherwise>
                <input type="hidden" name="qnaNotice_type" value="1">
            </c:otherwise>
        </c:choose>
        <div class="row left">
            <label>제목</label>
            <c:choose>
                <c:when test="${isReply}">
                    <input type="text" name="boardTitle" class="form-input w-100" value="RE: ${originDto.boardTitle}" required>
                </c:when>
                <c:otherwise>
                    <input type="text" name="boardTitle" class="form-input w-100">
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="container w-600">
        <div class="row">
        </div>
        <div class="row left">
            <label>내용</label>
            <textarea type="text" name="boardContent" class="form-input w-100 fixed"></textarea>
        </div>
        <div class="row">
            <button class="btn btn-positive">
                <c:choose>
                    <c:when test="${isReply && sessionScope.level == '관리자'}">답글 작성</c:when>
                    <c:otherwise>등록하기</c:otherwise>
                </c:choose>
            </button>
            <a
 href="list" class="btn">목록보기</a>
        </div>
    </div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
