<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
	<h1>댓글</h1>
	<c:if test="${list.size() != 0}">
		<div class="comment-list">
			<c:forEach items="${list}" var="co">
				<div class="comment-item <c:if test="${co.co_num ne co.co_ori_num}">pl-5</c:if>">
					<div class="comment-writer">${co.co_me_id}</div>
					<div class="comment-content">${co.co_content}</div>
					<div>
						<button class="btn btn-outline-success btn-reply" data-num="${co.co_num}">답글</button>
						<button class="btn btn-outline-warning">수정</button>
						<button class="btn btn-outline-danger">삭제</button>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<div class="comment-pagination mt-3">
			<ul class="pagination justify-content-center">
				<c:if test="${!pm.prev }">
					<c:set var="prev" value="disabled" />
				</c:if>
			    <li class="page-item ${prev}">
			    	<a class="page-link" href="javascript:void(0);" data-page="${pm.startPage-1}">이전</a>
			    </li>
			    <c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
			    	<c:set var="active" value=""/>
			    	<c:if test="${pm.cri.page == i }">
			    		<c:set var="active" value="active"/>	
			    	</c:if>
				    <li class="page-item ${active}">
				    	<a class="page-link" href="javascript:void(0);" data-page="${i}">${i}</a>
				    </li>
			    </c:forEach>
			    <c:if test="${!pm.next }">
					<c:set var="next" value="disabled" />
				</c:if>
			    <li class="page-item ${next}">
			    	<a class="page-link" href="javascript:void(0);" data-page="${pm.endPage+1}">다음</a>
			    </li>
			  </ul>
		</div>
	</c:if>
	<c:if test="${list.size() == 0}">
		<div class="text-center">등록된 댓글이 없습니다.</div>
	</c:if>
	
	<script type="text/javascript">
		$(".comment-pagination .page-link").click(function(e){
			cri.page = $(this).data("page");
			getCommentList(cri);
		});
	</script>
	
	<script type="text/javascript">
		$(document).on("click", ".btn-reply", function(e){
			if($(this).parent().next().length != 0) return;
			let num = $(this).data("num");
			let str = `
				<form class="comment-insert-form" data-num="\${num}">
					<textarea name="content"></textarea>
					<button type="submit">댓글 등록</button>
				</form>
			`;
			$(this).parent().after(str);				
		})
	</script>
</body>
</html>