<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<h1>게시글 상세</h1>
	<div class="form-group">
		<label>게시판</label>
		<div class="form-control">${post.po_bo_name}</div>
	</div>
	<div class="form-group">
		<label>제목</label>
		<div class="form-control">${post.po_title}</div>
	</div>
	<div class="form-group">
		<label>작성자</label>
		<div class="form-control">${post.po_me_id}</div>
	</div>
	<div class="form-group">
		<label>작성일</label>
		<div class="form-control">
			<fmt:formatDate value="${post.po_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
		</div>
	</div>
	<div class="form-group">
		<label>조회수</label>
		<div class="form-control">${post.po_view}</div>
	</div>
	<div class="form-group d-flex justify-content-center">
		<button class="btn btn-outline-success mr-2 btn-up" data-num="${post.po_num}" data-state="1">추천</button>
		<button class="btn btn-outline-danger ml-2 btn-down" data-num="${post.po_num}" data-state="-1">비추천</button>
	</div>
	<div class="form-group">
		<label>내용</label>
		<div class="form-control" style="min-height: 400px">${post.po_content}</div>
	</div>
	<div class="form-group">
		<label>첨부파일</label>
		<c:forEach items="${list }" var="file">
			<a href="<c:url value="/download${file.fi_name}"/>" class="form-control" download="${file.fi_ori_name}">${file.fi_ori_name}</a>
		</c:forEach>
	</div>
	
	<hr>
	
	<div class="comment-container">
		<div class="comment-wrap">
		
		</div>
		<form class="comment-insert-form input-group">
			<textarea name="content" class="form-control"></textarea>
			<button type="submit" class="btn btn-outline-success">댓글 등록</button>
		</form>
	</div>
	
	<div class="mb-3 d-flex justify-content-between">
		<a href="<c:url value="/post/list?bo_num=${post.po_bo_num}"/>" class="btn btn-outline-success">목록으로</a>
		<c:if test="${post.po_me_id eq user.me_id }">
			<div>
				<a href="<c:url value="/post/update/${post.po_num}"/>" class="btn btn-outline-warning">수정</a>
				<a href="<c:url value="/post/delete/${post.po_num}"/>" class="btn btn-outline-danger">삭제</a>
			</div>
		</c:if>
	</div>
	
	<script type="text/javascript">
		$(".btn-up, .btn-down").click(function(e){
			if('${user.me_id}' == ''){
				alert("로그인이 필요한 서비스입니다.");
				return;
			}
			let num = $(this).data("num");
			let state = $(this).data("state");
			
			$.ajax({
				async : true, //비동기 : true(비동기), false(동기)
				url : '<c:url value="/post/like"/>', 
				type : 'post', 
				data : JSON.stringify({
					li_state : state,
					li_po_num : num
				}), 
				contentType : "application/json; charset=utf-8",
				success : function (data){
					switch(data){
					case 1:
						alert("추천!");
						break;
					case -1:
						alert("비추천!");
						break;
					case 0:
						alert((state == 1 ? "추천" : "비추천") + " 취소");
					}
					location.reload();
				}
			});
		})
	</script>
	
	<script type="text/javascript">
		var cri = {
			page : 1,
			po_num : ${post.po_num}
		}
		$(document).on("submit", ".comment-insert-form", function(e){
			e.preventDefault();
			
			if("${user.me_id}" == ""){ //${user.me_id} == "" 로 하면 로그인 상태가 아닐 경우 /  == "" 와 같아 오류가 남
				if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")){
					location.href = "<c:url value="/login"/>";
				}
				return;
			}
			
			var $content = $(this).find("[name=content]");
			var content = $content.val();
			var ori_num = $(this).data("num");
			ori_num = ori_num == "undefined"? 0 : ori_num;
			//댓글 내용을 입력 안한 경우
			if(content.length == 0){
				alert("댓글 내용을 입력하세요");
				$content.focus();
				return;
			}
			
			$.ajax({
				async : true,
				url : '<c:url value="/comment/insert"/>', 
				type : 'post', 
				data : JSON.stringify({
					co_po_num : cri.po_num,
					co_content: content,
					co_ori_num : ori_num
				}), 
				contentType : "application/json; charset=utf-8",
				success : function (data){
					if(data){
						alert('댓글 등록!');
						$content.val('');
						getCommentList(cri);
					}else{
						alert('댓글 등록 실패!');
					}
				}
			});
		})
	</script>
	
	<script type="text/javascript">
		getCommentList(cri);
		function getCommentList(cri) {
			$.ajax({
				async : true,
				url : '<c:url value="/comment/list"/>', 
				type : 'post', 
				data : JSON.stringify(cri), 
				contentType : "application/json; charset=utf-8",
				success : function (data){
					$(".comment-wrap").html(data);
				}
			});
		}
	</script>
	
	<script type="text/javascript">
		$(document).on("submit", ".comment-update-form", function(e){
			e.preventDefault();
			
			var $content = $(this).find("[name=content]");
			var content = $content.val();
			var co_num = $(this).data("num");
			
			if(content.trim().length == 0){
				alert("수정할 댓글 내용을 입력하세요.")
				$content.focus();
				return;
			}
			
			$.ajax({
				async : true,
				url : '<c:url value="/comment/update"/>', 
				type : 'post',
				data : JSON.stringify({
					co_num : co_num,
					co_content : content
				}),
				contentType : "application/json; charset=utf-8",
				success : function (data){
					if(data){
						alert('댓글을 수정하였습니다!');
						getCommentList(cri);
					}else{
						alert('댓글 수정에 실패하였습니다!');
					}
				}
			});
		});
	</script>
</body>
</html>