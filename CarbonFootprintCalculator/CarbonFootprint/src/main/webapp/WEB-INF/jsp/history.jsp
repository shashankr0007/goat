<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculation History – Carbon Footprint Calculator</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<!-- ===== NAVBAR ===== -->
<nav class="navbar">
    <div class="nav-brand">
        <i class="fa-solid fa-leaf"></i>
        <span>CarbonCalc</span>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Calculator</a>
        <a href="${pageContext.request.contextPath}/history" class="active">My History</a>
    </div>
</nav>

<!-- ===== HERO ===== -->
<div class="hero">
    <div class="hero-content">
        <h1><i class="fa-solid fa-clock-rotate-left"></i> Calculation History</h1>
        <p>Session-tracked calculations for
            <c:choose>
                <c:when test="${not empty userName}"><strong>${userName}</strong></c:when>
                <c:otherwise>this session</c:otherwise>
            </c:choose>
        </p>
    </div>
</div>

<div class="container">

    <c:choose>
        <c:when test="${empty history}">
            <!-- No history yet -->
            <div class="card empty-state">
                <i class="fa-solid fa-chart-line fa-3x"></i>
                <h2>No calculations yet</h2>
                <p>Run your first calculation to see your history here.<br>
                   History is stored in your server session and resets when the session expires.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn-submit" style="display:inline-flex;margin-top:1rem">
                    <i class="fa-solid fa-calculator"></i> Go to Calculator
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <!-- History table -->
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-table-list"></i>
                    <h2>Past Calculations (${history.size()} saved)</h2>
                </div>

                <div class="history-info">
                    <i class="fa-solid fa-circle-info"></i>
                    History is saved in your HTTP session (cookie: CARBONSESSIONID).
                    It resets when the session expires or you clear it below.
                </div>

                <div class="history-list">
                    <c:forEach var="item" items="${history}" varStatus="s">
                        <div class="history-item">
                            <div class="hi-rank">#${s.index + 1}</div>
                            <div class="hi-body">
                                <div class="hi-top">
                                    <span class="hi-total">${item.formattedTotal} t CO₂e/yr</span>
                                    <span class="hi-badge badge-${item.rating == 'Low' ? 'low' : item.rating == 'Medium' ? 'medium' : 'high'}">
                                        ${item.rating}
                                    </span>
                                    <span class="hi-date">${item.calculatedAt}</span>
                                </div>
                                <div class="hi-breakdown">
                                    <span><i class="fa-solid fa-car" style="color:#1D9E75"></i> Travel: ${item.formattedTravel} t</span>
                                    <span><i class="fa-solid fa-bolt" style="color:#BA7517"></i> Energy: ${item.formattedEnergy} t</span>
                                    <span><i class="fa-solid fa-utensils" style="color:#D85A30"></i> Diet: ${item.formattedDiet} t</span>
                                </div>
                                <!-- Mini bar -->
                                <div class="hi-bar-track">
                                    <div class="bar-fill bar-travel" style="width:${item.travelPercent}%"></div>
                                    <div class="bar-fill bar-energy" style="width:${item.energyPercent}%"></div>
                                    <div class="bar-fill bar-diet"   style="width:${item.dietPercent}%"></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Clear session -->
            <form action="${pageContext.request.contextPath}/clearHistory" method="post" style="margin-top:1rem">
                <button type="submit" class="btn-danger"
                        onclick="return confirm('Clear all history? This will invalidate your session.')">
                    <i class="fa-solid fa-trash"></i> Clear All History
                </button>
            </form>
        </c:otherwise>
    </c:choose>

    <div class="action-row" style="margin-top:1.5rem">
        <a href="${pageContext.request.contextPath}/home" class="btn-outline">
            <i class="fa-solid fa-arrow-left"></i> Back to Calculator
        </a>
    </div>

</div>

<footer class="footer">
    <p>Carbon Footprint Calculator &mdash; Mini Project &copy; 2024</p>
</footer>

<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
