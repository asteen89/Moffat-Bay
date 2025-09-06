package com.example.moffatbaylodge.authentication;

import com.example.moffatbaylodge.security.PasswordUtil;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.sql.Connection;

// Authentication service configuration

@Service
public class PassService {
    private final DataSource dataSource;
    private final JdbcTemplate jdbc;

    public PassService(DataSource dataSource, JdbcTemplate jdbc) {
        this.dataSource = dataSource;
        this.jdbc = jdbc;
    }

    public Integer authenticate(String emailAddress, String providedPassword) {
        String sql = "SELECT GuestID, Password FROM guests WHERE EmailAddress = ?";

        try {
            return jdbc.queryForObject(sql, (rs, i) -> {
                int userId = ((Number) rs.getObject("GuestID")).intValue();
                String storedHash = rs.getString("Password");

                try (Connection conn = dataSource.getConnection()) {
                    boolean ok = PasswordUtil.verifyAndMigrateFromMD5ToScrypt(
                            conn, userId, providedPassword, storedHash
                    );
                    return ok ? userId : null;
                } catch (Exception e) {
                    e.printStackTrace();
                    return null;
                }
            }, emailAddress);
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            return null; // no user for that email
        }
    }
}

