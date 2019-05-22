<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${param.message == 'login'}">
	<script>
		alert("로그인 되었습니다!");
	</script>
</c:if>
    