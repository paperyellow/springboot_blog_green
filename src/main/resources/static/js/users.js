let isUsernameSameCheck = false;


$("#btnJoin").click(() => {
	join();
});

$("#btnUsernameSameCheck").click(() => {
	checkUsername();
});

$("#btnLogin").click(() => {
	login();
});

$("#btnDelete").click(() => {
	resign();
});

$("#btnUpdate").click(() => {
	update();
});

function join() {

	if (isUsernameSameCheck == false) {
		alert("유저네임 중복 체크를 진행해주세요");
		return;
	}

	// 0. 통신 오브젝트 생성
	let data = {
		username: $("#username").val(),
		password: $("#password").val(),
		email: $("#email").val()
	};

	if ($("#username").val() == "") {
		alert("아이디 입력해주세요.");
		$("#username").focus();
		return false;
	}
	if ($("#password").val() == "") {
		alert("비밀번호 입력해주세요.");
		$("#password").focus();
		return false;
	}
	if ($("#email").val() == "") {
		alert("이메일을 입력해주세요.");
		$("#email").focus();
		return false;
	}

	$.ajax("/join", {
		type: "POST",
		dataType: "json",
		data: JSON.stringify(data),
		headers: {
			"Content-Type": "application/json"
		}
	}).done((res) => {
		if (res.code == 1) {
			//console.log(res);
			location.href = "/loginForm";
		}
	});
}

function checkUsername() {

	// 0. 통신 오브젝트 생성 (Get 요청은 body가 없다.)

	// 1. 사용자가 적은 username 값을 가져오기
	let username = $("#username").val();

	// 2. Ajax 통신
	$.ajax(`/users/usernameSameCheck?username=${username}`, {
		type: "GET",
		dataType: "json",
		async: true
	}).done((res) => {
		if (res.code == 1) { // 통신 성공
			if (res.data == false) {
				alert("아이디가 중복되지 않았습니다.");
				isUsernameSameCheck = true;
			} else {
				alert("아이디가 중복되었어요. 다른 아이디를 사용해주세요.");
				isUsernameSameCheck = false;
				$("#username").val("");
			}
		}
	});
}

function login() {
	let data = {
		username: $("#username").val(),
		password: $("#password").val()
	};

	$.ajax("/login", {
		type: "POST",
		dataType: "json",
		data: JSON.stringify(data),
		headers: {
			"Content-Type": "application/json; charset=utf-8"
		}
	}).done((res) => {
		if (res.code == 1) {
			location.href = "/";
		} else {
			alert("로그인 실패, 아이디/패스워드를 확인해주세요.");
		}
	});
}

function resign() {

	let id = $("#id").val();

	$.ajax("/users/" + id, {
		type: "delete",
		dataType: "json"
	}).done((res) => {
		if (res.code == 1) {
			if (confirm("정말 탈퇴 하시겠습니까?") == true) {
				alert("회원 탈퇴 완료");
				location.href = "/";
			} else {
				return;
			}
		} else {
			alert("회원탈퇴 실패");
		}
	});
}

function update() {

	let data = {
		password: $("#password").val(),
		email: $("#email").val()
	};
	let id = $("#id").val(); //body에 담을 데이터가 아니라 따로 받는다. 

	if ($("#password").val() == "") {
		alert("비밀번호 입력해주세요.");
		$("#password").focus();
		return false;
	}
	if ($("#email").val() == "") {
		alert("이메일을 입력해주세요.");
		$("#email").focus();
		return false;
	}

	$.ajax("/users/" + id, {
		type: "put",
		dataType: "json",
		data: JSON.stringify(data),
		headers: {
			"Content-Type": "application/json; charset=utf-8"
		}
	}).done((res) => {
		if (res.code == 1) {
			alert("회원 수정 완료");
			location.reload(); //F5
		} else {
			alert("업데이트에 실패하였습니다.");
		}
	});
}