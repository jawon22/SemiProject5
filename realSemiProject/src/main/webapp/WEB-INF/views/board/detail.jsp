<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page = "/WEB-INF/views/template/header.jsp"></jsp:include>
 <style>
 </style>
 <script>
 $(function(){
	 var params = new URLSearchParams(location.search);
		var no = params.get("boardNo");
		

		//좋아요 처리
			 $.ajax({
				 url:"/rest/boardLike/check",
				 method:"post",
				 data:{boardNo : no},
			 	success:function(response){
				 if(response.check){
					 $(".fa-heart").removeClass("fa-regular fa-solid").addClass("fa-solid")
				 }	
				 else{
					 $(".fa-heart").removeClass("fa-regular fa-solid").addClass("fa-regular")
				 }
				 $(".fa-heart").next("label").text(response.count);
			 	}
			 });
			
		$(".fa-heart").click(function(){
			 $.ajax({
				 url:"/rest/boardLike/action",
				 method:"post",
				 data:{boardNo : no},	
			 	success:function(response){
				 if(response.check){
					 $(".fa-heart").removeClass("fa-regular fa-solid").addClass("fa-solid")
				 }
				 else{
					 $(".fa-heart").removeClass("fa-regular fa-solid").addClass("fa-regular")
				 }
				 $(".fa-heart").next("label").text(response.count);	
			 	}
			 });		
		});
		
		
	 $(".reply-insert-form").submit(function(e){
// 		 console.log("성공");
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
			
			
			
				//리스트 리로드
			$.ajax({
				url:"/rest/reply/list",
				method:"post",
				data:{replyOrigin : no},
				success:function(response){
					$(".reply-list").empty();
					for(var i=0; i < response.list.length; i++) {
						var attachNo = response.attachNo[i];
						var reply = response.list[i];
						var attach = response.attachNo[i];
						var template = $("#reply-template").html();
						var htmlTemplate = $.parseHTML(template);
						$(htmlTemplate).find(".replyWriter").text(reply.replyWriter || "탈퇴한 사용자");
						$(htmlTemplate).find(".replyContent").text(reply.replyContent);
						$(htmlTemplate).find(".replyTime").text(reply.replyTime);
						console.log(attach);
						
						//이미지 소스 보내기
						if(attach	 == null){
							$(htmlTemplate).find(".reply-profile").prop("src","https://dummyimage.com/80x80/000/fff");
							}
						else{
							$(htmlTemplate).find(".reply-profile").prop("src", "/rest/member/download?attachNo="+attach);
						}
						
						if(memberId.length == 0 || memberId != reply.replyWriter) {
							$(htmlTemplate).find(".w-25").empty();
						}
						
							
						//버튼 생성 버튼
						$(htmlTemplate).find(".btn-create").attr("data-reply-no", reply.replyNo).click(function (e) {
						var replyNo = $(this).attr("data-reply-no");
							if(reply.replyNo==replyNo){
							
								$(".btn-create").after($(htmlTemplate).find(".btn-hide").css("display", "inline-block"));
							}	
						});
						
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
// 								console.log("성공");
										loadList();
									}
								});
							});
							
							//대댓글 버튼
							//replyGroup, replyParent, replyDepth 정보 필요
// 							$(htmlTemplate).find(".block-form")
// 												.attr("data-reply-no", reply.replyNo)
// 												.attr("data-reply-content", reply.replyContent)
// 												.click(function(){});
							
							//화면 배치
							$(this).parents(".view-container")
										.hide()
										.after(editHtmlTemplate);
						});
						
						$(".reply-list").append(htmlTemplate);
					}
				},
			});
	
			
				
			//신고버튼 구현중
	$(".btn-block").click(function(e){
		e.preventDefault();
		var blockTemplate = $("#block-template").html();
		var blockHtmlTemplate = $.parseHTML(blockTemplate);
		var params = new URLSearchParams(location.search);
		var no = params.get("boardNo");
		
		
		//취소버튼
		$(blockHtmlTemplate).find(".block-cencel")
							.click(function(){
			$(this).parents(".block-container")
				.prev(".btn-block").show();
			$(this).parents(".block-container").remove();
		});
		
		//완료(등록) 버튼 처리
		$(blockHtmlTemplate).submit(function(e){
			e.preventDefault();
// 			var boardNo = $("[name=boardNo]").val();
// 			var longBoardNo = $.parseLong(boardNo);
			var reportReason = $("[name=reportReason]").val();
			$.ajax({
				url:"/board/report/board",
				method:"get",
				data :{boardNo:no, reportReason:reportReason},
				success:function(response){
					$(".block-container")
					.prev(".btn-block").show();
				$(".block-container").remove();
				},
			});
		
		});
		
		
			$(this).hide().after(blockHtmlTemplate);
		});
	 
	 }			
	
 });
 
 
 </script>

 <script id="reply-template" type="text/template">
        <div class="row flex-container vertical view-container">
				<div class = "flex-container">
			    	<div class="w-75">
				    	<div class="flex-container">
							<div class=" row left">
								<img src="" class="reply-profile image image-circle image-border profile-image" width="50" height="50"
								>
							</div>
							<div class="row right">
								<pre class="replyWriter mt-30">작성자</pre>
							</div>
					    </div>
						<div class="row left">
								<pre class="replyContent w-100 form-input"></pre>
						</div>
				    	</div>
					<div class="right btn-wrap w-25">
							<button class="btn btn-create">버튼 생성 아이콘</button>
					</div>
					<div class="btn-append"></div>
				</div>
				
				<div class="row btn-hide" style="display: none;">
						<button class="btn  btn-edit">수정</button>
						<button class="btn  btn-delete">삭제</button>
						<button class="btn btn-reply">대댓글</button>
	       		</div>
			</div>
</script>



 <div class="container w-800">
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
       
        <script id="block-template" type="text/template">
			<form class="block-form block-container" >
				<button type="submit" class="btn block-send">보내기</button>
				<button class="btn block-cencel">취소</button>
				<input type="hidden" name="boardNo">
				<select id="select-block" name="reportReason" class="form-input">
						<option name="reportReason" value="" selected disabled>신고사유</option>
					    <option name="reportReason" value="광고/음란성 글" >1. 광고/음란성 글</option>
					    <option name="reportReason" value="욕설/반말/부적절한 언어">2. 욕설/반말/부적절한 언어</option>
					    <option name="reportReason" value="회원 분란 유도">3. 회원 분란 유도</option>
					    <option name="reportReason" value="회원 비방">4. 회원 비방</option>
					    <option name="reportReason" value="지나친 정치/종교 논쟁">5. 지나친 정치/종교 논쟁</option>
					    <option name="reportReason" value="도배성 글">6. 도배성 글</option>
				</select>
			</form>
		</script>
		<div class="flex-container">
        	<div class="row w-50 left">
        		<h2>${boardDto.boardTitle}</h2>
        	</div>
		        <div class="row w-50 right">
		            <span>${boardDto.boardCtime}</span>
		        </div>
		</div>
		<div class="flex-container">
        <div class="row left w-50">
        <c:choose>
				<c:when test="${attachNo == null}">
					<img src="https://dummyimage.com/50x50/000/fff" width="50" height="50"
						class="image image-circle image-border profile-image">
				</c:when>
				<c:otherwise>
				<img src="/rest/member/download?attachNo=${attachNo}" width="50" height="50"
				class="image image-circle image-border profile-image">
				</c:otherwise>
			</c:choose>
            <label style="font-size: 20px">${writerDto.memberNickname}닉네임</label>
        </div>
        <div class="row right w-50">
          <i class="fa-solid fa-heart red"></i><label>0</label>|조회수<label class="readCount">${boardDto.boardReadcount}</label>
        </div>
		</div>
        
        <div class="row left">
           <pre style="height: 200px">${boardDto.boardContent}</pre>
        </div>
       
        
        <div class="row flex-container">
            <div class="col-2">
                <div class="left">
                    <button class = "btn-block" value="">신고 버튼(이미지)</button>
                 </div>
            </div>
            <div class="col-2">
                <div class="right">
                <c:choose>
	                <c:when test="${boardDto.boardCategory==41}">
	                    <button class="button"><a href="/board/community/list">목록</a></button>
	                </c:when>
	                <c:when test="${boardDto.baordCategory==42}">
	                	<button class="button"><a href="#">목록</a></button>
	                </c:when>
	                <c:otherwise>
	                	<button class="button"><a href="#">목록</a></button>
	                </c:otherwise>
                </c:choose>
                    <c:if test="${sessionScope.name==boardDto.boardWriter||	memberDto.memberlevel=='관리자' }">
                    <button class="button"><a href="/board/edit?boardNo=${boardDto.boardNo}">수정</a></button>
                    <button class="button"><a href="/board/delete?boardNo=${boardDto.boardNo}">삭제</a></button>  
                    </c:if>
                </div>
            </div>
        </div>	
		
		
	<c:if test="${sessionScope.name != null}">
		<form class="reply-insert-form">
		<input type="hidden" name="replyOrigin" value="${boardDto.boardNo}">
		<div class="row flex-container">
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
			<input type="hidden" name="replyParent" value="${reply.replyNo}">
		<c:if test="${reply.replyParent!=null}">
			<input type="hidden" name="replyDepth" value="${reply.replyDepth}+1">
		</c:if>
		</form>
	</c:if>
       
			
	<div class="row left reply-list"></div>
</div>


<jsp:include page = "/WEB-INF/views/template/footer.jsp"></jsp:include>
  