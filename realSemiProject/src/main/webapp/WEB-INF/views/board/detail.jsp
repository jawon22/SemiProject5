<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page = "/WEB-INF/views/template/header.jsp"></jsp:include>
 <script>
 $(function(){
	 $(".reply-insert-form").submit(function(e){
		 e.preventDefault();
		 console.log(e);
		 $.ajax({
			 url:"/rest/reply/insert",
			 method:"post",
			 data:$(e.target).serialize(),
			 success:function(response){
				 $("name=replyContent").val("");
				 loadList();
			 }
		 });
	 });
 });
 
 function loadList(){
	 var params = new URLSearchParams(location.search);
	 var no = parms.get("boardNo");
	 
	 var memberId="{sessionScope.name}";
	 
	 $.ajax({
		 url:"/rest/reply/list",
		 method:"post",
		 data:{replyOrigin:no},
		 success:function(response){
			$(".reply-list").empty();
			
			for(var i = 0; i<response.length; i++){}
			var reply = respinse[i];
			
			var template = $("#reply-template").html();
			var htmlTemplate=$.parseHTML(template);
			
			$(htmlTemplate).find(".replyWriter").text(reply.replyWriter || "탈퇴한 회원")
			$(htmlTemplate).find(".replyContent").text(reply.replyContent)
		 }
	 });
 }
 </script>

 <script id="reply-template" type="text/template">
        <div class="row flex-container">
        	<div class="w-75">
				<div class="left">
					<pre class="replyWriter">(사람아이콘)작성자</pre>
				</div>
				<div class="left">
					<textarea class="replyContent w-100 form-input"></textarea>
				</div>
			</div>
			<div class="w-25">
				<div class="right">
					<button class="btn w-100">수정</button>
				</div>
				<div class="right">
					<button class="btn w-100">삭제</button>
				</div>
				<div class="right">
					<button class="btn w-100">신고</button>
				</div>        
			</div>
        </div>
        </script>


 <div class="container w-700">
        
        <div class="w-75">
            <span class="row left">${boardDto.boardTitle}제목</span>
            <span class="right right">${boardDto.boardCtime} 작성일</span>
        </div>
        <div class="row left">
            <label>${sessionScope.name}닉네임</label>
        </div>
        <div class="row right">
            <label>${boardDto.boardLikecount}좋아요|${boardDto.boardReplycount}조회수</label>
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
                    <button class="button"><a href="/board/list?keyword=${vo.type}, start=${vo.keyword}, end=${vo.page}">목록</a></button>
                    <button class="button"><a href="/board/edit?baordNo=${boardDto.boardNo}">수정</a></button>
                    <button class="button"><a href="/board/delete?boardNo=${boardDto.boardNo}">삭제</a></button>  
                </div>
            </div>
        </div>
		
		<form class="reply-insert-form">
		<div class="row flex-container">
		
		<input type="hidden" name="replyWriter" value="${reply.replyWriter}">
		<input type="hidden" name="replyOrigin" value="${boardDto.boardNo}">
			<div class="w-75">
				<div class="row left">
					<textarea class="w-100" name="replyContent">댓글입력창</textarea>
				</div>
			</div>
				<div class="w-25">
					<div class=" row right">
						<button class="btn w-100"><i class="fa-regular fa-paper-plane-top">아이콘</i></button>
					</div>
				</div>
		</div>
		</form>
       
	</div>
			



<jsp:include page = "/WEB-INF/views/template/footer.jsp"></jsp:include>
  