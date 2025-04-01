<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

</head>
<body>
	<div class="board-list mb-3 mt-3">
		
		<a href="<c:url value="/post/list"/>" class="btn btn<c:if test="${bo_num ne 0}">-outline</c:if>-success">전체</a>
		<c:forEach items="${boardList }" var="board">
			<a href="<c:url value="/post/list?bo_num=${board.bo_num }"/>" class="btn btn<c:if test="${bo_num ne board.bo_num}">-outline</c:if>-primary">
				${board.bo_name}
			</a>
		</c:forEach>
	</div>
	<h1>게시글 목록</h1>
	<table class="table table-hover">
		<thead>
		  <tr>
		    <th>번호</th>
		    <th>제목</th>
		    <th>작성자</th>
		    <th>작성일</th>
		    <th>조회수</th>
		    <th>추천/비추천</th>
		  </tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="post">
			  <tr>
			    <td>${post.po_num }</td>
			    <td>
			    	<a href="<c:url value="/post/detail/${post.po_num}"/>">${post.po_title}</a>
			    </td>
			    <td>${post.po_me_id }</td>
			    <td>
			    	<fmt:formatDate value="${post.po_date }" pattern="yyyy-MM-dd"/>
			    </td>
			    <td>${post.po_view }</td>
			    <td>${post.po_up }/${post.po_down }</td>
			  </tr>
		  	</c:forEach>
		  	<c:if test="${list.size() eq 0 }">
		  		<tr>
		  			<td colspan="6" class="text-center">등록된 게시글이 없습니다.</td>
		  		</tr>
		  	</c:if>
		</tbody>
	</table>
	
	<ul class="pagination justify-content-center">
		<c:if test="${!pm.prev }">
			<c:set var="prev" value="disabled" />
		</c:if>
		<c:url var="url" value="/post/list">
			<c:param name="bo_num" value="${pm.cri.bo_num }"/>
			<c:param name="page" value="${pm.startPage - 1}"/>
		</c:url>
	    <li class="page-item ${prev}">
	    	<a class="page-link" href="${url}">이전</a>
	    </li>
	    <c:forEach begin="${pm.startPage }" end="${pm.endPage}" var="i">
	    	<c:set var="active" value=""/>
	    	<c:if test="${pm.cri.page == i }">
	    		<c:set var="active" value="active"/>	
	    	</c:if>
	    	<c:url var="url" value="/post/list">
				<c:param name="bo_num" value="${pm.cri.bo_num }"/>
				<c:param name="page" value="${i}"/>
			</c:url>
		    <li class="page-item ${active }">
		    	<a class="page-link" href="${url}">${i}</a>
		    </li>
	    </c:forEach>
	    <c:if test="${!pm.next }">
			<c:set var="next" value="disabled" />
		</c:if>
		<c:url var="url" value="/post/list">
			<c:param name="bo_num" value="${pm.cri.bo_num }"/>
			<c:param name="page" value="${pm.endPage + 1}"/>
		</c:url>
	    <li class="page-item ${next}">
	    	<a class="page-link" href="${url}">다음</a>
	    </li>
	</ul>
	
	<div class="clearfix mb-3">
		<a href="<c:url value="/post/insert?bo_num=${bo_num}"/>" class="btn btn-outline-success float-right">게시글 등록</a>
	</div>
</body>
</html>