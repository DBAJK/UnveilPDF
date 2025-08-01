<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-07-21
  Time: 오후 2:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="/resources/css/main.css" rel="stylesheet" type="text/css">
<body>
    <div class="contentArea">
        <div class="headerArea">
            <span>프로젝트 생성</span>
            <div class="btnPanel">
                <button type="button" id="btnSave">생성</button>
                <button type="button" id="btnDel">취소</button><br>
            </div>
        </div>
        <form id="joinForm" class="joinForm" name="joinForm" method="post">
            <p>프로젝트 명</p> <input type="text" id="projectName" class="input" placeholder="프로젝트명을 입력하세요.">
            <p>프로젝트 포함 인원</p> <input type="text" id="projectUsers" class="user-input" placeholder="투입 할 인원을 선택해주세요." onclick="openUserPopup()" readonly >
            <input type="text" id="projectUserId" class="user-input" hidden >
            <p>공개 여부</p>
            <div class="radio-group">
                <label class="radio-label">
                    <input class="radio" type="radio" name="visibility" value="public" checked> 공개
                </label>
                <label class="radio-label">
                    <input class="radio" type="radio" name="visibility" value="private"> 미공개
                </label>
            </div>
        </form>
    </div>
</body>
<script type="text/javascript" >
    function openUserPopup() {
        const popup = window.open('/popup/userPopup', 'userPopup', 'width=500,height=600');
    }
    function setProjectUsers(names, ids) {
        document.getElementById('projectUsers').value = names;
        document.getElementById('projectUserId').value = ids;
    }

    // 팝업에서 선택된 사용자 정보를 받는 함수 (팝업에서 호출될 예정)
    function setSelectedUser(userName) {
        document.getElementById('projectUsers').value = userName;
    }
    // 추가 버튼 클릭 시
    $("#btnSave").click(function(){
        if (confirm("프로젝트 생성 하시겠습니까?")) {
            const userIds = $("#projectUserId").val();
            const projectName = $("#projectName").val();
            const visibility = $("input[name='visibility']:checked").val();

            $.ajax({
                url: '/savePjForm',
                data: {
                    projectName: projectName,
                    userVisibility: userIds,
                    isPublic: visibility
                },
                type: 'POST',
                success: function(data) {
                    location.href = "/mainForm";
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
        if (confirm("메인 화면으로 돌아가겠습니까?")) {
            location.href = '/mainForm';
        }
    });

</script>