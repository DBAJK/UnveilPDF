<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-07-28
  Time: 오후 4:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="/resources/css/main.css" rel="stylesheet" type="text/css">
<style>
    .pdf-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 2rem;
    }

    .pdf-table th, .pdf-table td {
        border: 1px solid #ddd;
        padding: 1rem;
        text-align: center;
    }

    .pdf-table th {
        background-color: #f4f6fa;
        font-weight: bold;
        color: #333;
    }
</style>
<div class="form-container">

    <div class="headerArea">
        <span class="main-title">[${projectName}] 프로젝트 PDF 파일 목록</span>
        <div class="btnPanel">
            <button type="button" id="btnSave">신규등록</button>
            <button type="button" id="btnDel">목록</button><br>
        </div>
    </div>

    <table class="pdf-table">
        <thead>
        <tr>
            <th>파일 ID</th>
            <th>파일명</th>
            <th>파일 유형</th>
            <th>업로드 일시</th>
            <th>처리상태</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${not empty pdfList}">
            <c:forEach var="pdf" items="${pdfList}">
                <tr data-pdfid="${pdf.pdfId}" style="cursor:pointer;">
                    <td>${pdf.pdfId}</td>
                    <td>${pdf.fileName}</td>
                    <td><span class="file-type-badge">${pdf.fileType}</span></td>
                    <td>${pdf.uploadDt}</td>
                    <td>${pdf.status}</td>
                </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
</div>

<script type="text/javascript" >
    $(document).ready(function() {
        bindButtons();

        loadProjectDtl();

    });
    // 테이블 행 호버 효과 개선
    document.querySelectorAll('.pdf-table tbody tr').forEach(row => {
        row.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.02)';
            this.style.zIndex = '10';
        });

        row.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
            this.style.zIndex = '1';
        });
    });

    // 파일 ID 클릭 시 상세 정보 표시 (예시)
    document.querySelectorAll('.pdf-table tbody tr').forEach(row => {
        row.addEventListener('click', function() {
            const fileId = this.cells[0].textContent;
            console.log(`파일 ${'${fileId}'} 상세 정보 보기`);
            // 실제 구현에서는 상세 페이지로 이동하거나 모달을 표시
        });
    });

    function loadProjectDtl() {
        const projectId = getQueryParam("projectId");
        const projectName = getQueryParam("projectName");

        $.ajax({
            url: '/service/getPjDtlList',
            data: {
                projectId: projectId,
                projectName: projectName
            },
            success: function(html) {
                $('.form-container').html(html); // container 영역만 갱신
                bindButtons();
            }
        });
    }
    function getQueryParam(param) {
        const params = new URLSearchParams(window.location.search);
        return params.get(param);
    }
    function bindButtons() {
        $("#btnSave").click(function () {
            const projectId = getQueryParam("projectId");
            window.location.href = "/?formType=ocrForm&projectId=" + projectId ;

        });

        $("#btnDel").click(function () {
            if (confirm("메인 화면으로 돌아가겠습니까?")) {
                location.href = '/mainForm';
            }
        });
        $('tbody').on('click', 'tr', function() {
            var pdfId = $(this).data('pdfid');
            console.log('Clicked PDF ID:', pdfId);
            window.location.href = "/?formType=pdfResult&pdfId=" + encodeURIComponent(pdfId);
        });
    }

</script>