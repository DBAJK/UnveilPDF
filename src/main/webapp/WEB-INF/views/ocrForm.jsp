<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-07-28
  Time: 오후 4:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="/resources/css/ocrForm.css" rel="stylesheet" type="text/css">
<div class="container">
    <div class="ocr-content">
        <h1 class="title">PDF 판독</h1>

        <div class="ocr-section">
            <h2 class="ocr-title">OCR로 텍스트 인식</h2>
            <p class="dropzone" id="dropzone">
                PDF 파일을 끌어서 놓으면 OCR 기술을 사용하여 파일 안의 텍스트를 인식하고 검색 가능한 PDF를 만들 수 있습니다.
            </p>
            <input type="file" id="fileInput" accept=".pdf" style="display: none;">
        </div>
    </div>
</div>

<script>
    const dropzone = document.getElementById('dropzone');
    const fileInput = document.getElementById('fileInput');

    dropzone.addEventListener('click', () => {
        fileInput.click();
    });

    dropzone.addEventListener('dragover', (e) => {
        e.preventDefault();
        dropzone.classList.add('dragover');
    });

    dropzone.addEventListener('dragleave', () => {
        dropzone.classList.remove('dragover');
    });

    dropzone.addEventListener('drop', (e) => {
        e.preventDefault();
        dropzone.classList.remove('dragover');

        const files = e.dataTransfer.files;

        if (files.length > 1) {
            alert("한 개의 파일만 업로드할 수 있습니다.");
            return;
        }

        if (files.length > 0) {
            handleFile(files[0]);
        }
    });

    fileInput.addEventListener('change', (e) => {
        const files = e.target.files;

        if (files.length > 1) {
            alert("한 개의 파일만 선택할 수 있습니다.");
            fileInput.value = ""; // 선택 초기화
            return;
        }

        if (files.length > 0) {
            handleFile(files[0]);
        }
    });

    function handleFile(file) {
        const projectId = getQueryParam("projectId");

        if (file.type === 'application/pdf') {
            const formData = new FormData();
            formData.append("file", file);  // 여기서 인자로 받은 file 사용
            formData.append("projectId", projectId);
            formData.append("fileType", "pdf");
            formData.append("status", "완료");

            $.ajax({
                url: "/ocr/upload",
                type: "POST",
                data: formData,
                contentType: false,
                processData: false,
                success: function (res) {
                    if (res.status === 'success') {
                        // ocr 처리 완료
                        alert("OCR 처리 성공!");
                        console.log(res);
                        window.location.href = "/?formType=pdfResult&pdfId=" + encodeURIComponent(res.pdfId);
                    } else {
                        alert("OCR 처리 실패: " + res.message);
                    }
                },
                error: function (err) {
                    alert("서버 오류 발생");
                    console.error(err);
                }
            });
        } else {
            alert('PDF 파일만 업로드 가능합니다.');
        }
    }
    function getQueryParam(param) {
        const params = new URLSearchParams(window.location.search);
        return params.get(param);
    }
</script>
