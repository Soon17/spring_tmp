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
					<c:if test="${co.co_del eq 'N' }">
						<div class="comment-writer">${co.co_me_id}</div>
						<div class="comment-content">${co.co_content}</div>
						<div>
							<button class="btn btn-outline-success btn-reply" data-num="${co.co_num}">답글</button>
							<c:if test="${co.co_me_id eq user.me_id}">
								<button class="btn btn-outline-warning btn-update" data-num="${co.co_num}">수정</button>
								<button class="btn btn-outline-danger btn-delete" data-num="${co.co_num}">삭제</button>
							</c:if>
						</div>
				</c:if>
				<c:if test="${co.co_del ne 'N' }">
					<div>작성자에 의해 삭제된 댓글입니다.</div>
				</c:if>
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
			
			if("${user.me_id}" == ""){ //${user.me_id} == "" 로 하면 로그인 상태가 아닐 경우 /  == "" 와 같아 오류가 남
				if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")){
					location.href = "<c:url value="/login"/>";
				}
				return;
			}
			if($(this).parent().next().length != 0) return;
			let num = $(this).data("num");
			let str = `
				<form class="comment-insert-form input-group" data-num="\${num}">
					<textarea name="content" class="form-control"></textarea>
					<button type="submit" class="btn btn-outline-success">답글 등록</button>
				</form>
			`;
			$(this).parent().after(str);				
		})
	</script>
	
	<script type="text/javascript">
		$(".btn-delete").click(function(e){
			let num = $(this).data("num");
			
			$.ajax({
				async : true,
				url : '<c:url value="/comment/delete"/>', 
				type : 'post', 
				data : {co_num : num}, 
				success : function (data){
					if(data){
						alert("댓글 삭제 성공!");
						getCommentList(cri);
					}else{
						alert("이미 삭제된 댓글이거나 없는 댓글!");
					}
				}
			});
		})
	</script>
	
	<script type="text/javascript">
		$(".btn-update").click(function(e){
			var $content = $(this).parents(".comment-item").find(".comment-content");
			//parent(요소): 요소의 모든 조상들을 타깃 , find("요소"): 모든 자식들 중 요소를 타깃
			
			var content = $content.text();
			$content.hide();
			if($content.nextAll(".comment-update-form").length != 0) return;
			let num = $(this).data("num");
			var str = `
				<form class="comment-update-form input-group" data-num="\${num}">
					<textarea name="content" class="form-control">\${content}</textarea>
					<button type="submit" class="btn btn-outline-success">댓글 수정</button>
				</form>
			`;
			//역따옴표를 사용할 때 서버 변수가 아닌 스크립트 변수 content를 인식하기 위해 역슬래시가 필요.
			
			$content.after(str);
			$(this).parent().hide();
		});
	</script>
</body>
</html>










