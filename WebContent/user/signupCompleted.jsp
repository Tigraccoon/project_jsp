<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
<%@include file="../include/header.jsp" %>
<%@include file="../include/signup_check.jsp" %>
<script type="text/javascript">
$(function(){
	$("#btnWrite").click(function(){
		location.href="${path}/board/write.jsp";
	});
	$("#logout").click(function(){
		location.href="${path}/user_servlet/logout.do";
	});
	$("#login").click(function(){
		location.href="../user/login.jsp";
	});
	$("#list").click(function(){
		location.href="${path}/board_servlet/list.do";
	});
	$("#main").click(function(){
		location.href="${path}/board_servlet/list.do";
	});
	$("#write").click(function(){
		location.href="../board/write.jsp";
	});
	$("#finduser").click(function(){
		location.href="../user/finduser.jsp";
	});
	$("#signup").click(function(){
		location.href="../user/signup.jsp";
	});
	$("#mylist").click(function(){
		location.href="${path}/board_servlet/myList.do?userid=${user.userid}";
	});
	$("#pwd_check").click(function(){
		location.href="../user/pwd_Check.jsp";
	});
});
</script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

</head>
<body>
<div class="container-fluid">
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#" id="main">게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="#" id="list">리스트<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" id="write">글쓰기</a>
      </li>
      <c:if test="${user.userid == null }">	<!-- 로그인 전 -->
      <li class="nav-item dropdown active">
        <a class="nav-link dropdown-toggle" href="../user/login.jsp" role="button" id="login" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	<i class="fa fa-sign-in"></i>&nbsp;로그인
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" id="finduser"><i class="fa fa-key"></i>&nbsp;아이디/비밀번호 찾기</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#" id="signup"><i class="fa fa-user-plus"></i>&nbsp;회원가입</a>
        </div>
      </li>
      </c:if>
      <c:if test="${user.userid != null }">	<!-- 로그인 이후 -->
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	<label class="text text-primary"><i class="fa fa-user-o"></i>&nbsp;${user.userid }</label> 님
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" id="mylist"><i class="fa fa-history"></i>&nbsp;내가 쓴 글</a>
          <a class="dropdown-item" href="#" id="pwd_check"><i class="fa fa-cog"></i>&nbsp;회원정보</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#" id="logout"><i class="fa fa-sign-out"></i>&nbsp;로그아웃</a>
        </div>
      </li>
      </c:if>
    </ul>
    <form class="form-inline my-2 my-sm-0" method="post" action="${path }/board_servlet/list.do">
      <input class="form-control mr-sm-2" id="search" name="search" type="search" placeholder="게시물 검색" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit"><i class="fa fa-search"></i>&nbsp;Search</button>
    </form>
  </div>
</nav>
</div>
	<hr><br><br><br>
	
	
	<!-- 내부 컨텐츠 -->
	<div class="progress" style="height: 50px;">
  		<div class="progress-bar bg-primary" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
  			<a href="../user/signup.jsp" class="btn btn-block text-dark"><i class="fa fa-check"></i>&nbsp;아이디/이메일 중복확인</a>
  		</div>
		<div class="progress-bar bg-info" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
			<a href="../user/signup_2.jsp" class="btn btn-block text-dark"><i class="fa fa-check"></i>&nbsp;상세 정보 입력</a>
		</div>
  		<div class="progress-bar bg-success" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
  			<a href="#" class="btn btn-block text-light"><i class="fa fa-star"></i>&nbsp;회원가입 완료</a>
  		</div>
  	</div>
  	<br><hr><br><br>
<div class="container-fluid">
 <div class="row justify-content-center">
  <div class="col col-auto">
  	
  	<h2><strong>${userid }</strong>님 회원가입에 성공하였습니다.</h2>
  	<br>
  	<a href="../user/login.jsp" class="btn btn-primary btn-block">로그인</a>
	
	
	
  </div>
 </div>
</div>

</body>
</html>