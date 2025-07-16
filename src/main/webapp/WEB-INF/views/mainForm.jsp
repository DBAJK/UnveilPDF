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
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem;
    }

    .main-title {
        font-size: 2.5rem;
        font-weight: 700;
        color: #4a5cc6;
        margin-bottom: 3rem;
        text-align: center;
    }

    .project-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 2rem;
        margin-bottom: 3rem;
    }

    .project-card {
        background: white;
        border-radius: 16px;
        padding: 3rem 2rem;
        text-align: center;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        transition: all 0.3s ease;
        cursor: pointer;
        border: 2px solid transparent;
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
            padding: 2rem 1rem;
        }
    }
</style>
<div class="container">
    <h1 class="main-title">프로젝트 조회</h1>

    <div class="project-grid">
        <div class="project-card" onclick="openProject('약위동향관리시스템')">
            <div class="project-title">약위동향관리시스템</div>
        </div>

        <div class="project-card" onclick="openProject('처분부당금시스템')">
            <div class="project-title">처분부당금시스템</div>
        </div>

        <div class="project-card add-card" onclick="addProject()">
            <div class="add-icon">+</div>
        </div>
    </div>

</div>

<script type="text/javascript" >
    function openProject(projectName) {
        alert(`${projectName} 프로젝트를 열었습니다.`);
    }

    function addProject() {
        const projectName = prompt('새 프로젝트 이름을 입력하세요:');
        if (projectName && projectName.trim()) {
            alert(`${projectName} 프로젝트가 추가되었습니다.`);
            // 여기서 실제로는 새 프로젝트 카드를 추가하는 로직을 구현할 수 있습니다.
        }
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
</script>