<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-07-15
  Time: 오후 2:58
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
    .container {
        width: 80%;
        margin: 0 auto;
        padding: 16px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .main-title {
        font-size: 2.5rem;
        font-weight: 700;
        color: #4a5cc6;
        margin-bottom: 3rem;
        text-align: center;
        width: 100%;
    }
    .project-grid {
        display: flex;
        flex-wrap: wrap;
        justify-content: flex-start; /* 왼쪽 정렬 */
        gap: 1rem 2rem; /* 세로/가로 간격 */
        width: 100%;
    }
    .project-card {
        width: 150px; /* 원하는 카드 너비 */
        background: white;
        border-radius: 16px;
        padding: 3rem 2rem;
        text-align: center;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        transition: all 0.3s ease;
        cursor: pointer;
        border: 2px solid transparent;
        flex: none; /* flex-grow 막기 */
    }

    .project-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        border-color: #667eea;
    }

    .project-card.add-card {
        border: 2px dashed #cbd5e0;
        background: #f8fafc;
        color: #718096;
    }

    .project-card.add-card:hover {
        border-color: #667eea;
        background: #edf2f7;
    }

    .project-title {
        font-size: 1.5rem;
        font-weight: 600;
        color: #2d3748;
        margin-bottom: 1rem;
    }

    .add-icon {
        font-size: 3rem;
        color: #a0aec0;
        font-weight: 300;
    }
    @keyframes pulse {
        0%, 100% { opacity: 0.3; }
        50% { opacity: 1; }
    }

    @media (max-width: 768px) {
        .container {
            padding: 1rem;
        }

        .main-title {
            font-size: 2rem;
        }

        .project-grid {
            grid-template-columns: 1fr;
            gap: 1rem;
        }

        .project-card {
            width: 100%;
        }
    }
</style>
<div class="container">
    <h1 class="main-title">프로젝트 조회</h1>

    <div class="project-grid">
        <c:forEach var="project" items="${projectList}">
            <div class="project-card" onclick="openProject(${project.projectId}, '${project.projectName}')">
                <div class="project-title">${project.projectName}</div>
            </div>
        </c:forEach>

        <div class="project-card add-card" onclick="addProject()">
            <div class="add-icon">+</div>
        </div>
    </div>
</div>

<script type="text/javascript" >
    $(document).ready(function() {
        loadProject();
    });

    function openProject(projectId, projectName) {
        const encodedName = encodeURIComponent(projectName);
        window.location.href = "/?formType=pjDetail&projectId=" + projectId + "&projectName=" + projectName;
    }

    function addProject() {
        window.location.href = '/pjRegist';
    }

    // 카드 호버 효과 개선
    document.querySelectorAll('.project-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px) scale(1.02)';
        });

        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });

    function loadProject() {
        $.ajax({
            url: '/service/getProjectList',
            success: function(html) {
                $('.container').html(html); // container 영역만 갱신
            }
        });
    }

</script>