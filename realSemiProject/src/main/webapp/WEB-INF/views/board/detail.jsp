<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page = "/WEB-INF/views/template/header.jsp"></jsp:include>
 <div class="container w-600">
        <div class="row w-100">
            <span class="left">가을하면 생각나는, 핑크뮬리</span>
            <span class="right">작성시간</span>
        </div>
        <div class="row">
            <label class="left">작성자</label>
            <label class="right">좋아요|조회수</label>
        </div>
        <div class="row">
            <textarea class="w-100" placeholder="내용" height=></textarea>
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
                    <button class="button"><a href="/board/edit">수정</a></button>
                    <button class="button"><a href="/board/delete">삭제</a></button>  
                </div>
            </div>
        </div>
        <div class="row">
            <textarea name="??" class="form-input w-100"></textarea>
            <div class="right">
                <button class="button"><a href="/board/edit">수정</a></button>
                <button class="button"><a href="/board/delete">삭제</a></button>
                <button class="button">신고</button>
            </div>
        </div>
    </div>


<jsp:include page = "/WEB-INF/views/template/footer.jsp"></jsp:include>
  