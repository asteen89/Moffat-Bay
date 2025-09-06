package com.example.moffatbaylodge.web;

import java.util.Map;

import org.springframework.context.annotation.Profile;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.moffatbaylodge.beans.UserBean;
import com.password4j.Password;

@Profile("db")
@RestController
@RequestMapping("/api/login")
public class LoginApi {
    private final JdbcTemplate db;

    public LoginApi(JdbcTemplate db) {
        this.db = db;
    }



    @PostMapping
    public Map<String, Object> login(@RequestBody UserBean user) {
        String storedHash;
        try {
            storedHash = db.queryForObject(
                    "SELECT Password FROM guests WHERE EmailAddress = ?",
                    String.class,
                    user.getEmail()
            );
        } catch (EmptyResultDataAccessException e) {
            return Map.of("ok", false);
        }
        boolean ok = Password.check(user.getPassword(), storedHash).withBcrypt();
        return Map.of("ok", ok);
    }
}
