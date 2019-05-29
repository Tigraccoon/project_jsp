<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<%@include file="../include/header.jsp" %>
<%@include file="../include/login_check.jsp" %>

<script type="text/javascript">
$(function(){
	$("#logout").click(function(){
		location.href="${path}/user_servlet/logout.do";
	});
	$("#login").click(function(){
		location.href="../user/login.jsp";
	});
	$("#list").click(function(){
		location.href="../main/index.jsp";
	});
	$("#main").click(function(){
		location.href="../main/index.jsp";
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
		location.href="../user/mylist.jsp";
	});
	$("#pwd_check").click(function(){
		location.href="../user/pwd_Check.jsp";
	});
});

</script>
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
        <a class="nav-link" href="#" id="list">리스트</a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="#" id="write">글쓰기<span class="sr-only">(current)</span></a>
      </li>
      <c:if test="${user.userid == null }">	<!-- 로그인 전 -->
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" role="button" id="login" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
    <form class="form-inline my-2 my-sm-0">
      <input class="form-control mr-sm-2" type="search" placeholder="게시물 검색" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit"><i class="fa fa-search"></i>&nbsp;Search</button>
    </form>
  </div>
</nav>
</div>
	<hr><br><br><br>
	
<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col col-10">
<form action="${path}/board_servlet/write.do" name="form1" method="post" enctype="multipart/form-data" class="was-validated">
<table class="table table-borderless"  style="width: 100%; text-align: center;">
	<tr class="table-primary">
		<th><label for="subject">제목</label></th>
	</tr>
	<tr class="table-primary">	
		<td><input type="text" name="subject" id="subject" class="form-control" placeholder="제목을 입력하세요." required>
	</tr>
	<tr class="table-primary">
		<th><label for="content">본문</label></th>
	</tr>
	<tr class="table-primary">
		<td><textarea rows="10" cols="60" name="content" id="content" class="form-control is-invalid" required></textarea></td>
	</tr>
	<tr class="table-primary">
		<td>
  			<div class="custom-file lg">
    			<input type="file" class="form-control" name="file1" id="file1">
  			</div>
		</td>
	</tr>
	<tr class="table-primary">
		<td>
	 		<div class="form-check">
   				<input type="checkbox" id="show" name="show" value="s" class="form-check-input">
      			<label class="form-check-label" for="show">비밀글</label>
	    	</div>
		</td>
	</tr>
	<tr class="table-primary">
		<td>
			<input type="submit" value="글쓰기" class="btn btn-block btn-primary">
			<input type="hidden" name="writer" value="${user.userid }">
		</td>
	</tr>
</table>
</form>			
		</div>
	</div>
</div>

</body>
</html>