<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	
</head>
<body>
	<h1 class="mt-3">회원가입</h1>
	<form action="<c:url value="/signup"/>" method="post">
		<div class="form-group">
		  <label for="usr">아이디:</label>
		  <input type="text" class="form-control" id="id" name="me_id">
		</div>
		<div class="form-group">
		  <label for="pw">비밀번호:</label>
		  <input type="password" class="form-control" id="pw" name="me_pw">
		</div>
		<div class="form-group">
		  <label for="pw2">비밀번호 확인:</label>
		  <input type="password" class="form-control" id="pw2" name="me_pw2">
		</div>
		<div class="form-group">
		  <label for="email">이메일:</label>
		  <input type="email" class="form-control" id="email" name="me_email">
		</div>
		<button type="submit" class="btn btn-outline-success col-12 mb-3">회원가입</button>
	</form>
</body>
</html>
