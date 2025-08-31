package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.beans.DbBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Show the login page
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("LoginServlet: Forwarding to /login.jsp");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    // Handle login submit
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String pass  = req.getParameter("password");

        if (email == null || pass == null || email.isBlank() || pass.isBlank()) {
            req.getSession(true).setAttribute("messageBox", "Please enter email and password.");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        Integer guestId;
        try {
            // DbBean should be stateless; create per request
            guestId = new DbBean().validateGuest(email.trim(), pass);
        } catch (Exception e) {
            e.printStackTrace(); // replace with real logging in production
            req.getSession(true).setAttribute("messageBox", "Sorry, something went wrong. Please try again.");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        if (guestId != null) {
            HttpSession ses = req.getSession(true);
            try { req.changeSessionId(); } catch (Throwable ignored) {} // session fixation protection
            ses.setAttribute("guestId", guestId);
            ses.setAttribute("guestEmail", email.trim());
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        } else {
            req.getSession(true).setAttribute("messageBox", "Invalid email or password.");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
}
