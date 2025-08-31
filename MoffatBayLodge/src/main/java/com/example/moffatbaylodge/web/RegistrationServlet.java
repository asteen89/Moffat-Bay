package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.beans.DbBean;
import com.example.moffatbaylodge.security.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {

    private static final String JSP_PATH = "/Registration.jsp"; // CASE must match the file!

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher(JSP_PATH).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String firstName   = trim(req.getParameter("firstName"));
        String lastName    = trim(req.getParameter("lastName"));
        String email       = trim(req.getParameter("email"));
        String phoneNumber = trim(req.getParameter("phoneNumber"));
        String password    = req.getParameter("password");

        // Debug: confirm we are in doPost and received values
        System.out.println("[RegistrationServlet] POST hit. email=" + email);

        if (isBlank(firstName) || isBlank(lastName) || isBlank(email) ||
                isBlank(phoneNumber) || isBlank(password)) {
            req.setAttribute("error", "Please fill all required fields.");
            req.getRequestDispatcher(JSP_PATH).forward(req, resp);
            return;
        }

        String hash = PasswordUtil.hashScrypt(password);

        String sql = "INSERT INTO guests (FirstName, LastName, EmailAddress, PhoneNumber, Password) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection connect = DbBean.getConnection();
             PreparedStatement ps = connect.prepareStatement(sql)) {

            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, phoneNumber);
            ps.setString(5, hash);

            int rows = ps.executeUpdate();
            if (rows != 1) {
                req.setAttribute("error", "Registration failed (no row inserted).");
                req.getRequestDispatcher(JSP_PATH).forward(req, resp);
                return;
            }

            req.getSession(true).setAttribute("messageBox", "Account created! Please log in.");
            String target = req.getContextPath() + "/login";
            System.out.println("[RegistrationServlet] Redirecting to " + target);
            resp.sendRedirect(target); // <-- redirect to a servlet path

        } catch (SQLIntegrityConstraintViolationException dup) {
            req.setAttribute("error", "That email is already registered.");
            req.getRequestDispatcher(JSP_PATH).forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Registration error: " + e.getMessage());
            req.getRequestDispatcher(JSP_PATH).forward(req, resp);
        }
    }

    private static String trim(String s) { return s == null ? null : s.trim(); }
    private static boolean isBlank(String s) { return s == null || s.trim().isEmpty(); }
}

