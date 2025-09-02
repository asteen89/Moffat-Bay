package com.example.moffatbaylodge.web;

import com.moffatbaylodge.beans.UserBean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

import java.util.Map;

@RestController
@RequestMapping("/api/login")
@CrossOrigin
public class LoginApi {

    private final JdbcTemplate db;

    public LoginApi(JdbcTemplate db) {
        this.db = db;
    }

    // POST /api/login
    @PostMapping
    public Map<String, Object> login(@RequestBody UserBean user, HttpSession session) {
        Integer count = db.queryForObject(
                "SELECT COUNT(*) FROM guests WHERE EmailAddress = ? AND Password = ?",
                Integer.class,
                user.getEmail(),
                user.getPassword()
        );

        if (count != null && count == 1) {
            // Login
            session.setAttribute("userEmail", user.getEmail());
            return Map.of("ok", true);
        }
        return Map.of("ok", false);
    }
}