package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.beans.UserBean;
import com.password4j.Password;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/login")
@CrossOrigin
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
