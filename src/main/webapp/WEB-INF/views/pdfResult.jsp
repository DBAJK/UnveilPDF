<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-07-31
  Time: 오후 3:57
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
  .ocr-result-container {
    display: flex;
    flex-direction: column;
    gap: 10px;
    max-width: 1600px;
    margin: 10px auto;
  }

  .ocr-page {
    display: flex;
    flex-direction: row;     /* 가로 정렬 */
    gap: 30px;
    border-bottom: 1px solid #ccc;
    padding-bottom: 30px;
    overflow-x: auto;
    scroll-behavior: smooth; /* 부드러운 스크롤 */
    white-space: nowrap;     /* 줄바꿈 방지 */
  }
  .ocr-page > div {
    flex: 0 0 auto;
    width: 800px;
    box-sizing: border-box;
  }
  .ocr-image {
    width: 100%;
    height: auto;
    border: 1px solid #ccc;
  }

  .ocr-text {
    width: 700px;
    white-space: pre-wrap;
    word-wrap: break-word;
    background: #f7f7f7;
    padding: 20px;
    border-radius: 4px;
    overflow-wrap: break-word;
    max-height: 800px;
    overflow-y: auto;
  }
  .ocr-title {
    font-size: 20px;
    margin-bottom: 10px;
    color: #333;
    font-weight: bold;
  }
</style>
<div class="ocr-result-container">
  <h1 class="main-title">PDF 텍스트 파싱 결과 조회</h1>
  <div class="ocr-page">
    <c:forEach var="pdfData" items="${pdfData}" varStatus="status">
      <c:choose>
        <c:when test="${status.index == 0}">
          <c:set var="imgPath" value="/resources/image/main.png" />
        </c:when>
        <c:otherwise>
          <c:set var="imgPath" value="/resources/image/${status.index + 1}p.png" />
        </c:otherwise>
      </c:choose>

      <div class="ocr-image">
        <div class="ocr-title">페이지 ${pdfData.pageNo}</div>
        <img src="${imgPath}" alt="페이지 이미지 ${pdfData.pageNo}" style="width: 100%; max-height: 800px; height: auto;" />
      </div>
      <div class="ocr-text">
        <div class="ocr-title">OCR 결과</div>
          ${pdfData.ocrText}
      </div>
    </c:forEach>

  </div>
</div>
<script type="text/javascript" >
  $(document).ready(function() {
    loadPdfResult();
  });
  function loadPdfResult() {
    const pdfId = getQueryParam("pdfId");

    $.ajax({
      url: '/service/getPdfResult',
      data: { pdfId : pdfId },
      success: function(html) {
        $('.ocr-result-container').html(html); // container 영역만 갱신
      },
      error: function(xhr, status, error) {
        console.error('AJAX 오류:', status, error);
      }
    });
  }
  function getQueryParam(param) {
    const params = new URLSearchParams(window.location.search);
    return params.get(param);
  }

</script>
