<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<div class="container">
	<br/>
	<form>
		<div class="mb-3 mt-3">
			<input id="title" type="text" class="form-control" placeholder="Enter title" value="${boards.title}" required="required" maxlength="50">
		</div>
		<div class="mb-3">
			<textarea id="content" class="form-control" rows="8" name="content" required="required">${boards.content}</textarea>
		</div>
		<button id="btnUpdate" type="button" class="btn btn-primary">수정완료</button>
	</form>
</div>
<script>
	$("#btnUpdate").click(()=>{
		update();
		//saveTest();
	});
	
	function updateTest(){
		let data = {
				
				title: $("#title").val(),
				content: $("#content").val()
			};
		console.log(data.content);
	}
	
	function update(){
		let data = {
				title: $("#title").val(),
				content: $("#content").val()
			};

			$.ajax("/boards/${boards.id}/update", {
				type: "POST",
				dataType: "json",
				data: JSON.stringify(data),
				headers: {
					"Content-Type": "application/json"
				}
			}).done((res) => {
				if (res.code == 1) {
					location.href = "/";
				}
			});
	}
</script>

<script>
$('#content').summernote({
    height: 400
  });
  </script>

<%@ include file="../layout/footer.jsp"%>

