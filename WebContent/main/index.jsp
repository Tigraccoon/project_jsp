<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<%@include file="../include/header.jsp" %>

</head>
<body>
<div id="result"></div>
<script type="text/javascript">
$(function(){
	list('1');
});

function list(curPage){
	var param = "curPage=" + curPage;
	
	$.ajax({
		type : "post",
		url : "${path}/board_servlet/list.do",
		data : param,
		success : function(result){	
			$("#result").html(result);
		}		
	});
}


</script>

</body>
</html>