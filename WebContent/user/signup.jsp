<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<%@include file="../include/header.jsp" %>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

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
      <c:if test="${sessionScope.user.name == null }">	<!-- 로그인 전 -->
      <li class="nav-item dropdown active">
        <a class="nav-link dropdown-toggle" href="#" role="button" id="login" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	<i class="fa fa-sign-in"></i>&nbsp;로그인
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#"><i class="fa fa-key"></i>&nbsp;아이디/비밀번호 찾기</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#"><i class="fa fa-user-plus"></i>&nbsp;회원가입</a>
        </div>
      </li>
      </c:if>
      <c:if test="${user.userid != null }">	<!-- 로그인 이후 -->
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	<label class="text text-primary"><i class="fa fa-user-o"></i>&nbsp;${user.userid }</label> 님
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#"><i class="fa fa-history"></i>&nbsp;내가 쓴 글</a>
          <a class="dropdown-item" href="#"><i class="fa fa-cog"></i>&nbsp;회원정보</a>
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
	
	
	<!-- 내부 컨텐츠 -->
	<div class="progress" style="height: 50px;">
  		<div class="progress-bar bg-primary" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"><a href="#" class="btn btn-block text-light">아이디/이메일 중복확인</a></div>
		<div class="progress-bar bg-info" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><a href="#" class="btn btn-block text-dark">상세 정보 입력</a></div>
  		<div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><a href="#" class="btn btn-block text-dark">회원가입 완료</a></div>
  	</div>
  	<br><hr><br><br>
<div class="container-fluid">
 <div class="row justify-content-center">
  <div class="col col-md-8">
  	
  
	<form action="" method="post" name="form1" id="form1">
	
  		<c:if test="${userid == null }">
  			<div class="form-group row justify-content-center">
    			<div class="col col-auto">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
 						<strong>${userid }</strong>
  						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
    						<span aria-hidden="true">&times;</span>
  						</button>
					</div>
    			</div>
  			</div>
  		</c:if>
  		<div class="form-group row">
    		<label for="userid" class="col-md-4 col-form-label">ID</label>
    		<div class="col-md-8">
      			<input class="form-control" id="userid" name="userid" placeholder="ID" autocomplete="off">
    		</div>
  		</div>
  		
  		<div class="form-group row">
    		<label for="email" class="col-md-4 col-form-label">Email</label>
    		<div class="col-md-8">
      			<input type="email" class="form-control" id="email" placeholder="email@example.com" autocomplete="off">
    		</div>
  		</div>
  		
  		
		<br>
		<div class="form-group row justify-content-center">
			<div class="col col-auto">
				<input type="submit" value="상세 정보 입력" id="btnSubmit" class="btn btn-primary btn-lg">
				<input type="reset" value="입력 초기화" class="btn btn-danger btn-lg">
			</div>
		</div>
	
	</form>
	
	
	
  </div>
 </div>
</div>



</body>
</html>