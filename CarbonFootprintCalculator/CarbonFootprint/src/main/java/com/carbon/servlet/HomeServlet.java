package com.carbon.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;

import java.io.IOException;

/**
 * HomeServlet — serves the main input form (index.jsp).
 * Also reads a "username" cookie if previously set, and passes it to the JSP.
 */
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ---- Cookie Reading: check for returning user name ----
        String userName = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("cf_username".equals(c.getName())) {
                    userName = c.getValue();
                    break;
                }
            }
        }

        // Pass username to JSP (may be null for first visit)
        request.setAttribute("userName", userName);

        // Forward to the input form JSP
        request.getRequestDispatcher("/WEB-INF/jsp/index.jsp")
               .forward(request, response);
    }
}
