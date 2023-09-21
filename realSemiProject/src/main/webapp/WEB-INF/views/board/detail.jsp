<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page = "/WEB-INF/views/template/header.jsp"></jsp:include>
 <script>
 $(function(){
	 $(".reply-insert-form").submit(function(e){
		 e.preventDefault();
		
		
		 $.ajax({
			 url:"/rest/reply/insert",
			 method:"post",
			 data:$(e.target).serialize(),
			 success:function(response){
				 $("[name=replyContent]").val("");
				 loadList();
			 }
		 });
	 });
	 loadList();	
	 
	 function loadList() {
			var params = new URLSearchParams(location.search);
			var no = params.get("boardNo");
			
			var memberId = "${sessionScope.name}";
			
			$.ajax({
				url:"/rest/reply/list",
				method:"post",
				data:{replyOrigin : no},
				success:function(response){
					$(".reply-list").empty();
					
					for(var i=0; i < response.length; i++) {
						var reply = response[i];
						
						var template = $("#reply-template").html();
						var htmlTemplate = $.parseHTML(template);
						
						$(htmlTemplate).find(".replyWriter").text(reply.replyWriter || "탈퇴한 사용자");
						$(htmlTemplate).find(".replyContent").text(reply.replyContent);
						$(htmlTemplate).find(".replyTime").text(reply.replyTime);
						
						if(memberId.length == 0 || memberId != reply.replyWriter) {
							$(htmlTemplate).find(".w-25").empty();
						}
						
						//삭제버튼
						$(htmlTemplate).find(".btn-delete")
											.attr("data-reply-no", reply.replyNo)
											.click(function(e){
							var replyNo = $(this).attr("data-reply-no");
							$.ajax({
								url:"/rest/reply/delete",
								method:"post",
								data:{replyNo : replyNo},
								success:function(response){
									loadList();
								},
							});
						});
						
						$(htmlTemplate).find(".btn-edit")
												.attr("data-reply-no", reply.replyNo)
												.attr("data-reply-content", reply.replyContent)
												.click(function(){
							//this == 수정버튼
							var editTemplate = $("#reply-edit-template").html();
							var editHtmlTemplate = $.parseHTML(editTemplate);
							
							//value 설정
							var replyNo = $(this).attr("data-reply-no");
							var replyContent = $(this).attr("data-reply-content");
// 							console.log(replyContent);
							$(editHtmlTemplate).find("[name=replyNo]").val(replyNo);
							$(editHtmlTemplate).find("[name=replyContent]").val(replyContent);
							
							$(editHtmlTemplate).find(".btn-cancel")
														.click(function(){
								$(this).parents(".edit-container")
											.prev(".view-container").show();
								$(this).parents(".edit-container").remove();
							});
							
							//완료(등록) 버튼 처리
							$(editHtmlTemplate).submit(function(e){
								e.preventDefault();
								
								$.ajax({
									url:"/rest/reply/edit",
									method:"post",
									data : $(e.target).serialize(),
									success:function(response){
								console.log("성공");
										loadList();
									}
								});
							});
							
							//화면 배치
							$(this).parents(".view-container")
										.hide()
										.after(editHtmlTemplate);
						});
						
						$(".reply-list").append(htmlTemplate);
					}
				},
			});
		}
 });
 
 
 </script>

 <script id="reply-template" type="text/template">
        <div class="row flex-container view-container">
        	<div class="w-75">
				<div class="left">
	`				<i>(사람아이콘)</i>
					<pre class="replyWriter">작성자</pre>
				</div>
				<div class="left">
					<pre class="replyContent w-100 form-input"></pre>
				</div>
			</div>
			<div class="w-25">
				<div class="row right">
					<button class="btn w-100 btn-edit">수정</button>
				</div>
				<div class="row right">
					<button class="btn w-100 btn-delete">삭제</button>
				</div>
				<div class="row right">
					<button class="btn w-100">신고</button>
				</div>
				<div class="row right">
					<button class="btn w-100">대댓글</button>
				</div>       
			</div>
        </div>
</script>



 <div class="container w-700">
  <script id="reply-edit-template" type="text/template">
	      <form class="reply-edit-form edit-contailner">
			<input type="hidden" name="replyNo" value="?">	        
	        <div class="row flex-container">
	        	<div class="w-75">
					<div class="left">
						<textarea name="replyContent" class="w-100 form-input"></textarea>
					</div>
				</div>
				<div class="w-25">
					<div class="right">
						<button type="submit" class="btn con-2 ">수정(아이콘)</button>
						<button class="btn btn-cencle">취소(아이콘)</button>
					</div>
				</div>
	        </div>
        </form>
       </script>
        
        <div class="w-75">
            <span class="row left">${boardDto.boardTitle}</span>
            <span class="right right">${boardDto.boardCtime}</span>
        </div>
        <div class="row left">
            <label>${boardDto.boardWriter}닉네임</label>
        </div>
        <div class="row right">
            <label>${boardDto.boardLikecount}좋아요|${boardDto.boardReplycount}조회수</label>
        </div>
        
        <div class="row">
           <pre>${boardDto.boardContent}</pre>
        </div>
        
        <div class="row flex-container">
            <div class="col-2">
                <div class="left">
                    <button value="">신고 버튼(이미지)</button>
                </div>
            </div>
            <div class="col-2">
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
		
<%-- 		<input type="hidden" name="replyWriter" value="${sessionScope.name}"> --%>
		
			<div class="w-75">
				<div class="row left">
					<textarea class="w-100" name="replyContent"></textarea>
				</div>
			</div>
				<div class="w-25">
					<div class=" row right">
						<button class="btn w-100"><i class="fa-regular fa-paper-plane-top">아이콘</i></button>
					</div>
				</div>
		</div>
		</form>
       
			
<div class="row left reply-list"></div>
	</div>


<jsp:include page = "/WEB-INF/views/template/footer.jsp"></jsp:include>
  