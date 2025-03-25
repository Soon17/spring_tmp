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
	<form action="<c:url value="/post/update"/>" method="post">
		<h1>게시글 수정</h1>
		
		<input type="hidden" name="po_num" value="${post.po_num}">
		<div class="form-group">
			<label for="board">게시판:</label>
			<div class="form-control">"${post.po_bo_name}"</div>
		</div>
		
		<div class="form-group">
		  <label for="title">제목:</label>
		  <input type="text" class="form-control" id="title" name="po_title" value="${post.po_title}">
		</div>
		
		<div class="form-group">
		  <label for="content">내용:</label>
		  <textarea class="form-control" id="content" name="po_content">${post.po_content}</textarea>
		</div>
		<button type="submit" class="btn btn-outline-success col-12 mb-3">게시글 수정</button>
	</form>
	<script>
      $('[name=po_content]').summernote({
        placeholder: 'Hello Bootstrap 4',
        tabsize: 2,
        height: 400
      });
      
      $("form").submit(function(e) {
    	  let obj = $("[name=po_title]");
    	  let title = obj.val().trim();
    	  
    	  if(title.length == 0){
    		  alert("제목을 입력하세요.");
    		  obj.focus();
    		  return false;
    	  }
      })
    </script>
</body>
</html>