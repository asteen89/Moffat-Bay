package com.example.moffatbaylodge.security;

import com.password4j.BadParametersException;
import com.password4j.Hash;
import com.password4j.MessageDigestFunction;
import com.password4j.Password;
import com.password4j.ScryptFunction;

import java.sql.Connection;
import java.sql.PreparedStatement;

public final class PasswordUtil {
    private PasswordUtil() {}

    /** Create a scrypt hash for new users (salt + params are embedded in the result). */
    public static String hashScrypt(String rawPassword) {
        if (rawPassword == null) throw new IllegalArgumentException("password is null");
        Hash hash = Password.hash(rawPassword).withScrypt(); // sensible defaults
        return hash.getResult();
    }

    /**
     * Verify a provided password against a DB value that may be scrypt (new) or MD5 (legacy).
     * If it's legacy MD5 and the password is correct, migrate the stored hash to scrypt.
     *
     * @return true if password is valid (and possibly migrated), false otherwise
     */
    public static boolean verifyAndMigrateFromMD5ToScrypt(Connection conn,
                                                          int userId,
                                                          String providedPassword,
                                                          String passwordFromDB) {
        if (providedPassword == null || passwordFromDB == null) return false;

        try {
            // 1) Try to parse as scrypt; if that succeeds, verify with the embedded params.
            ScryptFunction scrypt = ScryptFunction.getInstanceFromHash(passwordFromDB);
            return Password.check(providedPassword, passwordFromDB).with(scrypt);

        } catch (BadParametersException notScrypt) {
            // 2) Not scrypt → treat as legacy MD5 and verify using MD5.
            MessageDigestFunction md5 = MessageDigestFunction.getInstance("MD5");
            boolean ok = Password.check(providedPassword, passwordFromDB).with(md5);
            if (!ok) return false;

            // 3) If verified, re-hash with scrypt and update the DB.
            String newHash = Password.hash(providedPassword).withScrypt().getResult();
            try (PreparedStatement up = conn.prepareStatement(
                    "UPDATE guests SET Password=? WHERE GuestID=?")) {
                up.setString(1, newHash);
                up.setInt(2, userId);
                up.executeUpdate();
            } catch (Exception e) {
                System.err.println("[PasswordUtil] Failed upgrading MD5→scrypt: " + e);
                // Password is correct but migration failed; still return true so the user can log in.
            }
            return true;
        }
    }
}
