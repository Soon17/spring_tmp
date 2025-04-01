<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	
</head>
<body>
	<h1>메인페이지 입니다.</h1>
	
	<h3>res1</h3>
	<div id="res1"></div>
	<hr>
	<h3>res2</h3>
	<div id="res2"></div>
	<hr>
	<h3>res3</h3>
	<div id="res3"></div>
	<hr>
	<h3>res4</h3>
	<div id="res4"></div>
	<hr>
	<h3>res5</h3>
	<div id="res5"></div>
	<hr>
	<h3>res6</h3>
	<div id="res6"></div>
	<hr>
	<h3>res7</h3>
	<div id="res7"></div>
	<hr>
	<h3>res8</h3>
	<div id="res8"></div>

	<script type="text/javascript">
		let obj = {
			name : "홍길동",
			age : 20
		}
		//JSON.stringify(객체) : 객체를 json 형태의 문자열로 변환
		console.log(JSON.stringify(obj));
		let str = `{"name" : "홍길동", "age" : 20}`;
		//JSON.parse(문자열) : json형태의 문자열을 객체로 변환
		console.log(JSON.parse(str));
		<!-- object => object  -->
		$.ajax({
			async : true,
			url : '<c:url value="/ajax/sample1"/>', 
			type : 'get', 
			data : obj, 
			success : function (data){
				$("#res1").html(data);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
	
			}
		});
		<!-- json => object  -->
		$.ajax({
			async : true,
			url : '<c:url value="/ajax/sample2"/>', 
			type : 'post', 
			data : JSON.stringify(obj), 
			contentType : "application/json; charset=utf-8",
			success : function (data){
				$("#res2").html(data);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
	
			}
		});
		<!-- object => json -->
		$.ajax({
			async : true,
			url : '<c:url value="/ajax/sample3"/>', 
			type : 'get',
			data : obj,
			dataType : "json",
			success : function (data){
				console.log(data.person.name)
				//person : 컨트롤러에서 map에 추가할 때 붙인 이름
				//name : PersonDTO의 필드명
				$("#res3").html(data.person.name);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
	
			}
		});
		/* object => string */
		<!-- object => object  -->
		$.ajax({
			async : true,
			url : '<c:url value="/ajax/sample4"/>', 
			type : 'get', 
			data : {bo_num : 0}, 
			success : function (data){
				$("#res4").html(data);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
	
			}
		});
		//fetch를 이용.
		fetch("<c:url value="/ajax/sample1?name=홍길동&age=20"/>")
		.then(res => res.text())
		.then(data=>{
			$("#res5").html("fetch : " + data);
		});
		
		fetch("<c:url value="/ajax/sample2"/>", {
			method : "post",
			headers : { 'content-Type' : 'application/json'},
			body : JSON.stringify(obj)
		})
		.then(res => res.text())
		.then(data=>{
			$("#res6").html("fetch : " + data);
		});
		
		fetch("<c:url value="/ajax/sample3?name=홍길동&age=20"/>")
		.then(res => res.json())
		.then(data=>{
			$("#res7").html("fetch : " + data.person.name);
		});
		
		fetch("<c:url value="/ajax/sample4?bo_num=0"/>")
		.then(res => res.text())
		.then(data=>{
			$("#res8").html(data);
		});
	</script>
</body>
</html>
