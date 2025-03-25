<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs4.min.js"></script>
</head>
<body>
	<form action="<c:url value="/post/insert"/>" method="post">
		<div class="form-group">
		  <label for="title">제목:</label>
		  <input type="text" class="form-control" id="title" name="po_title">
		</div>
		<div class="form-group">
		  <label for="board">게시판:</label>
		  <select class="form-control" id="board" name="po_bo_num">
		  	<c:forEach items="${boardList}" var="board">
		  		<option value="${board.bo_num}" <c:if test="${board.bo_num eq bo_num }">selected</c:if> >
		  			${board.bo_name }
		  		</option>
		  	</c:forEach>
		  </select>
		</div>
		<div class="form-group">
		  <label for="content">내용:</label>
		  <textarea class="form-control" id="content" name="po_content"></textarea>
		</div>
		<button type="submit" class="btn btn-outline-success col-12 mb-3">게시글 등록</button>
	</form>
	<script>
      $('[name=po_content]').summernote({
        placeholder: 'Hello Bootstrap 4',
        tabsize: 2,
        height: 400
      });
    </script>
</body>
</html>