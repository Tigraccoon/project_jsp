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
    		<label for="pwd" class="col-md-4 col-form-label">Password</label>
    		<div class="col-md-8">
      			<input type="password" class="form-control" id="pwd" name="pwd" placeholder="Password" autocomplete="off">
    		</div>
  		</div>
  		
  		<div class="form-group row">
    		<label for="pwd" class="col-md-4 col-form-label">Password Check</label>
    		<div class="col-md-8">
      			<input type="password" class="form-control" id="pwd" name="pwd" placeholder="Password Check" autocomplete="off">
    		</div>
  		</div>
  		
  		
  		<div class="form-group row">
    		<label for="name" class="col-md-4 col-form-label">이름</label>
    		<div class="col-md-8">
      			<input class="form-control" id="name" name="name" placeholder="이름" autocomplete="off">
    		</div>
  		</div>
  		
  		<div class="form-group row">
    		<label for="email" class="col-md-4 col-form-label">Email</label>
    		<div class="col-md-8">
      			<input type="email" class="form-control" id="email" placeholder="email@example.com" autocomplete="off">
    		</div>
  		</div>
  		
  		<div class="form-group row">
    		<label for="hp" class="col-md-4 col-form-label">전화번호</label>
    		<div class="col-md-8">
      			<input type="tel" class="form-control" id="hp" name="hp" placeholder="010-1234-5678" autocomplete="off">
    		</div>
  		</div>
  		
  		<div class="form-group row">
			<label for="postcodify_search_button" class="col-md-4 col-form-label">우편번호</label>
			 	<div class="col-md-4">
  					<input name="zipcode" id="zipcode" class="postcodify_postcode5 form-control" autocomplete="off" readonly="readonly" placeholder="우편번호를 검색하세요.">
				</div>
				<div class="col-md-4">
					<input type="button" id="postcodify_search_button" class="btn btn-info btn-block" value="검색">
				</div>
		</div>
		<div class="form-group row">
			<label for="postcodify_search_button" class="col-md-4 col-form-label">주소</label>
    		<div class="col-md-8">
  				<input name="address1" id="address1" class="postcodify_address form-control" readonly="readonly" placeholder="주소를 검색하세요.">
  			</div>
		</div>
		<div class="form-group row">
			<label for="address2" class="col-md-4 col-form-label">상세주소</label>
    		<div class="col-md-8">
				<input name="address2" id="address2" class="postcodify_details form-control" autocomplete="off" placeholder="상세 주소를 입력하세요.">
  			</div>
		</div>
		<br>
		<div class="form-group row justify-content-center">
			<div class="col col-auto">
				<input type="button" value="회원가입" id="btnSubmit" class="btn btn-primary btn-lg" onclick="doSubmit()">
				<input type="reset" value="입력 초기화" class="btn btn-danger btn-lg">
			</div>
		</div>
	
	</form>
	
	
	
  </div>
 </div>
</div>

<script type="text/javascript"> 
	$(function() { 
		$("#postcodify_search_button").postcodifyPopUp();
	}); 
	
	function doSubmit(){
		var userid = $("#userid");
		var pwd = $("#pwd");
		var name = $("#name");
		var email = $("#email");
		var hp = $("#hp");
		var zipcode = $("#zipcode");
		var address1 = $("#address1");
		var address2 = $("#address2");
		
		if(userid.val() == ""){	
			<%pageContext.setAttribute("w_id", "아이디를 입력해주세요!");%>
			alert("아이디를 입력해주세요!");
			userid.focus();	
			return;
		}
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
		if(email.val() == ""){	
			alert("이메일을 입력해주세요!");
			userid.focus();	
			return;
		}
		if(userid.val() == ""){	
			alert("아이디를 입력해주세요!");
			userid.focus();	
			return;
		}
		if(userid.val() == ""){	
			alert("아이디를 입력해주세요!");
			userid.focus();	
			return;
		}
		if(userid.val() == ""){	
			alert("아이디를 입력해주세요!");
			userid.focus();	
			return;
		}
		if(userid.val() == ""){	
			alert("아이디를 입력해주세요!");
			userid.focus();	
			return;
		}
		if(pwd==""){	
			alert("비밀번호를 입력해주세요!");
			$("#pwd").focus();	
			return;		
		}
		if(name.val() == ""){
			alert("이름을 입력해주세요");
			name.focus();
			return;
		}
		if(email==""){	
			alert("이메일을 입력해주세요!");
			document.getElementById("email").focus();	
			return;		
		}
		if(hp==""){	
			alert("전화번호를 입력해주세요!");
			document.getElementById("hp").focus();	
			return;		
		}
		if(zipcode==""){	
			alert("우편번호를 입력해주세요!");
			document.getElementById("zipcode").focus();	
			return;		
		}
		if(address1==""){	
			alert("주소1을 입력해주세요!");
			document.getElementById("address1").focus();	
			return;		
		}
		if(address2==""){	
			alert("주소2를 입력해주세요!");
			document.getElementById("address2").focus();	
			return;		
		}
		
		document.form1.action="${path}/user_servlet/signup.do";
		document.form1.submit();
	}
</script>

</body>
</html>