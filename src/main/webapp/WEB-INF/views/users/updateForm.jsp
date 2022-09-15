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
<script>
	$("#btnDelete").click(()=>{
		let id=$("#id").val();  
		
		$.ajax("/users/"+id,{
	        type: "delete",
	        dataType: "json"		 
	     }).done((res)=>{
	        if(res.code == 1){
	        	if (confirm("정말 탈퇴 하시겠습니까?") == true){
	        		alert("회원 탈퇴 완료");
		        	location.href = "/";
	        	}else{
	        		return;
	        	}
	        }else{
	        	alert("회원탈퇴 실패");
	        }
	     });
	});

	$("#btnUpdate").click(()=>{
		let data={
				password : $("#password").val(),
				email: $("#email").val()
		};
		let id=$("#id").val(); //body에 담을 데이터가 아니라 따로 받는다. 
		
		if($("#password").val() == ""){
	          alert("비밀번호 입력해주세요.");
	          $("#password").focus();
	          return false;
	        }
		if($("#email").val() == ""){
	          alert("이메일을 입력해주세요.");
	          $("#email").focus();
	          return false;
	        }
		
		$.ajax("/users/"+id,{
	        type: "put",
	        dataType: "json",
	        data: JSON.stringify(data),
	        headers : {
	              "Content-Type" : "application/json; charset=utf-8"
	        }
	     }).done((res)=>{
	        if(res.code == 1){
	        	alert("회원 수정 완료");
	           location.reload(); //F5
	        }else{
	        	alert("업데이트에 실패하였습니다.");
	        }
	     });
		
		
	});
</script>

<%@ include file="../layout/footer.jsp"%>
