<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글</title>
<%@include file="../include/header.jsp" %>
<%@include file="../include/login_check.jsp" %>
<script type="text/javascript">
$(function(){
	comment_list();
	$("#btnSave").click(function(){
		comment_add();
	});
	
	$("#btnList").click(function(){
		location.href="${path}/board_servlet/list.do";
	});
	
	$("#btnDelete").click(function(){
		document.form1.action="${path}/board_servlet/contentDelete.do";
		document.form1.submit();
	});
	$("#btnUpdate").click(function(){
		document.form1.action="${path}/board_servlet/contentUpdate.do";
		document.form1.submit();
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

function comment_add(){
	var param="board_num=${list.num}&c_writer=${user.userid}" + "&c_content=" + $("#c_content").val();
	
	$.ajax({
		type : "post",
		url : "${path}/board_servlet/comment_add.do",
		data : param,
		success : function(){
			$("#c_writer").val("");
			$("#c_content").val("");
			comment_list();
		}
	});
}

function comment_list(){
	$.ajax({
		type : "post",
		url : "${path}/board_servlet/commentList.do",
		data : "num=${list.num}",
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
    <form class="form-inline my-2 my-sm-0" method="post" action="${path }/board_servlet/list.do">
      <input class="form-control mr-sm-2" id="search" name="search" type="search" placeholder="게시물 검색" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit"><i class="fa fa-search"></i>&nbsp;Search</button>
    </form>
  </div>
</nav>
</div>
	<hr><br><br><br>
	
	<!-- 내부 -->
	
<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col col-10">
<table class="table table-bordered"  style="width: 100%; text-align: center;">
	<tr class="table-primary">
		<td width="5%">${list.num }</td>	
		<td width="60%">${list.subject }</td>
		<td width="15%">${list.writer }</td>
		<td width="20%"><fmt:formatDate value="${list.reg_date }" pattern="yyyy-MM-dd hh:mm:ss E"/></td>
	</tr>
	<tr class="table-primary">
		<td colspan="4" height="500%">${list.content }</td>
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
		<td colspan="4">
<c:if test="${user.userid == list.writer }">
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#update">
  				수정
			</button>
</c:if>	
			<input type="button" id="btnList" value="리스트" class="btn btn-info">
		</td>
	</tr>
</table>

<!-- 글 수정 모달 -->
<form action="" name="form1" method="post" enctype="multipart/form-data" class="was-validated">
<div class="modal fade" id="update" tabindex="-1" role="dialog" aria-labelledby="updateLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="updateLabel">글 수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
<table class="table table-borderless"  style="width: 100%; text-align: center;">
	<tr class="table-primary">
		<th><label for="subject">제목</label></th>
	</tr>
	<tr class="table-primary">	
		<td><input type="text" name="subject" id="subject" class="form-control" value="${list.subject }" required>
	</tr>
	<tr class="table-primary">
		<th><label for="content">본문</label></th>
	</tr>
	<tr class="table-primary">
		<td><textarea rows="10" cols="60" name="content" id="content" class="form-control is-invalid" required>${list.content }</textarea></td>
	</tr>
	<tr class="table-primary">
		<td>
  			<div class="custom-file lg">
  			<c:if test="${list.filesize > 0 }">
				${list.filename } (${list.filesize / 1024 } KB)
				<input type="checkbox" name="fileDel" id="fileDel"> 첨부파일 삭제
				<br>
			</c:if>
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
</table>

      </div>
      <div class="modal-footer">
      	<input type="hidden" name="num" id="num" value="${list.num }">
      	<input type="hidden" name="writer" value="${list.writer }">
      	<input type="button" id="btnUpdate" value="수정" class="btn btn-primary">
		<input type="button" id="btnDelete" value="삭제" class="btn btn-danger">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
</form>


<br><hr><br>
	<form method="post">
		<table class="table" style="width: 100%; text-align: left;">
			<tr class="table-success">
				<th colspan="2">댓글쓰기</th>
			</tr>
			<tr class="table-success">
				<td width="80%">
					<b>${user.userid }</b><br>
					<textarea rows="3" cols="80" placeholder="댓글을 입력하세요" id="c_content" class="form-control" name="c_content"></textarea>
				</td>
				<th><button id="btnSave" class="btn btn-block btn-primary">확인</button></th>
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