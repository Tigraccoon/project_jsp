<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글</title>
<%@include file="../include/header.jsp" %>
<%-- <%@include file="../include/login_check.jsp" %> --%>

<script type="text/javascript">
$(function(){
	comment_list();
	$("#btnSave").click(function(){
		comment_add();
	});
	
	$("#btnList").click(function(){
		location.href="${path}/board_servlet/list.do";
	});
	
	$("#btnReply").click(function(){
		document.form1.action="${path}/board_servlet/reply.do";
		document.form1.submit();
	});
	$("#btnEdit").click(function(){
		document.form1.action="${path}/board_servlet/pass_check.do";
		document.form1.submit();
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

function comment_add(){
	var param="board_num=${dto.num}&writer=" + $("#writer").val() 
				 + "&content=" + $("#content").val();
	
	$.ajax({
		type : "post",
		url : "${path}/board_servlet/comment_add.do",
		data : param,
		success : function(){
			$("#writer").val("");
			$("#content").val("");
			comment_list();
		}
	});
}

function comment_list(){
	$.ajax({
		type : "post",
		url : "${path}/board_servlet/commentList.do",
		data : "num=${dto.num}",
		success : function(result){
			$("#commentList").html(result);
		}
	});
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
      <li class="nav-item active">
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
<form action="" name="form1" method="post">
<table class="table table-borderless"  style="width: 100%; text-align: center;">
	<tr class="table-primary">
		<td width="5%">${list.num }</td>	
		<td width="60%">${list.subject }</td>
		<td width="15%">${list.writer }</td>
		<td width="20%">${list.reg_date }</td>
	</tr>
	<tr class="table-primary">
		<td colspan="4">${list.content }</td>
	</tr>
	<c:if test="${list.filesize > 0}">
	<tr class="table-primary">
			<td colspan="4">
				${list.filename}( ${list.filesize} bytes )
				<a href="${path}/board_servlet/download.do?num=${list.num}" class="btn btn-primary">다운로드</a>
			</td>
	</tr>
	</c:if>
	<tr class="table-primary">
		<td>
<c:if test="${user.userid == $list.writer }">
			<input type="button" id="btnUpdate" value="수정" class="btn btn-block btn-primary">
			<input type="button" id="btnDelete" value="삭제" class="btn btn-block btn-danger">
</c:if>	
			<input type="hidden" name="num" value="${list.num }">
			<input type="button" value="리스트" class="btn btn-block btn-info">
		</td>
	</tr>
</table>
</form>
<br><hr><br>
	<form method="post">
		<table>
			<tr>
				<th colspan="3">댓글쓰기</th>
			</tr>
			<tr>
				<th><label for="writer">이름</label></th>
				<td><input id="writer" class="form-control"></td>
			</tr>
			<tr>
				<th><label for="content">내용</label></th>
				<td width="70%">
					<textarea rows="3" cols="80" placeholder="댓글을 입력하세요" id="content" class="form-control"></textarea>
				</td>
				<th rowspan="2"><button id="btnSave" class="btn btn-primary">확인</button></th>
			</tr>
		</table>
	</form>
	<br><hr><br>
	<div id="commentList"></div>
	<br><br><br>
		</div>
	</div>
</div>

</body>
</html>