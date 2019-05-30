<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>
<%@include file="../include/header.jsp" %>
<%@include file="../include/login_check.jsp" %>

<script type="text/javascript">
$(function(){
	$("#btnWrite").click(function(){
		location.href="../board/write.jsp";
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
          <a class="dropdown-item active" href="#" id="mylist"><i class="fa fa-history"></i>&nbsp;내가 쓴 글</a>
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
	
<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col col-10">
<table class="table table-hover" style="text-align: center;">
<thead>
	<tr class="table-primary" style="width: 1000px;">
		<th scope="col">번호</th>
		<th scope="col">이름</th>
		<th scope="col" width="50%">제목</th>
		<th scope="col">날짜</th>
		<th scope="col">조회수</th>
		<th scope="col">첨부파일</th>
		<th scope="col">다운로드</th>
	</tr>
</thead>
<tbody>
	<c:forEach var="list" items="${list }">
	<c:if test="${list.content == '글이 없음...' }">
		<tr>
			<td colspan="7">작성한 글이 없습니다.</td>
		</tr>
	</c:if>
	<c:choose>
		<c:when test="${list.show == 'y' || user.userid == list.writer}">
		<tr>
			<th scope="row">${list.num }</th>
			<td>${list.writer }</td>
			<td style="text-align: left;">
				<a href="${path }/board_servlet/view.do?num=${list.num}">${list.subject } 
					<c:if test="${list.comment_count > 0 }">
						<label style="color: black">(${list.comment_count })</label>
					</c:if>
				</a>
			</td>
			<td><fmt:formatDate value="${list.reg_date }" pattern="yyyy-MM-dd hh:mm:ss E"/></td>
			<td>${list.readcount }</td>
			<td>
				<c:if test="${list.filesize > 0}">
					<a href="${path }/board_servlet/download.do?num=${list.num}">
						<img alt="파일 이미지" src="../images/file.gif">
					</a>
				</c:if>
				<c:if test="${list.filesize == 0 }">
					-
				</c:if>
			</td>
			<td>${list.down }</td>
		</tr>
		</c:when>
		<c:when test="${list.show == 'n' }">
			<tr>
				<th>${list.num }</th>
				<th colspan="6">삭제된 게시물입니다.</th>
			</tr>
		</c:when>
		<c:when test="${list.show == 's' || user.userid != list.writer}">
			<tr>
				<th>${list.num }</th>
				<td>${list.writer }</td>
				<td colspan="5"><i class="fa fa-lock"></i>&nbsp;비밀 게시물입니다.</td>
			</tr>
		</c:when>
	</c:choose>
	</c:forEach>
</tbody>
</table>


<!-- 페이지 -->
<br><br>
<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
<c:if test="${page.curPage > 1 }">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous" onclick="list('1')">
        <span aria-hidden="true">&laquo;</span><!-- 처음 -->
      </a>
    </li>
</c:if>
<c:if test="${page.curBlock > 1}">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous" onclick="list('${page.prevPage}')">
        <span aria-hidden="true">&lt;</span><!-- 이전 -->
      </a>
    </li>
</c:if>
<c:forEach var="num" begin="${page.blockStart }" end="${page.blockEnd }">
	<c:choose>
		<c:when test="${num == page.curPage }"><!-- 현제 패이지 -->
			<li class="page-item active" aria-current="page">
				<span class="page-link">${num }<span class="sr-only">(current)</span></span>
			</li>
		</c:when>
		<c:otherwise>
		<li class="page-item"><!-- 페이지들 -->
      		<a class="page-link" href="#" onclick="list('${num}')">${num }</a>
    	</li>
		</c:otherwise>
	</c:choose>
	</c:forEach>
<c:if test="${page.curBlock < page.totBlock }">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next" onclick="list('${page.nextPage}')">
        <span aria-hidden="true">&gt;</span><!-- 다음 -->
      </a>
    </li>
    </c:if>
    
<c:if test="${page.curPage < page.totPage}">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next" onclick="list('${page.totPage}')">
        <span aria-hidden="true">&raquo;</span><!-- 끝 -->
      </a>
    </li>
    </c:if>
  </ul>
</nav>
<br>
<button id="btnWrite" class="btn btn-block btn-primary">글쓰기</button><br>

<br><br><br>
			
		</div>
	</div>
</div>

</body>
</html>