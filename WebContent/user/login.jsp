<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<%@include file="../include/header.jsp" %>
<style type="text/css">

</style>
</head>
<body>
<div class="container-fluid">
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="../main/index.jsp">게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="#">리스트<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">글쓰기</a>
      </li>
      <c:if test="${user.name == null }">	<!-- 로그인 전 -->
      <li class="nav-item dropdown active">
        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" onclick="login()">
          	<span class="glyphicon glyphicon-log-in"></span>로그인
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">아이디/비밀번호 찾기</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">회원가입</a>
        </div>
      </li>
      </c:if>
      <c:if test="${user.name != null }">	<!-- 로그인 이후 -->
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	<label class="text text-primary">${sessionScope.user.name }</label> 님
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">내가 쓴 글</a>
          <a class="dropdown-item" href="#">회원정보</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">로그아웃</a>
        </div>
      </li>
      </c:if>
    </ul>
    <form class="form-inline my-2 my-sm-0">
      <input class="form-control mr-sm-2" type="search" placeholder="게시물 검색" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
</div>
	<hr><br><br><br>
	
<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col col-auto">

<form method="post" action="${path }/user_servlet/login.do">
   <div class="form-group row">
    <label for="userid" class="col-sm-4 col-form-label">아이디</label>
    <div class="col-md">
      <input class="form-control" name="userid" placeholder="ID">
    </div>
  </div>
  <div class="form-group row">
    <label for="pwd" class="col-sm-4 col-form-label">비밀번호</label>
    <div class="col-md-8">
      <input type="password" class="form-control" name="pwd" placeholder="Password">
    </div>
  </div>
   <div class="form-group row justify-content-center">
    <div class="col col-auto">
    	<input type="submit" class="btn btn-primary" value="로그인">
    </div>
   </div>
</form>

		</div>
	</div>
</div>
</body>
</html>