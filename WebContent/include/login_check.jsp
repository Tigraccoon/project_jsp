<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${user.userid == null }">
	<script>
		alert("로그인 후 이용해주세요.");
		location.href="../user/login.jsp";
	</script>
</c:if>
