<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carbon Footprint Calculator</title>
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
        <a href="${pageContext.request.contextPath}/home" class="active">Calculator</a>
        <a href="${pageContext.request.contextPath}/history">My History</a>
    </div>
</nav>

<!-- ===== HERO ===== -->
<div class="hero">
    <div class="hero-content">
        <h1>Know Your Carbon Footprint</h1>
        <p>
            <c:choose>
                <c:when test="${not empty userName}">
                    Welcome back, <strong>${userName}</strong>! Enter your details below.
                </c:when>
                <c:otherwise>
                    Enter your travel, energy and diet details to calculate your annual CO₂ emissions.
                </c:otherwise>
            </c:choose>
        </p>
    </div>
</div>

<!-- ===== FORM ===== -->
<div class="container">
    <form action="${pageContext.request.contextPath}/calculate" method="post" id="calcForm">

        <!-- Your Name -->
        <div class="card">
            <div class="card-header">
                <i class="fa-solid fa-user"></i>
                <h2>Your Name</h2>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="userName">Name (saved in cookie)</label>
                    <input type="text" id="userName" name="userName"
                           value="${not empty userName ? userName : ''}"
                           placeholder="e.g. Arjun" maxlength="50">
                </div>
            </div>
        </div>

        <!-- TRAVEL -->
        <div class="card">
            <div class="card-header">
                <i class="fa-solid fa-car"></i>
                <h2>Travel</h2>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="carKm">Car travel (km/week)</label>
                    <input type="number" id="carKm" name="carKm"
                           min="0" max="5000" value="150" step="10">
                </div>
                <div class="form-group">
                    <label for="carType">Car type</label>
                    <select id="carType" name="carType">
                        <option value="petrol">Petrol</option>
                        <option value="diesel">Diesel</option>
                        <option value="hybrid">Hybrid</option>
                        <option value="electric">Electric</option>
                        <option value="none">No car</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="flights">Flights per year</label>
                    <input type="number" id="flights" name="flights"
                           min="0" max="100" value="2">
                </div>
                <div class="form-group">
                    <label for="flightLength">Average flight length</label>
                    <select id="flightLength" name="flightLength">
                        <option value="short">Short (&lt;3 hours)</option>
                        <option value="medium" selected>Medium (3–6 hours)</option>
                        <option value="long">Long (&gt;6 hours)</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="publicTransportKm">Public transport (km/week)</label>
                    <input type="number" id="publicTransportKm" name="publicTransportKm"
                           min="0" max="2000" value="50" step="5">
                </div>
                <div class="form-group">
                    <!-- spacer -->
                </div>
            </div>
        </div>

        <!-- ENERGY -->
        <div class="card">
            <div class="card-header">
                <i class="fa-solid fa-bolt"></i>
                <h2>Home Energy</h2>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="electricity">Electricity (kWh/month)</label>
                    <input type="number" id="electricity" name="electricity"
                           min="0" max="5000" value="300" step="10">
                </div>
                <div class="form-group">
                    <label for="electricitySource">Electricity source</label>
                    <select id="electricitySource" name="electricitySource">
                        <option value="coal">Coal grid</option>
                        <option value="mixed" selected>Mixed grid</option>
                        <option value="renewables">Renewables</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="gas">Gas / fuel (m³/month)</label>
                    <input type="number" id="gas" name="gas"
                           min="0" max="2000" value="30" step="1">
                </div>
                <div class="form-group">
                    <label for="heatingType">Heating type</label>
                    <select id="heatingType" name="heatingType">
                        <option value="gas" selected>Natural gas</option>
                        <option value="oil">Heating oil</option>
                        <option value="heatpump">Heat pump</option>
                        <option value="wood">Wood / biomass</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- DIET -->
        <div class="card">
            <div class="card-header">
                <i class="fa-solid fa-utensils"></i>
                <h2>Diet</h2>
            </div>
            <p class="card-desc">Select the option that best matches your diet</p>

            <div class="diet-grid">
                <label class="diet-option">
                    <input type="radio" name="diet" value="meat-heavy">
                    <div class="diet-box">
                        <i class="fa-solid fa-drumstick-bite"></i>
                        <span>Heavy meat eater</span>
                        <small>3.3 t CO₂e/yr</small>
                    </div>
                </label>
                <label class="diet-option">
                    <input type="radio" name="diet" value="average" checked>
                    <div class="diet-box">
                        <i class="fa-solid fa-bowl-food"></i>
                        <span>Average diet</span>
                        <small>2.5 t CO₂e/yr</small>
                    </div>
                </label>
                <label class="diet-option">
                    <input type="radio" name="diet" value="less-meat">
                    <div class="diet-box">
                        <i class="fa-solid fa-plate-wheat"></i>
                        <span>Less meat</span>
                        <small>1.9 t CO₂e/yr</small>
                    </div>
                </label>
                <label class="diet-option">
                    <input type="radio" name="diet" value="pescatarian">
                    <div class="diet-box">
                        <i class="fa-solid fa-fish"></i>
                        <span>Pescatarian</span>
                        <small>1.5 t CO₂e/yr</small>
                    </div>
                </label>
                <label class="diet-option">
                    <input type="radio" name="diet" value="vegetarian">
                    <div class="diet-box">
                        <i class="fa-solid fa-carrot"></i>
                        <span>Vegetarian</span>
                        <small>1.3 t CO₂e/yr</small>
                    </div>
                </label>
                <label class="diet-option">
                    <input type="radio" name="diet" value="vegan">
                    <div class="diet-box">
                        <i class="fa-solid fa-seedling"></i>
                        <span>Vegan</span>
                        <small>1.0 t CO₂e/yr</small>
                    </div>
                </label>
            </div>
        </div>

        <!-- SUBMIT -->
        <button type="submit" class="btn-submit">
            <i class="fa-solid fa-calculator"></i>
            Calculate My Carbon Footprint
        </button>

    </form>
</div>

<footer class="footer">
    <p>Carbon Footprint Calculator &mdash; Mini Project &copy; 2024</p>
    <p class="footer-note">Emission factors based on IPCC &amp; UK DEFRA guidelines</p>
</footer>

<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
