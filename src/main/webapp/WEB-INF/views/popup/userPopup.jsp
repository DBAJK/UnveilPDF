<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-07-21
  Time: 오후 2:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<style>
    .contentArea .headerArea {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 0 20px 0;
    }
    .contentArea .headerArea span {
        font-size: 50px;
        color: #4a5cc6;
        font-weight: bold;
        margin-right: 20px;
        letter-spacing: 1px;
    }
    #btnSave {
        background: #4a5cc6;
        color: #fff;
        border: none;
        padding: 12px 0;
        border-radius: 7px;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.2s;
        width: 80px;
    }

    #btnSave:hover {
        background: #3443a6;
    }

    #btnDel {
        background: #f8cfc2;
        color: #fff;
        border: none;
        padding: 12px 0;
        border-radius: 7px;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.2s;
        width: 50px;
    }

    #btnDel:hover {
        background: #e0b2a4;
    }

</style>
<body>
<div class="contentArea">
    <div class="headerArea">
        <span>유저 조회</span>
        <div class="btnPanel">
            <button type="button" id="btnSave">추가</button>
            <button type="button" id="btnDel">취소</button><br>
        </div>
    </div>
    <div style="overflow-x:auto;">
        <table id="userTable" style="min-width:370px;width:100%;border-collapse:collapse;text-align:center;">
            <thead>
            <tr style="background-color:#125676; color:#fff;">
                <th style="padding:8px;">선택</th>
                <th style="padding:8px;">이름</th>
                <th style="padding:8px;">아이디</th>
            </tr>
            </thead>
            <tbody id="userTableBody">
            <c:forEach var="user" items="${userList}">
                <tr>
                    <td>
                        <input type="checkbox"
                               class="user-checkbox"
                               data-seq="${user.userSeq}"
                               data-name="${user.userName}"
                               data-id="${user.userId}">
                    </td>
                    <td>${user.userName}</td>
                    <td>${user.userId}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
<script type="text/javascript" >
    $(document).ready(function() {
        // 추가 버튼 클릭 시
        $("#btnSave").click(function(){
            const checked = Array.from(document.querySelectorAll('.user-checkbox:checked'));
            if (checked.length === 0) {
                alert('사용자를 선택하세요.');
                return;
            }

            // 이름과 아이디 목록 생성
            const names = checked.map(cb => cb.getAttribute('data-name'));
            const ids   = checked.map(cb => cb.getAttribute('data-id'));

            // 부모창의 input에 값 세팅 (팝업에서 실행됨)
            if (window.opener && !window.opener.closed) {
                window.opener.setProjectUsers(names.join(', '), ids.join(','));
                window.close();
            } else {
                alert('부모 창이 닫혀 있습니다.');
            }

        });
        // 취소 버튼
        $("#btnDel").click(function() {
            window.close();
        });
    });

</script>