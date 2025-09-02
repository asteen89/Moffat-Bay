package com.example.moffatbaylodge.web;

import com.moffatbaylodge.beans.UserBean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/registration")
@CrossOrigin
public class RegisterApi {

    private final JdbcTemplate db;

    public RegisterApi(JdbcTemplate db) {
        this.db = db;
    }

    // Put information into the database
    @PostMapping
    public String register(@RequestBody UserBean user) {
        db.update(
                "INSERT INTO guests (FirstName, LastName, EmailAddress, PhoneNumber, Password) VALUES (?, ?, ?, ?, ?)",
                user.getFirstName(),
                user.getLastName(),
                user.getEmail(),
                user.getPhone(),
                user.getPassword()
        );
        return "User registered!";
    }
}
