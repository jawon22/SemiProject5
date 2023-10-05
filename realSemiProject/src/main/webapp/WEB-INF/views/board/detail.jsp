<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page = "/WEB-INF/views/template/header.jsp"></jsp:include>
 <style>
 .button{
 	border-radius: 0.4em;
 }
 .btn-hide{
 display: none;
 border: none;
 border-radius: 0.2em;
 border-color: #26C2BF;
 background-color: #26C2BF;
 color: black;
 font-weight: bold; 
 font-size:12px;
 box-shadow: none;
 }
 .h-100{
 height: 100%;
 }
 .h-50{
 height: 50%;
 }
 .h-33{
 height: 33.33333%;
 }
 .rotate-icon {
    transform: rotate(45deg);
  }
  .reply-input{
   display: inline-block;
    text-decoration: none;
    vertical-align: bottom;
    font-size:15px;
    padding: 0.5em 1em;
    outline: none; /*outline은 입력 창 선택 시 강조 효과 */
    border: 1px solid #26C2BF;
    border-radius: 0.1em;
    border-right: none;
  }
  .btn-block{
  display: inline-block;
    text-decoration: none;
    vertical-align: bottom;
    padding: 0.5em 1em;
    outline: none; /*outline은 입력 창 선택 시 강조 효과 */
    border: none; 
    border-radius: 0.1em;
    line-height: 1.2em;
    background-color: inherit;
  }
  .count-font{
  font-size:15px;
  font-weight: bold;
  }
  .content{
  height: 200px;
  border: 1px solid black;
  font-size:20px;
  }
  .not-outline{
  outline: none;
   box-shadow: none;
   border: none;
  }
  .append{
  display: absolute;
  top:0;
  left:200%;
  }
  .btn-create{
   background-color: inherit;
    color:none;
    cursor: pointer;
    border: none;
  }
  .view-container{
  border: 1px solid #26C2BF; 
  border-radius: 0.2em;
  }
  .replyWriter{
  font-weight: bold;
  }
  .content{
  padding:10px; 
/*   overflow:auto; */
overflow-wrap: break-word;
word-wrap: break-word;
height: auto;
min-height:250px;
  }
  .custom-hr{
  	border:1px solid #26C2BF;
  	opacity: 0.5;
  }
  .block-send, 
  .block-cencel{
  height: 38px;
  }
  .crudTitle{
 	  font-weight: bold;
  }
  
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
// 			console.log(no);
			var memberId = "${sessionScope.name}";
			
			
			
				//리스트 리로드
			$.ajax({
				url:"/rest/reply/list",
				method:"post",
				data:{replyOrigin : no},
				success:function(response){
					$(".reply-list").empty();
						
					for(var i=0; i < response.list.length; i++) {
						var reply = response.list[i];
						var nickname = response.memberNickname[i];
						var template = $("#reply-template").html();
						var htmlTemplate = $.parseHTML(template);
						
						$(htmlTemplate).find(".replyWriter").text(nickname|| "탈퇴한 사용자");
						$(htmlTemplate).find(".replyContent").text(reply.replyContent);
						$(htmlTemplate).find(".replyTime").text(reply.replyTime);
						
						if(memberId!=reply.replyWriter){
							$(htmlTemplate).find(".btn-create").hide();
						}
						
						//버튼 생성 버튼
						$(htmlTemplate).find(".btn-create").click(function (e) {
							var displayValue = $(this).parents(".view-container").find(".btn-hide").css("display");
								if(displayValue=="none"){
									$(this).parents(".view-container").find(".btn-hide").css("display", "inline-block");
									$(this).parents(".view-container").find(".btn-hide").css({"position": "relative",
																													                "left": "74px",
																													                "bottom": "60px"});
								}
								else{
									$(this).show();
									$(this).parents(".view-container").find(".btn-hide").css("display", "none");				
								}
						});
						
						
						//삭제버튼
						$(htmlTemplate).find(".btn-delete")
											.attr("data-reply-no", reply.replyNo)
											.click(function(e){
							var replyNo = $(this).attr("data-reply-no");
							console.log(replyNo);	
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
				method:"post",
				data :{boardNo:no, reportReason:reportReason},
				success:function(response){
				if(reportReason==null){
					$(".fail-feedback")	.css("display", "block");
				}
				else{
					$(".block-container")
					.prev(".btn-block").show();
					$(".block-container").remove();
					$(".block-container")
					.prev(".fail-feedback").hide();
				}
				},
			});
		});
		
		
			$(this).hide().after(blockHtmlTemplate);
		});
	//댓글 불러오기
	$.ajax({
		url:"/rest/board/boardReplyCount",
		data:{boardNo : no},
		success:function(response){
			$(".replyCount").text(response);
		}
	});
	 }
	 //큰 이미지 축소
// 	 $(".content-wrap").find("img").each(function() {
// 		  $(this).before("<br>");
// 		  $(this).after("<br>");
	
// 		 if ($(this).width() > 800) {
// 		    $(this).css({
// 		      "width": "75%",
// 		      "height": "75%"
// 		    });
// 		  }
// 		});

 });
 
 </script>

 <script id="reply-template" type="text/template">
<div class="row flex-container vertical view-container mt-20">
		<div class = "flex-container not-border">
	    	<div class="w-100">
		    	<div class="flex-container">
					<div class="row left">
						<img src="/images/user	.png"  width="35" height="24">
						<span class="replyWriter">작성자</span>
					<label class="replyTime"></label>	
					</div>
			    </div>
					<pre class="replyContent not-outline w-100 left" style="height: 42px; padding-left: 10px;"></pre>
		    	</div>
				<div class="right btn-wrap" style="width: 10%">
					<button class="btn-create w-100 h-100"><i class="fa-solid fa-ellipsis"></i></button>
					<button class="btn-hide btn-edit w-100 h-50">수정</button>
					<button class="btn-hide btn-delete w-100 h-50">삭제</button>
				</div>
	</div>
</div>
</script>



 <div class="container w-800">
  <script id="reply-edit-template" type="text/template">
	      <form class="reply-edit-form edit-contailner not-border">
			<input type="hidden" name="replyNo" value="?">	        
	        <div class="row flex-container">
				<div class="left w-80">
					<textarea name="replyContent" class="form-input w-100 h-100"></textarea>
				</div>
				<div class="flex-container w-20">
					<button type="submit" class="btn btn-positve w-50 h-100"><i class="fa-regular fa-paper-plane fa-2x rotate-icon"></i></button>
					<button class="btn btn-positve btn-cencle w-50 h-100"><i class="fa-solid fa-2x fa-xmark"></i></button>
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
						<option name="reportReason" selected disabled>신고사유</option>
					    <option name="reportReason" value="광고/음란성 글" >1. 광고/음란성 글</option>
					    <option name="reportReason" value="욕설/반말/부적절한 언어">2. 욕설/반말/부적절한 언어</option>
					    <option name="reportReason" value="회원 분란 유도">3. 회원 분란 유도</option>
					    <option name="reportReason" value="회원 비방">4. 회원 비방</option>
					    <option name="reportReason" value="지나친 정치/종교 논쟁">5. 지나친 정치/종교 논쟁</option>
					    <option name="reportReason" value="도배성 글">6. 도배성 글</option>
				</select>
				<label class="fail-feedback">내용을 선택해주세요</label>
			</form>
		</script>
		<div class="row w-100">
			<c:choose>
				<c:when test="${boardDto.boardCategory==42}">
					<pre class="crudTitle">자유게시판</pre>			
				</c:when>
				<c:when test="${boardDto.boardCategory==41}">
					<pre class="crudTitle">후기게시판</pre>
				</c:when>
				<c:otherwise>
					<pre class="crudTitle">여행정보</pre>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="flex-container">
        	<div class="row w-50 left">
        		<h2>${boardDto.boardTitle}</h2>
        	</div>
		        <div class="row me-10 mt-20 w-50 right" style="font-size: 20px;">
		            <span>${boardDto.boardCtime}</span>
		        </div>
		</div>
		<div class="flex-container">
        <div class="row left w-50">
        <c:choose>
				<c:when test="${attachNo == null}">
					<img src="/images/user.png" width="50" height="50"
						class="image image-circle image-border profile-image">
				</c:when>
				<c:otherwise>
				<img src="/rest/member/download?attachNo=${attachNo}" width="50" height="50"
				class="image image-circle image-border profile-image">
				</c:otherwise>
			</c:choose>
            <label style="font-size: 20px">${writerDto.memberNickname}</label>
        </div>
        <div class="row right mt-50 w-50" style="font-size: 18px;">
          <i class="fa-solid fa-heart red"></i> 좋아요 <label>0</label> | 조회수<label class="">${boardDto.boardReadcount}</label>
        </div>
		</div>
        <hr class="custom-hr">
        <div class="row left content-wrap">
           <article class="content">${boardDto.boardContent}</article>
        </div>
       
        
        <div class="row flex-container">
            <div class="col-2">
                <div class="left">
                    <button class = "btn-block"><img src="/images/Union.png"  width="35" height="14"></button>
                 </div>
            </div>
            <div class="col-2">
                <div class="right">
                <c:choose>
	                <c:when test="${boardDto.boardCategory==41}">
	                    <a href="/board/reviewList	"><button class="btn button btn-positive me-10">목록</button></a>
	                </c:when>
	                <c:when test="${boardDto.boardCategory==42}">
	                	<a href="/board/freeList"><button class="btn button btn-positive me-10">목록</button></a>
	                </c:when>
	                <c:otherwise>
	                	<a href="/board/list"><button class="btn button btn-positive me-10">목록</button></a>
	                </c:otherwise>
                </c:choose>
                    <c:if test="${sessionScope.name==boardDto.boardWriter||	memberDto.memberlevel=='관리자' }">
                    	<a href="/board/edit?boardNo=${boardDto.boardNo}"><button class="btn btn-positive button me-10">수정</button></a>
                    	<a href="/board/delete?boardNo=${boardDto.boardNo}"><button class="btn btn-positive button">삭제</button>	</a> 
                    </c:if>
                </div>
            </div>
        </div>	
		
		<div class="row left mt-50 count-font">
			댓글 <label class="replyCount"></label>
		</div>
	<c:if test="${sessionScope.name != null}">
		<form class="reply-insert-form">
		<input type="hidden" name="replyOrigin" value="${boardDto.boardNo}">
		<div class="row flex-container mt-10" style="height: 55px;">
				<input class="w-100 reply-input" name="replyContent"></input>
				<button class="btn center" style="border-left: none;"><i class="fa-regular fa-paper-plane fa-2x rotate-icon"></i></button>
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
  