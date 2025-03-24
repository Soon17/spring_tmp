<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	
</head>
<body>
	<h1 class="mt-3">로그인</h1>
	<form action="<c:url value="/login"/>" method="post">
		<div class="form-group">
		  <label for="usr">아이디:</label>
		  <input type="text" class="form-control" id="id" name="me_id" value="${id}">
		</div>
		<div class="form-group">
		  <label for="pw">비밀번호:</label>
		  <input type="password" class="form-control" id="pw" name="me_pw">
		</div>
		<button type="submit" class="btn btn-outline-success col-12 mb-3">로그인</button> 
	</form>
</body>
</html>
