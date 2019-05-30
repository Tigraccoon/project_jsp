<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<%@include file="../include/header.jsp" %>
<%@include file="../include/login_check.jsp" %>

</head>
<body>
<div class="container-fluid">
	<div class="row">
		<div class="col">
		
<table class="table" style="width: 100%; text-align: left;">
	<tr class="table-primary">
		<th>댓글</th>
	</tr>
<c:forEach var="item" items="${c_list }">
	<tr class="table-primary">
		<td>
			<b>${item.c_writer }</b>&emsp;&emsp;&emsp;
			<i>(<fmt:formatDate value="${item.c_date }" pattern="yyyy-MM-dd hh:mm:ss E"/>)</i><br>
			${item.c_content }
		</td>
	</tr>
</c:forEach>
</table>

		</div>
	</div>
</div>

</body>
</html>