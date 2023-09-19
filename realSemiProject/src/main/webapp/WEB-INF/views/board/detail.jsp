<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page = "/WEB-INF/views/template/header.jsp"></jsp:include>
 <div class="container w-700">
        <div class="row w-100">
            <span class="left">${boardDto.boardTitle}</span>
            <span class="right">${boardDto.boardCtime}</span>
        </div>
        <div class="row">
            <label class="left">${sessionScope.name}</label>
            <label class="right">${boardDto.boardLikecount}|${boardDto.boardReplycount}</label>
        </div>
        
        <div class="row">
            <textarea class="w-100" placeholder="내용" ></textarea>
        </div>
        <div class="felx-container">
            <div class="w-50">
                <div class="left">
                    <button value="">신고 버튼(이미지)</button>
                </div>
            </div>
            <div class="w-50">
                <div class="right">
                    <button class="button"><a href="/board/edit">블라인드</a></button>
                    <button class="button"><a href="/board/list">목록</a></button>
                    <button class="button"><a href="/board/edit?baordNo="+${boardDto.boardNo}>수정</a></button>
                    <button class="button"><a href="/board/delete?boardNo="+${boardDto.boardNo}  >삭제</a></button>  
                </div>
            </div>
        </div>
<!--         댓글 구현중 -->
        <div class="row">
            <textarea name="" class="form-input w-100"></textarea>
            <div class="right">
                <button class="button"><a href="/board/edit?boardNo="+${boardDto.boardNo}>수정</a></button>
                <button class="button"><a href="/board/delete?boardNo="${boardDto.boardNo}>삭제</a></button>
                <button class="button"><a href="/board/?">신고</a></button>
            </div>
        </div>
    </div>


<jsp:include page = "/WEB-INF/views/template/footer.jsp"></jsp:include>
  