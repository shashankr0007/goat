<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>CarbonCalc</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<!-- ── NAVIGATION ───────────────────────────────────────── -->
<nav>
  <a class="logo" href="${pageContext.request.contextPath}/">
    <span class="leaf">🌿</span> CarbonCalc
  </a>
  <div class="nav-btns">
    <a class="nav-btn active" href="${pageContext.request.contextPath}/">Calculator</a>
    <a class="nav-btn"        href="${pageContext.request.contextPath}/history">My history</a>
  </div>
</nav>

<!-- ── MAIN FORM ─────────────────────────────────────────── -->
<div class="main">
  <form action="${pageContext.request.contextPath}/calculate" method="post">

    <!-- Name -->
    <div class="card">
      <div class="card-title"><span class="icon">👤</span> Your name</div>
      <div class="form-group">
        <label for="name">Name</label>
        <input type="text" id="name" name="name" placeholder="e.g. Arjun"/>
      </div>
    </div>

    <!-- Travel -->
    <div class="card">
      <div class="card-title"><span class="icon">🚗</span> Travel</div>
      <div class="form-grid">
        <div class="form-group">
          <label for="carKm">Car travel (km/week)</label>
          <input type="number" id="carKm" name="carKm" value="150" min="0"/>
        </div>
        <div class="form-group">
          <label for="carType">Car type</label>
          <select id="carType" name="carType">
            <option value="petrol">Petrol</option>
            <option value="diesel">Diesel</option>
            <option value="hybrid">Hybrid</option>
            <option value="electric">Electric</option>
          </select>
        </div>
        <div class="form-group">
          <label for="flights">Flights per year</label>
          <input type="number" id="flights" name="flights" value="2" min="0"/>
        </div>
        <div class="form-group">
          <label for="flightLen">Average flight length</label>
          <select id="flightLen" name="flightLen">
            <option value="short">Short (&lt;3 hrs)</option>
            <option value="medium" selected>Medium (3–6 hrs)</option>
            <option value="long">Long (&gt;6 hrs)</option>
          </select>
        </div>
        <div class="form-group">
          <label for="pubKm">Public transport (km/week)</label>
          <input type="number" id="pubKm" name="pubKm" value="50" min="0"/>
        </div>
      </div>
    </div>

    <!-- Home Energy -->
    <div class="card">
      <div class="card-title"><span class="icon">⚡</span> Home energy</div>
      <div class="form-grid">
        <div class="form-group">
          <label for="electricity">Electricity (kWh/month)</label>
          <input type="number" id="electricity" name="electricity" value="300" min="0"/>
        </div>
        <div class="form-group">
          <label for="elecSource">Electricity source</label>
          <select id="elecSource" name="elecSource">
            <option value="mixed">Mixed grid</option>
            <option value="renewable">Renewable</option>
            <option value="coal">Coal heavy</option>
          </select>
        </div>
        <div class="form-group">
          <label for="gas">Gas / fuel (m³/month)</label>
          <input type="number" id="gas" name="gas" value="30" min="0"/>
        </div>
        <div class="form-group">
          <label for="heatingType">Heating type</label>
          <select id="heatingType" name="heatingType">
            <option value="natural_gas" selected>Natural gas</option>
            <option value="oil">Oil</option>
            <option value="electric">Electric</option>
            <option value="heat_pump">Heat pump</option>
          </select>
        </div>
      </div>
    </div>

    <!-- Diet -->
    <div class="card">
      <div class="card-title"><span class="icon">🍽️</span> Diet</div>
      <div class="diet-grid">
        <label class="diet-option">
          <input type="radio" name="dietVal" value="3.3"/>
          <div class="diet-icon">🍖</div>
          <div class="diet-name">Heavy meat</div>
          <div class="diet-val">3.3 t/yr</div>
        </label>
        <label class="diet-option selected">
          <input type="radio" name="dietVal" value="2.5" checked/>
          <div class="diet-icon">🥘</div>
          <div class="diet-name">Average</div>
          <div class="diet-val">2.5 t/yr</div>
        </label>
        <label class="diet-option">
          <input type="radio" name="dietVal" value="1.9"/>
          <div class="diet-icon">🥗</div>
          <div class="diet-name">Less meat</div>
          <div class="diet-val">1.9 t/yr</div>
        </label>
        <label class="diet-option">
          <input type="radio" name="dietVal" value="1.5"/>
          <div class="diet-icon">🐟</div>
          <div class="diet-name">Pescatarian</div>
          <div class="diet-val">1.5 t/yr</div>
        </label>
        <label class="diet-option">
          <input type="radio" name="dietVal" value="1.3"/>
          <div class="diet-icon">🥦</div>
          <div class="diet-name">Vegetarian</div>
          <div class="diet-val">1.3 t/yr</div>
        </label>
        <label class="diet-option">
          <input type="radio" name="dietVal" value="1.0"/>
          <div class="diet-icon">🌱</div>
          <div class="diet-name">Vegan</div>
          <div class="diet-val">1.0 t/yr</div>
        </label>
      </div>
    </div>

    <!-- Submit -->
    <button type="submit" class="calc-btn">
      🧮 Calculate my carbon footprint
    </button>

  </form>
</div>

<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
