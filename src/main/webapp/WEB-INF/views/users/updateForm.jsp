<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<div class="container">
<br/>
	<button id="btnDelete" class="btn btn-danger">회원탈퇴</button>
	<form>
		<input id="id" type="hidden" value="${users.id}" />
		<div class="mb-3 mt-3">
			<input type="text" class="form-control" placeholder="Enter username" 
			name="username" value="${users.username }">
		</div>
		<div class="mb-3">
			<input id="password" type="password" class="form-control"
				placeholder="Enter password" name="password"value="${users.password }">
		</div>
		<div class="mb-3">
			<input id="email" type="email" class="form-control" placeholder="Enter email" 
			name="email"value="${users.email }">
		</div>
		<button id="btnUpdate" type="button" class="btn btn-primary">회원수정완료</button>
	</form>
</div>
<script src="/js/users.js"></script>

<%@ include file="../layout/footer.jsp"%>
