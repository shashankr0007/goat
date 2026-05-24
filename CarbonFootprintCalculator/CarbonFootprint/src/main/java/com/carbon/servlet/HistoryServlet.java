package com.carbon.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;

import java.io.IOException;
import java.util.List;

/**
 * HistoryServlet — reads calculation history from HttpSession
 * and forwards to history.jsp for display.
 */
public class HistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        String userName = null;
        List<FootprintResult> history = null;

        if (session != null) {
            history  = (List<FootprintResult>) session.getAttribute("calculationHistory");
            userName = (String) session.getAttribute("userName");
        }

        // Also try cookie for name
        if (userName == null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("cf_username".equals(c.getName())) {
                        userName = c.getValue();
                    }
                }
            }
        }

        request.setAttribute("history", history);
        request.setAttribute("userName", userName != null ? userName : "User");
        request.getRequestDispatcher("/WEB-INF/jsp/history.jsp")
               .forward(request, response);
    }
}
