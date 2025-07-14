<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="/resources/css/main.css" rel="stylesheet" type="text/css">
<body>
    <div class="contentArea">
        <div class="headerArea">
            <span>Sign UP</span>
            <div class="btnPanel">
                <button type="button" id="btnSave">가입</button>
                <button type="button" id="btnDel">취소</button><br>
            </div>
        </div>
        <form id="joinForm" class="joinForm" name="joinForm" method="post">
            <p>아이디</p>
            <div class="input-with-btn">
                <input type="text" name="userId" id="userId" placeholder="아이디 입력 (6~20자)">
                <button type="button" class="input-btn" onclick="doubleChk();">중복확인</button>
            </div>
            <input type="hidden" name="idUnCheck" id="idUnCheck"/>  <!--  id 중복체크 여부 확인 -->
            <p>비밀번호</p> <input type="password" name="userPwd" id="userPwd" placeholder="비밀번호 입력(문자, 숫자, 특수문자 포함 8~20자)"><br>
            <p>비밀번호 확인</p> <input type="password" name="userPwdChk" id="userPwdChk" placeholder="비밀번호 재입력"><br>
            <p>이름</p> <input type="text" name="userName" id="userName" placeholder="이름을 입력해주세요."><br>
        </form>

    </div>
</body>

<script type="text/javascript">
    var idck = 0;

    $(document).ready(function() {

        // 전화번호 자동 포맷팅
        $("#userPhoneNumber").on("input", function () {
            var num = $(this).val().replace(/[^0-9]/g, '').substring(0, 11);
            var formatted = '';
            if (num.length <= 3) {
                formatted = num;
            } else if (num.length <= 7) {
                formatted = num.substring(0, 3) + '-' + num.substring(3);
            } else {
                formatted = num.substring(0, 3) + '-' + num.substring(3, 7) + '-' + num.substring(7);
            }
            $(this).val(formatted);
        });

        // 저장 버튼 클릭 시
        $("#btnSave").click(function(){
            if (!checkExistData(joinForm.userId, "아이디")) return false;
            if (idck !== 1) {
                alert("아이디 중복 확인을 완료해 주세요.");
                return false;
            }
            if (!checkExistData(joinForm.userPwd, "비밀번호")) return false;
            if (!checkExistData(joinForm.userPwdChk, "비밀번호 확인")) return false;
            if (joinForm.userPwd.value !== joinForm.userPwdChk.value) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                $("#userPwdChk").focus();
                return false;
            }
            if (!checkExistData(joinForm.userName, "이름")) return false;
            if (confirm("회원가입 하시겠습니까?")) {
                var params = $("#joinForm").serialize();
                console.log(params);
                $.ajax({
                    url: '/saveJoinForm',
                    data: params,
                    type: 'POST',
                    success: function(data) {
                        alert("회원가입에 성공하였습니다.");
                        location.href = "/loginForm";
                    },
                    error: function(request, status, error) {
                        console.log("code: " + request.status);
                        console.log("message: " + request.responseText);
                        console.log("error: " + error);
                        alert("서버 오류 발생");
                    }
                });
            } else {
                alert("다시 확인해주세요.");
            }
        });

        // 취소 버튼
        $("#btnDel").click(function() {
            if (confirm("로그인 화면으로 돌아가겠습니까?")) {
                location.href = '/loginForm';
            }
        });
    });

    // 공백 확인 함수
    function checkExistData(inputElement, dataName) {
        if (inputElement.value  === "") {
            alert(dataName + "을(를) 입력해주세요!");
            inputElement.focus();
            return false;
        }
        return true;
    }
    // 아이디 중복 확인
    function doubleChk() {
        var userId = joinForm.userId.value.trim();
        if (userId === "") {
            alert("아이디를 먼저 입력해주세요.");
            return;
        }

        $.ajax({
            url: "/idCheck",
            type: "post",
            data: {"userId": userId},
            dataType: 'text',
            success: function(cnt) {
                console.log(cnt);
                if (cnt === "0") {
                    alert("사용 가능한 아이디입니다.");
                    idck = 1;
                } else {
                    alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
                    idck = 2;
                    $("#userId").val('').focus();
                }
            },
            error: function(request, status, error) {
                console.log("code: " + request.status);
                console.log("message: " + request.responseText);
                console.log("error: " + error);
                alert("서버 오류 발생");
            }
        });
    }
</script>
