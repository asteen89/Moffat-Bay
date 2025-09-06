package com.example.moffatbaylodge.web;

import org.springframework.context.annotation.Profile;
import org.springframework.web.bind.annotation.*;

import com.example.moffatbaylodge.beans.UserBean;
import com.password4j.Hash;
import com.password4j.Password;

import org.springframework.jdbc.core.JdbcTemplate;

@Profile("db")
@RestController
@RequestMapping("/api/home")
public class RegisterApi {

    private final JdbcTemplate db;
    public RegisterApi(JdbcTemplate db) { this.db = db; }

    @PostMapping
    public String register(UserBean user) {
        Hash hash = Password.hash(user.getPassword()).withBcrypt(); // <-- lowercase c
        String hashed = hash.getResult();

        int rows = db.update(
                "INSERT INTO guests (FirstName, LastName, EmailAddress, PhoneNumber, Password) VALUES (?, ?, ?, ?, ?)",
                user.getFirstName(), user.getLastName(), user.getEmail(), user.getPhone(), hashed
        );
        return "rows=" + rows;
    }
}