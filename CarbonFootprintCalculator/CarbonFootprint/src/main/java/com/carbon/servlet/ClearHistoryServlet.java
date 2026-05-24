package com.carbon.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * ClearHistoryServlet — invalidates the current session (clears all history)
 * and redirects back to the home page.
 */
public class ClearHistoryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();   // removes all session attributes including history
        }
        response.sendRedirect(request.getContextPath() + "/home");
    }
}
