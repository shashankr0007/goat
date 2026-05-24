package com.carbon.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * CalculateServlet — reads form parameters, computes carbon footprint,
 * saves result in HttpSession, sets a username Cookie, then forwards to result.jsp.
 *
 * Emission factors used:
 *  Car:     Petrol 0.21 kg/km | Diesel 0.19 | Hybrid 0.10 | Electric 0.05
 *  Flights: Short 0.255 kg/km (~600km avg) | Medium 0.195 (~2000km) | Long 0.150 (~7000km)
 *  Transit: 0.089 kg/km (bus/metro average)
 *  Electricity: Coal 0.82 kg/kWh | Mixed 0.45 | Renewables 0.05
 *  Gas: Natural 2.02 kg/m³ | Oil 2.54 | Heat pump 0.40 | Wood 0.39
 *  Diet (annual): Meat-heavy 3.3t | Average 2.5t | Less-meat 1.9t
 *                 Pescatarian 1.5t | Vegetarian 1.3t | Vegan 1.0t
 */
public class CalculateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // ======================================================
        // 1. READ SERVLET PARAMETERS
        // ======================================================
        String userName    = getParam(request, "userName", "User");
        double carKm       = parseDouble(request, "carKm", 0);
        String carType     = getParam(request, "carType", "none");
        int flights        = parseInt(request, "flights", 0);
        String flightLen   = getParam(request, "flightLength", "medium");
        double ptKm        = parseDouble(request, "publicTransportKm", 0);
        double electricity = parseDouble(request, "electricity", 0);
        String elecSource  = getParam(request, "electricitySource", "mixed");
        double gas         = parseDouble(request, "gas", 0);
        String heatType    = getParam(request, "heatingType", "gas");
        String diet        = getParam(request, "diet", "average");

        // ======================================================
        // 2. COMPUTE EMISSIONS
        // ======================================================

        // --- Travel ---
        double carEF = getCarEmissionFactor(carType);          // kg CO2 per km
        double carCO2 = carKm * 52 * carEF / 1000;            // tonnes/year

        double[] flightData = getFlightData(flightLen);
        double flightEF  = flightData[0];                      // kg CO2 per km
        double flightKm  = flightData[1];                      // avg km per flight
        double flightCO2 = flights * flightKm * flightEF / 1000;

        double ptCO2 = ptKm * 52 * 0.089 / 1000;              // tonnes/year

        double travelTotal = round2(carCO2 + flightCO2 + ptCO2);

        // --- Energy ---
        double elecEF  = getElecEmissionFactor(elecSource);    // kg CO2 per kWh
        double elecCO2 = electricity * 12 * elecEF / 1000;

        double gasEF   = getGasEmissionFactor(heatType);       // kg CO2 per m³
        double gasCO2  = gas * 12 * gasEF / 1000;

        double energyTotal = round2(elecCO2 + gasCO2);

        // --- Diet ---
        double dietTotal = getDietEmissions(diet);             // tonnes/year, fixed table

        // --- Grand Total ---
        double total = round2(travelTotal + energyTotal + dietTotal);

        // --- Rating ---
        String rating;
        if      (total < 2.3) rating = "Low";
        else if (total < 4.7) rating = "Medium";
        else                  rating = "High";

        // ======================================================
        // 3. BUILD RESULT OBJECT
        // ======================================================
        FootprintResult result = new FootprintResult();
        result.setCarKmPerWeek(carKm);
        result.setCarType(carType);
        result.setFlightsPerYear(flights);
        result.setFlightLength(flightLen);
        result.setPublicTransportKmPerWeek(ptKm);
        result.setElectricityKwhPerMonth(electricity);
        result.setElectricitySource(elecSource);
        result.setGasM3PerMonth(gas);
        result.setHeatingType(heatType);
        result.setDiet(diet);
        result.setTravelCO2(travelTotal);
        result.setEnergyCO2(energyTotal);
        result.setDietCO2(dietTotal);
        result.setTotalCO2(total);
        result.setRating(rating);

        // ======================================================
        // 4. SESSION TRACKING — save to history list
        // ======================================================
        HttpSession session = request.getSession(true);

        @SuppressWarnings("unchecked")
        List<FootprintResult> history =
            (List<FootprintResult>) session.getAttribute("calculationHistory");

        if (history == null) {
            history = new ArrayList<>();
        }

        history.add(0, result);           // newest first
        if (history.size() > 10) {
            history = history.subList(0, 10);   // keep last 10
        }

        session.setAttribute("calculationHistory", history);
        session.setAttribute("latestResult", result);
        session.setAttribute("userName", userName);

        // ======================================================
        // 5. COOKIE — remember username for 30 days
        // ======================================================
        Cookie userCookie = new Cookie("cf_username", userName);
        userCookie.setMaxAge(30 * 24 * 60 * 60);  // 30 days
        userCookie.setPath("/");
        userCookie.setHttpOnly(true);
        response.addCookie(userCookie);

        // ======================================================
        // 6. FORWARD TO RESULT JSP
        // ======================================================
        request.setAttribute("result", result);
        request.setAttribute("userName", userName);
        request.getRequestDispatcher("/WEB-INF/jsp/result.jsp")
               .forward(request, response);
    }

    // ---- Emission Factor Helpers ----

    private double getCarEmissionFactor(String carType) {
        switch (carType) {
            case "petrol":   return 0.21;
            case "diesel":   return 0.19;
            case "hybrid":   return 0.10;
            case "electric": return 0.05;
            default:         return 0.00; // none / no car
        }
    }

    private double[] getFlightData(String length) {
        // [emission factor kg/km, avg km per flight]
        switch (length) {
            case "short":  return new double[]{0.255, 600};
            case "long":   return new double[]{0.150, 7000};
            default:       return new double[]{0.195, 2000}; // medium
        }
    }

    private double getElecEmissionFactor(String source) {
        switch (source) {
            case "coal":       return 0.82;
            case "renewables": return 0.05;
            default:           return 0.45; // mixed
        }
    }

    private double getGasEmissionFactor(String heatingType) {
        switch (heatingType) {
            case "oil":      return 2.54;
            case "heatpump": return 0.40;
            case "wood":     return 0.39;
            default:         return 2.02; // natural gas
        }
    }

    private double getDietEmissions(String diet) {
        switch (diet) {
            case "meat-heavy":   return 3.3;
            case "less-meat":    return 1.9;
            case "pescatarian":  return 1.5;
            case "vegetarian":   return 1.3;
            case "vegan":        return 1.0;
            default:             return 2.5; // average
        }
    }

    // ---- Parsing Helpers ----

    private String getParam(HttpServletRequest req, String name, String def) {
        String v = req.getParameter(name);
        return (v == null || v.trim().isEmpty()) ? def : v.trim();
    }

    private double parseDouble(HttpServletRequest req, String name, double def) {
        try { return Double.parseDouble(req.getParameter(name)); }
        catch (Exception e) { return def; }
    }

    private int parseInt(HttpServletRequest req, String name, int def) {
        try { return Integer.parseInt(req.getParameter(name)); }
        catch (Exception e) { return def; }
    }

    private double round2(double v) {
        return Math.round(v * 100.0) / 100.0;
    }
}
