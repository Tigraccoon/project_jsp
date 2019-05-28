<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<%@include file="../include/header.jsp" %>
<script type="text/javascript">
$(function(){
	$("#btnWrite").click(function(){
		location.href="${path}/board/write.jsp";
	});
});

</script>
</head>
<body>

<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col col-auto">
<table class="table table-hover">
<thead>
	<tr class="table-primary">
		<th scope="col">번호</th>
		<th scope="col">이름</th>
		<th scope="col">제목</th>
		<th scope="col">날짜</th>
		<th scope="col">조회수</th>
		<th scope="col">첨부파일</th>
		<th scope="col">다운로드</th>
	</tr>
</thead>
<tbody>
	<c:forEach var="list" items="${list }">
	<c:choose>
		<c:when test="${list.show == 'y' }">
		
		<tr>
			<th scope="row">${list.num }</th>
			<td>${list.writer }</td>
			<td style="text-align: left;">
				<c:forEach var="i" begin="1" end="${list.re_level }">
					&nbsp;&nbsp;
				</c:forEach>
				<a href="${path }/board_servlet/view.do?num=${list.num}">${list.subject } 
					<c:if test="${list.comment_count > 0 }">
						<label style="color: black">(${list.comment_count })</label>
					</c:if>
				</a>
			</td>
			<td>${list.reg_date }</td>
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
		<c:otherwise>
			<tr>
				<th>${list.num }</th>
				<th colspan="6">삭제된 게시물입니다.</th>
			</tr>
		</c:otherwise>
	</c:choose>
	</c:forEach>
</tbody>
</table>


<!-- 페이지 -->
<br><br>
<nav aria-label="Page navigation example">
  <ul class="pagination">
  <c:if test="${page.curPage > 1 }">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous" onclick="list('1')">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    </c:if>
    
    <c:if test="${page.curBlock > 1}">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous" onclick="list('${page.prevPage}')">
        <span aria-hidden="true">&lt;</span>
      </a>
    </li>
    </c:if>
    <c:forEach var="num" begin="${page.blockStart }" end="${page.blockEnd }">
	<c:choose>
		<c:when test="${num == page.curPage }">
			<li class="page-item"><a class="page-link" href="#">${num }</a></li>
		</c:when>
		<c:otherwise>
		<li class="page-item active" aria-current="page">
      		<a class="page-link" href="#" onclick="list('${num}')">${num }<span class="sr-only">(current)</span></a>
    	</li>
		</c:otherwise>
	</c:choose>
	</c:forEach>
	<c:if test="${page.curBlock < page.totBlock }">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next" onclick="list('${page.nextPage}')">
        <span aria-hidden="true">&gt;</span>
      </a>
    </li>
    </c:if>
    
    <c:if test="${page.curPage < page.totPage}">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next" onclick="list('${page.totPage}')">
        <span aria-hidden="true">&raquo;</span>
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