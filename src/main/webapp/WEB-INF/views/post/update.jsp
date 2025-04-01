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
	<form action="<c:url value="/post/update"/>" method="post" enctype="multipart/form-data">
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
		<div class="form-group att">
			<label>첨부파일</label>
			<c:forEach items="${list}" var="file">
				<div class="form-control d-flex justify-content-between" >
					<span>${file.fi_ori_name}</span>
					<a href="javascript:void(0)" data-num="${file.fi_num}" class="close">&times;</a>
				</div>
			</c:forEach>
			<c:forEach begin="1" end="${3 - list.size()}">
				<input type="file" class="form-control" name="fileList"/>
			</c:forEach>
				
		</div>
		<button type="submit" class="btn btn-outline-success col-12 mb-3">게시글 수정</button>
	</form>
	
	<script type="text/javascript">
		$(".close").click(function(e){
			console.log()
			let fi_num = $(this).data("num");
			let str = `
				<input type="file" class="form-control" name="fileList"/>
				<input type="hidden" name="delNums" value="\${fi_num}"/>
			`;
			$(".att").append(str);
			$(this).parent().remove();
		})
	</script>
	
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