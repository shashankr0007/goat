# Carbon Footprint Calculator — Java Servlet + JSP Mini Project

## Project Overview
A web application for sustainability consultants to calculate personal carbon footprints.
Built using Java Servlets, JSP, Session Tracking, and Cookies as per mini-project specification.

---

## Project Structure
```
CarbonFootprintCalculator/
├── pom.xml                                      ← Maven build file
└── src/main/
    ├── java/com/carbon/servlet/
    │   ├── FootprintResult.java                 ← Model (Serializable, stored in session)
    │   ├── HomeServlet.java                     ← Reads cookie, serves index.jsp
    │   ├── CalculateServlet.java                ← Core: reads params, computes, saves session
    │   ├── HistoryServlet.java                  ← Reads session history, serves history.jsp
    │   └── ClearHistoryServlet.java             ← Invalidates session
    └── webapp/
        ├── WEB-INF/
        │   ├── web.xml                          ← Servlet mappings, session config
        │   └── jsp/
        │       ├── index.jsp                    ← Input form
        │       ├── result.jsp                   ← Score + breakdown (JSP EL + JSTL)
        │       └── history.jsp                  ← Session history log
        ├── css/style.css
        └── js/main.js
```

---

## Technologies Used (as per spec)
| Spec Requirement      | Implementation                                       |
|-----------------------|------------------------------------------------------|
| Servlet               | `CalculateServlet`, `HomeServlet`, `HistoryServlet`  |
| JSP                   | `index.jsp`, `result.jsp`, `history.jsp`             |
| Reading Servlet Params| `request.getParameter(...)` in CalculateServlet      |
| Session Tracking      | `HttpSession` stores `List<FootprintResult>` history |
| Cookies               | `cf_username` cookie persists username for 30 days   |

---

## How to Run

### Prerequisites
- Java 11+
- Apache Maven 3.6+
- Apache Tomcat 10+ (for Jakarta EE 9 / Servlet 5.0)
  OR use the embedded Tomcat Maven plugin

### Option 1: Deploy to Tomcat
```bash
# 1. Build the WAR
mvn clean package

# 2. Copy WAR to Tomcat webapps
cp target/CarbonFootprintCalculator.war /path/to/tomcat/webapps/

# 3. Start Tomcat
/path/to/tomcat/bin/startup.sh   # Linux/Mac
/path/to/tomcat/bin/startup.bat  # Windows

# 4. Open browser
http://localhost:8080/CarbonFootprintCalculator/home
```

### Option 2: Maven Tomcat Plugin (quick run)
```bash
mvn tomcat7:run
# Open: http://localhost:8080/carbon/home
```

---

## Application Flow

```
Browser                 Servlet                        JSP
  |                        |                            |
  |── GET /home ──────────>| HomeServlet                |
  |                        | reads cf_username cookie   |
  |                        |──────────────────────────>| index.jsp
  |<─────────────────────────────────────────────────── (form)
  |
  |── POST /calculate ────>| CalculateServlet           |
  |   (form data)          | getParameter() all inputs  |
  |                        | computes CO2e emissions    |
  |                        | saves to HttpSession       |
  |                        | sets cf_username Cookie    |
  |                        |──────────────────────────>| result.jsp
  |<─────────────────────────────────────────────────── (breakdown)
  |
  |── GET /history ───────>| HistoryServlet             |
  |                        | reads session history      |
  |                        |──────────────────────────>| history.jsp
  |<─────────────────────────────────────────────────── (log table)
  |
  |── POST /clearHistory ─>| ClearHistoryServlet        |
  |                        | session.invalidate()       |
  |<── redirect /home ─────|
```

---

## Emission Factors Used
| Category   | Factor                                                         |
|------------|----------------------------------------------------------------|
| Petrol car | 0.21 kg CO₂/km                                                |
| Diesel car | 0.19 kg CO₂/km                                                |
| Hybrid     | 0.10 kg CO₂/km                                                |
| Electric   | 0.05 kg CO₂/km                                                |
| Flights    | Short 0.255 / Medium 0.195 / Long 0.150 kg CO₂/km            |
| Public transport | 0.089 kg CO₂/km                                         |
| Coal grid  | 0.82 kg CO₂/kWh                                               |
| Mixed grid | 0.45 kg CO₂/kWh                                               |
| Renewables | 0.05 kg CO₂/kWh                                               |
| Natural gas| 2.02 kg CO₂/m³                                                |
| Diet       | Vegan 1.0 → Heavy meat 3.3 t CO₂e/year                       |

Sources: IPCC AR6, UK DEFRA Conversion Factors 2023

---

## Viva Q&A Points

**Q: How are servlet parameters read?**
A: In `CalculateServlet.doPost()`, `request.getParameter("carKm")` reads each form field by name.

**Q: How is session tracking implemented?**
A: `HttpSession session = request.getSession(true)` creates/retrieves a session.
   A `List<FootprintResult>` is stored as `session.setAttribute("calculationHistory", history)`.
   Tomcat automatically manages the session cookie (`CARBONSESSIONID`).

**Q: How are cookies used?**
A: `CalculateServlet` creates `new Cookie("cf_username", userName)` with `maxAge = 30 days`
   and adds it via `response.addCookie(cookie)`. `HomeServlet` reads it with `request.getCookies()`.

**Q: What is the difference between session and cookie here?**
A: Cookie stores a simple string (username) on the client. Session stores complex objects
   (full result history) server-side, identified by the session cookie.

**Q: How does JSP display the results?**
A: `CalculateServlet` sets `request.setAttribute("result", result)` then forwards to `result.jsp`.
   JSP uses EL `${result.formattedTotal}` and JSTL `<c:if>`, `<c:forEach>` tags to render data.
