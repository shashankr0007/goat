package com.carbon.servlet;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Model class to hold one carbon footprint calculation result.
 * Stored in HttpSession for history tracking.
 */
public class FootprintResult implements Serializable {

    private static final long serialVersionUID = 1L;

    // Input fields
    private double carKmPerWeek;
    private String carType;
    private int flightsPerYear;
    private String flightLength;
    private double publicTransportKmPerWeek;
    private double electricityKwhPerMonth;
    private String electricitySource;
    private double gasM3PerMonth;
    private String heatingType;
    private String diet;

    // Computed CO2e values (in tonnes per year)
    private double travelCO2;
    private double energyCO2;
    private double dietCO2;
    private double totalCO2;

    // Metadata
    private String calculatedAt;
    private String rating; // "Low", "Medium", "High"

    public FootprintResult() {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
        this.calculatedAt = LocalDateTime.now().format(fmt);
    }

    // ---- Getters & Setters ----

    public double getCarKmPerWeek() { return carKmPerWeek; }
    public void setCarKmPerWeek(double v) { this.carKmPerWeek = v; }

    public String getCarType() { return carType; }
    public void setCarType(String v) { this.carType = v; }

    public int getFlightsPerYear() { return flightsPerYear; }
    public void setFlightsPerYear(int v) { this.flightsPerYear = v; }

    public String getFlightLength() { return flightLength; }
    public void setFlightLength(String v) { this.flightLength = v; }

    public double getPublicTransportKmPerWeek() { return publicTransportKmPerWeek; }
    public void setPublicTransportKmPerWeek(double v) { this.publicTransportKmPerWeek = v; }

    public double getElectricityKwhPerMonth() { return electricityKwhPerMonth; }
    public void setElectricityKwhPerMonth(double v) { this.electricityKwhPerMonth = v; }

    public String getElectricitySource() { return electricitySource; }
    public void setElectricitySource(String v) { this.electricitySource = v; }

    public double getGasM3PerMonth() { return gasM3PerMonth; }
    public void setGasM3PerMonth(double v) { this.gasM3PerMonth = v; }

    public String getHeatingType() { return heatingType; }
    public void setHeatingType(String v) { this.heatingType = v; }

    public String getDiet() { return diet; }
    public void setDiet(String v) { this.diet = v; }

    public double getTravelCO2() { return travelCO2; }
    public void setTravelCO2(double v) { this.travelCO2 = v; }

    public double getEnergyCO2() { return energyCO2; }
    public void setEnergyCO2(double v) { this.energyCO2 = v; }

    public double getDietCO2() { return dietCO2; }
    public void setDietCO2(double v) { this.dietCO2 = v; }

    public double getTotalCO2() { return totalCO2; }
    public void setTotalCO2(double v) { this.totalCO2 = v; }

    public String getCalculatedAt() { return calculatedAt; }

    public String getRating() { return rating; }
    public void setRating(String v) { this.rating = v; }

    // Percentage helpers for JSP progress bars
    public int getTravelPercent() {
        return totalCO2 > 0 ? (int) Math.round(travelCO2 / totalCO2 * 100) : 0;
    }
    public int getEnergyPercent() {
        return totalCO2 > 0 ? (int) Math.round(energyCO2 / totalCO2 * 100) : 0;
    }
    public int getDietPercent() {
        return totalCO2 > 0 ? (int) Math.round(dietCO2 / totalCO2 * 100) : 0;
    }

    public String getFormattedTotal() {
        return String.format("%.2f", totalCO2);
    }
    public String getFormattedTravel() { return String.format("%.2f", travelCO2); }
    public String getFormattedEnergy() { return String.format("%.2f", energyCO2); }
    public String getFormattedDiet()   { return String.format("%.2f", dietCO2); }
}
