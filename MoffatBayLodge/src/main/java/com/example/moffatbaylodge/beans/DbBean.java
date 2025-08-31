package com.example.moffatbaylodge.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.password4j.BadParametersException;
import com.password4j.MessageDigestFunction;
import com.password4j.Password;
import com.password4j.ScryptFunction;

public class DbBean {

    private static final String URL  =
            "jdbc:mysql://127.0.0.1:3306/moffatlodgedb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "moffatlodgedb";
    private static final String PASS = "group4";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL 8/9 driver
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    /* Get connection */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    /** Does an email already exist? */
    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM guests WHERE EmailAddress = ? LIMIT 1";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    /** Validate credentials. Returns GuestID if valid, null if not. May upgrade MD5 → scrypt. */
    public Integer validateGuest(String email, String rawPassword) throws Exception {
        String sql = "SELECT GuestID, Password FROM guests WHERE EmailAddress = ?";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, email);

            Integer id = null;
            String stored = null;

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    id = rs.getInt("GuestID");
                    stored = rs.getString("Password");
                } else {
                    return null; // no such email
                }
            }

            // Try scrypt first
            try {
                ScryptFunction scrypt = ScryptFunction.getInstanceFromHash(stored);
                boolean ok = Password.check(rawPassword, stored).with(scrypt);
                return ok ? id : null;
            } catch (BadParametersException notScrypt) {
                // Legacy MD5 fallback
                MessageDigestFunction md5 = MessageDigestFunction.getInstance("MD5");
                boolean ok = Password.check(rawPassword, stored).with(md5);
                if (!ok) return null;

                // Upgrade to scrypt
                String newHash = Password.hash(rawPassword).withScrypt().getResult();
                try (PreparedStatement up = c.prepareStatement(
                        "UPDATE guests SET Password=? WHERE GuestID=?")) {
                    up.setString(1, newHash);
                    up.setInt(2, id);
                    up.executeUpdate();
                }
                return id;
            }
        }
    }
}

