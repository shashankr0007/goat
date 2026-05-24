<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Results – Carbon Footprint Calculator</title>
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
        <a href="${pageContext.request.contextPath}/history">My History</a>
    </div>
</nav>

<!-- ===== RESULT HERO ===== -->
<div class="hero hero-result hero-${result.rating == 'Low' ? 'low' : result.rating == 'Medium' ? 'medium' : 'high'}">
    <div class="hero-content">
        <p class="result-greeting">
            <c:if test="${not empty userName}">Results for <strong>${userName}</strong></c:if>
        </p>
        <div class="score-display">
            <span class="score-number">${result.formattedTotal}</span>
            <span class="score-unit">tonnes CO₂e / year</span>
        </div>
        <div class="rating-badge badge-${result.rating == 'Low' ? 'low' : result.rating == 'Medium' ? 'medium' : 'high'}">
            <c:choose>
                <c:when test="${result.rating == 'Low'}">
                    <i class="fa-solid fa-circle-check"></i> Below 1.5°C target — Great job!
                </c:when>
                <c:when test="${result.rating == 'Medium'}">
                    <i class="fa-solid fa-circle-exclamation"></i> Below global average — Room to improve
                </c:when>
                <c:otherwise>
                    <i class="fa-solid fa-triangle-exclamation"></i> Above global average — Action needed
                </c:otherwise>
            </c:choose>
        </div>
        <div class="benchmarks">
            <span><i class="fa-solid fa-earth-americas"></i> Global avg: <strong>4.7 t</strong></span>
            <span><i class="fa-solid fa-temperature-low"></i> 1.5°C target: <strong>2.3 t</strong></span>
        </div>
    </div>
</div>

<div class="container">

    <!-- ===== BREAKDOWN CARDS ===== -->
    <div class="section-title">
        <i class="fa-solid fa-chart-pie"></i>
        Emissions Breakdown
    </div>

    <div class="breakdown-grid">
        <div class="breakdown-card bk-travel">
            <div class="bk-icon"><i class="fa-solid fa-car-side"></i></div>
            <div class="bk-value">${result.formattedTravel}</div>
            <div class="bk-label">t CO₂e — Travel</div>
            <div class="bk-pct">${result.travelPercent}% of total</div>
        </div>
        <div class="breakdown-card bk-energy">
            <div class="bk-icon"><i class="fa-solid fa-plug-circle-bolt"></i></div>
            <div class="bk-value">${result.formattedEnergy}</div>
            <div class="bk-label">t CO₂e — Energy</div>
            <div class="bk-pct">${result.energyPercent}% of total</div>
        </div>
        <div class="breakdown-card bk-diet">
            <div class="bk-icon"><i class="fa-solid fa-utensils"></i></div>
            <div class="bk-value">${result.formattedDiet}</div>
            <div class="bk-label">t CO₂e — Diet</div>
            <div class="bk-pct">${result.dietPercent}% of total</div>
        </div>
    </div>

    <!-- ===== VISUAL BAR BREAKDOWN ===== -->
    <div class="card">
        <div class="card-header">
            <i class="fa-solid fa-bars-progress"></i>
            <h2>Visual Breakdown</h2>
        </div>

        <div class="bar-section">
            <div class="bar-meta">
                <span class="bar-name"><i class="fa-solid fa-car" style="color:#1D9E75"></i> Travel</span>
                <span class="bar-value">${result.formattedTravel} t (${result.travelPercent}%)</span>
            </div>
            <div class="bar-track">
                <div class="bar-fill bar-travel" style="width: ${result.travelPercent}%"></div>
            </div>
        </div>

        <div class="bar-section">
            <div class="bar-meta">
                <span class="bar-name"><i class="fa-solid fa-bolt" style="color:#BA7517"></i> Energy</span>
                <span class="bar-value">${result.formattedEnergy} t (${result.energyPercent}%)</span>
            </div>
            <div class="bar-track">
                <div class="bar-fill bar-energy" style="width: ${result.energyPercent}%"></div>
            </div>
        </div>

        <div class="bar-section">
            <div class="bar-meta">
                <span class="bar-name"><i class="fa-solid fa-utensils" style="color:#D85A30"></i> Diet</span>
                <span class="bar-value">${result.formattedDiet} t (${result.dietPercent}%)</span>
            </div>
            <div class="bar-track">
                <div class="bar-fill bar-diet" style="width: ${result.dietPercent}%"></div>
            </div>
        </div>
    </div>

    <!-- ===== YOUR INPUTS SUMMARY ===== -->
    <div class="card">
        <div class="card-header">
            <i class="fa-solid fa-list-check"></i>
            <h2>Your Inputs Summary</h2>
        </div>
        <table class="summary-table">
            <tr><th colspan="2">Travel</th></tr>
            <tr><td>Car travel</td><td>${result.carKmPerWeek} km/week (${result.carType})</td></tr>
            <tr><td>Flights</td><td>${result.flightsPerYear} per year (${result.flightLength} haul)</td></tr>
            <tr><td>Public transport</td><td>${result.publicTransportKmPerWeek} km/week</td></tr>
            <tr><th colspan="2">Energy</th></tr>
            <tr><td>Electricity</td><td>${result.electricityKwhPerMonth} kWh/month (${result.electricitySource})</td></tr>
            <tr><td>Gas / heating</td><td>${result.gasM3PerMonth} m³/month (${result.heatingType})</td></tr>
            <tr><th colspan="2">Diet</th></tr>
            <tr><td>Diet type</td><td>${result.diet}</td></tr>
        </table>
    </div>

    <!-- ===== TIPS ===== -->
    <div class="card tips-card">
        <div class="card-header">
            <i class="fa-solid fa-lightbulb"></i>
            <h2>Reduction Tips for You</h2>
        </div>
        <ul class="tips-list">
            <c:if test="${result.travelCO2 > 1.0}">
                <li><i class="fa-solid fa-circle-arrow-right"></i>
                    Switch to an EV or hybrid to cut car emissions by up to 50%.</li>
                <li><i class="fa-solid fa-circle-arrow-right"></i>
                    Consider carpooling or using public transport more often.</li>
            </c:if>
            <c:if test="${result.flightsPerYear > 2}">
                <li><i class="fa-solid fa-circle-arrow-right"></i>
                    One fewer long-haul flight saves up to 2 tonnes CO₂e per year.</li>
            </c:if>
            <c:if test="${result.energyCO2 > 1.5}">
                <li><i class="fa-solid fa-circle-arrow-right"></i>
                    Switch to a green energy tariff — renewables can reduce electricity emissions by 90%.</li>
                <li><i class="fa-solid fa-circle-arrow-right"></i>
                    Improve home insulation to reduce heating fuel consumption.</li>
            </c:if>
            <c:if test="${result.diet == 'meat-heavy' or result.diet == 'average'}">
                <li><i class="fa-solid fa-circle-arrow-right"></i>
                    Reducing red meat to 3 days/week can save around 0.5 t CO₂e annually.</li>
            </c:if>
            <c:if test="${result.totalCO2 < 2.3}">
                <li><i class="fa-solid fa-circle-check" style="color:#3B6D11"></i>
                    Excellent! You are already below the 1.5°C climate target. Keep it up!</li>
            </c:if>
        </ul>
    </div>

    <!-- ===== ACTIONS ===== -->
    <div class="action-row">
        <a href="${pageContext.request.contextPath}/home" class="btn-outline">
            <i class="fa-solid fa-rotate-left"></i> Recalculate
        </a>
        <a href="${pageContext.request.contextPath}/history" class="btn-submit">
            <i class="fa-solid fa-clock-rotate-left"></i> View History
        </a>
    </div>

</div>

<footer class="footer">
    <p>Carbon Footprint Calculator &mdash; Mini Project &copy; 2024</p>
</footer>

<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
