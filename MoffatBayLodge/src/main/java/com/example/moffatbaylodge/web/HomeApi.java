package com.example.moffatbaylodge.web;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
@CrossOrigin
public class HomeApi {

    private final JdbcTemplate db;

    public HomeApi(JdbcTemplate db) {
        this.db = db;
    }

    // Landing page: example data fetch (adjust to your schema or remove if unused)
    @GetMapping("/rooms")
    public List<Map<String, Object>> rooms() {
        return db.queryForList(
                "SELECT RoomID, RoomSize, RoomPrice, Quantity FROM RoomSize"
        );
    }

    // Newsletter subscription endpoint
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
