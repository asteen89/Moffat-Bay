package com.example.moffatbaylodge.authentication;

import com.example.moffatbaylodge.security.PasswordUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.HashMap;
import java.util.Map;

// Hashes password upon registration of account. Will insert data into the rows and return a generated GuestID
// fixed errors

@Service
public class RegistrationHash {
    private static final Logger log = LoggerFactory.getLogger(RegistrationHash.class);
    private final SimpleJdbcInsert insert;

    public RegistrationHash(JdbcTemplate jdbc) {
        this.insert = new SimpleJdbcInsert(jdbc)
                .withTableName("guests")
                .usingGeneratedKeyColumns("GuestID"); // primary key value here
    }

    @Transactional
    public Integer register(String first, String last, String email, String phone, String rawPassword) {
        Integer dup = insert.getJdbcTemplate().queryForObject(
                "SELECT COUNT(*) FROM guests WHERE EmailAddress = ?", Integer.class, email);
        if (dup != null && dup > 0) throw new IllegalArgumentException("Email already in use");

        String hash = PasswordUtil.hashScrypt(rawPassword);

        Map<String, Object> params = new HashMap<>();
        params.put("FirstName",    first);
        params.put("LastName",     last);
        params.put("EmailAddress", email);
        params.put("PhoneNumber",  phone);
        params.put("Password",     hash);

        try {
            Number key = insert.executeAndReturnKey(params);
            log.info("Registered {} -> {}", email, key);
            return key.intValue();
        } catch (DuplicateKeyException e) {
            throw new IllegalArgumentException("Email or phone number already in use");
        }
    }
}



