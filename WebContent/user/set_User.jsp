<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<%@include file="../include/header.jsp" %>
<%@include file="../include/login_check.jsp" %>

<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script type="text/javascript"> 
	$(function() { 
		$("#postcodify_search_button").postcodifyPopUp();
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
	
	function doUpdate(){
		var userid = $("#userid");
		var pwd = $("#pwd");
		var name = $("#name");
		var email = $("#email");
		var hp = $("#hp");
		var zipcode = $("#zipcode");
		var address1 = $("#address1");
		var address2 = $("#address2");
		
		if(pwd.val() == ""){	
			alert("비밀번호를 입력해주세요!");
			pwd.focus();	
			return;
		}
		if(name.val() == ""){	
			alert("이름을 입력해주세요!");
			name.focus();	
			return;
		}
		if(hp.val() == ""){	
			alert("전화번호를 입력해주세요!");
			hp.focus();	
			return;
		}
		if(zipcode.val() == ""){	
			alert("주소를 검색해주세요!");
			zipcode.focus();	
			return;
		}
		if(address2.val() == ""){	
			alert("상세주소를 입력해주세요!");
			address2.focus();	
			return;
		}
		
		alert("회원정보가 수정됩니다. 다시 로그인해주세요.");
		document.form1.action="${path}/user_servlet/update.do";
		document.form1.submit();
	}
	
	function doDelete(){
		if(confirm("정말 회원 탈퇴하시겠습니까?")==true){
			
			document.form1.action="${path}/user_servlet/delete.do";
			document.form1.submit();
		} else{
			return;
		}
		
	}
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
        <a class="nav-link" href="#" id="list">리스트<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" id="write">글쓰기</a>
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
      <li class="nav-item dropdown active">
        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	<label class="text text-primary"><i class="fa fa-user-o"></i>&nbsp;${user.userid }</label> 님
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" id="mylist"><i class="fa fa-history"></i>&nbsp;내가 쓴 글</a>
          <a class="dropdown-item active" href="#" id="pwd_check"><i class="fa fa-cog"></i>&nbsp;회원정보</a>
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
	
  	<br><hr><br><br>
	
	
	<!-- 내부 컨텐츠 -->
	
<div class="container-fluid">
 <div class="row justify-content-center">
  <div class="col col-md-8">
  	<h2>회원 정보</h2>
  <br><br>
	<form action="" method="post" name="form1" id="form1">
	
  		<div class="form-group row">
    		<label for="userid" class="col-md-4 col-form-label">ID</label>
    		<div class="col-md-8">
      			<input class="form-control" id="userid" name="userid" readonly="readonly" value="${user.userid }">
    		</div>
  		</div>
  		
  		<div class="form-group row">
    		<label for="pwd" class="col-md-4 col-form-label">Password</label>
    		<div class="col-md-8">
      			<input type="password" class="form-control" id="pwd" name="pwd" placeholder="Password" autocomplete="off">
    		</div>
  		</div>
  		
  		<div class="form-group row">
    		<label for="name" class="col-md-4 col-form-label">이름</label>
    		<div class="col-md-8">
      			<input class="form-control" id="name" name="name" placeholder="이름" autocomplete="off" value="${user.name }">
    		</div>
  		</div>
  		
  		<div class="form-group row">
    		<label for="email" class="col-md-4 col-form-label">Email</label>
    		<div class="col-md-8">
      			<input type="email" class="form-control" id="email" name="email" readonly="readonly"  value="${user.email }">
    		</div>
  		</div>
  		
  		<div class="form-group row">
    		<label for="hp" class="col-md-4 col-form-label">전화번호</label>
    		<div class="col-md-8">
      			<input type="tel" class="form-control" id="hp" name="hp" placeholder="010-1234-5678" autocomplete="off"  value="${user.hp }">
    		</div>
  		</div>
  		
  		<div class="form-group row">
			<label for="postcodify_search_button" class="col-md-4 col-form-label">우편번호</label>
			 	<div class="col-md-4">
  					<input name="zipcode" id="zipcode" class="postcodify_postcode5 form-control" autocomplete="off" readonly="readonly" placeholder="우편번호를 검색하세요."  value="${user.zipcode }">
				</div>
				<div class="col-md-4">
					<input type="button" id="postcodify_search_button" class="btn btn-info btn-block" value="검색">
				</div>
		</div>
		<div class="form-group row">
			<label for="postcodify_search_button" class="col-md-4 col-form-label">주소</label>
    		<div class="col-md-8">
  				<input name="address1" id="address1" class="postcodify_address form-control" readonly="readonly" placeholder="주소를 검색하세요."  value="${user.address1 }">
  			</div>
		</div>
		<div class="form-group row">
			<label for="address2" class="col-md-4 col-form-label">상세주소</label>
    		<div class="col-md-8">
				<input name="address2" id="address2" class="postcodify_details form-control" autocomplete="off" placeholder="상세 주소를 입력하세요."  value="${user.address2 }">
  			</div>
		</div>
		<div class="form-group row">
			<label for="address2" class="col-md-4 col-form-label">가입일</label>
    		<div class="col-md-8">
				<input class="postcodify_details form-control"   value="${user.join_date }" readonly="readonly">
  			</div>
		</div>
		<br>
		<div class="form-group row justify-content-center">
			<div class="col col-auto">
				<input type="button" value="회원 정보 수정" id="btnUpdate" class="btn btn-primary btn-lg" onclick="doUpdate()">
				<input type="button" value="회원 탈퇴" id="btnDelete" class="btn btn-danger btn-lg" onclick="doDelete()">
			</div>
		</div>
	
	</form>
	
	
	
  </div>
 </div>
</div>


</body>
</html>