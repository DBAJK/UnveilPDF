<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="/resources/css/main.css" rel="stylesheet" type="text/css">
<html>
<head>
    <title>UnveilPDF</title>
</head>
<body>
<%@ include file="layout/header.jsp" %>
<div id="container" class="container">
    <div id="content" class="content">
        <c:choose>
            <c:when test="${formType eq 'login'}">
                <%@ include file="loginForm.jsp" %>
            </c:when>
            <c:when test="${formType eq 'join'}">
                <%@ include file="joinForm.jsp" %>
            </c:when>
            <c:otherwise>
                <%@ include file="mainForm.jsp" %>
            </c:otherwise>

        </c:choose>
    </div>
</div>
</body>
</html>