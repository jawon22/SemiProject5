<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	$(function(){
		
		$.ajax({
			url:"http://localhost:8080/rest/member/stat/birth",
			dataType: "json",
			success:function(response){
				var labels = [], data = [];
				
				for(var i=0; i < response.length; i++){
					labels.push(response)
				}
			}
			
		});
		
	});

</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
