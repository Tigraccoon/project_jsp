<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${user.userid == null }">
	<script>
		alert("잘못된 접근입니다. 로그인하세요!");
		location.href="../main/index.jsp";
	</script>
</c:if>
