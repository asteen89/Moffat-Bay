package com.example.moffatbaylodge.security;

import jakarta.servlet
.ServletException;
import jakarta.servlet
.annotation.WebServlet;
import jakarta.servlet
.http.HttpServlet;
import jakarta.servlet
.http.HttpServletRequest;
import jakarta.servlet
.http.HttpServletResponse;
import jakarta.servlet
.*;
import jakarta.servlet
.annotation.WebFilter;
import jakarta.servlet
.http.*;
import java.io.IOException;

// Filter for /secure/* pages these must be secure (i.e. logged-in) areas
// If not logged in, redirect to login.jsp
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession session = request.getSession(false);
        String uri = request.getRequestURI();

        // Allow access to login and registration pages
        if (uri.endsWith("/login") || uri.endsWith("/register") || uri.endsWith("/login.jsp") || uri.endsWith("/Registration.jsp")) {
            chain.doFilter(req, resp);
            return;
        }

        // Check for authenticated session
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        chain.doFilter(req, resp);
    }
}