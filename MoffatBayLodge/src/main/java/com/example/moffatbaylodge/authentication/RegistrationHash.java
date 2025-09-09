package com.example.moffatbaylodge.authentication;

import com.example.moffatbaylodge.security.PasswordUtil;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

// Creates the new account in the database works alongside the password hashing service

@Service
public class RegistrationHash {
    private final JdbcTemplate jdbc;

    public RegistrationHash(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }
// register with MYSQL requirements ,, storing hash password
    public Integer register(String firstName,
                            String lastName,
                            String emailAddress,
                            String phoneNumber,
                            String rawPassword) {
        String hash = PasswordUtil.hashScrypt(rawPassword);
        jdbc.update(
                "INSERT INTO `guests` (`FirstName`, `LastName`, `EmailAddress`, `PhoneNumber`, `Password`) " +
                        "VALUES (?, ?, ?, ?, ?)",
                firstName, lastName, emailAddress, phoneNumber, hash
        );
        return null;
    }
}

