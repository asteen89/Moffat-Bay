package com.example.moffatbaylodge.web;

import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
@Profile("db")
@RestController
@RequestMapping("/api/home")
public class HomeApi {
    private final JdbcTemplate db;

    public HomeApi(JdbcTemplate db) {
        this.db = db;
    }

    // Show all room types/prices for the landing page
    @GetMapping("/rooms")
    public List<Map<String, Object>> rooms() {
        return db.queryForList("SELECT RoomID, RoomSize, RoomPrice, Quantity FROM RoomSize");
    }

    // Newsletter subscription
    @PostMapping("/newsletter")
    public Map<String, Object> subscribe(@RequestBody Map<String, String> in) {
        String email = in.getOrDefault("email", "").trim();
        if (email.isEmpty()) {
            return Map.of("ok", false, "error", "Email required");
        }
        db.update("INSERT IGNORE INTO Newsletter (EmailAddress) VALUES (?)", email);
        return Map.of("ok", true);
    }
}
