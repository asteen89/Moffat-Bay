package com.example.moffatbaylodge.security;

import com.password4j.BadParametersException;
import com.password4j.Hash;
import com.password4j.MessageDigestFunction;
import com.password4j.Password;
import com.password4j.ScryptFunction;

import java.sql.Connection;
import java.sql.PreparedStatement;

// https://github.com/Password4j/password4j?tab=readme-ov-file

/* Hashes password with scrypt, verifies with scrypt, if it detects non-scrypt
it will throw a bad parameters exception and verify with MD5 and then rehash
with scrypt and update the database. Using salt but not using pepper can
add later if needing more security.

 */

public final class PasswordUtil {
    private PasswordUtil() {}

    /** Create a scrypt hash for new users */
    public static String hashScrypt(String rawPassword) {
        if (rawPassword == null) throw new IllegalArgumentException("password is null");
        Hash hash = Password.hash(rawPassword).withScrypt(); // salt
        return hash.getResult();
    }

    public static boolean verifyAndMigrateFromMD5ToScrypt(Connection conn,
                                                          int userId,
                                                          String providedPassword,
                                                          String passwordFromDB) {
        if (providedPassword == null || passwordFromDB == null) return false;

        try {
            // Try to parse as scrypt first
            ScryptFunction scrypt = ScryptFunction.getInstanceFromHash(passwordFromDB);
            return Password.check(providedPassword, passwordFromDB).with(scrypt);

        } catch (BadParametersException notScrypt) {
            // If does not work as scrypt, treat as legacy MD5 and verify using MD5.
            MessageDigestFunction md5 = MessageDigestFunction.getInstance("MD5");
            boolean ok = Password.check(providedPassword, passwordFromDB).with(md5);
            if (!ok) return false;

            // If verified, re-hash with scrypt and update the DB.
            String newHash = Password.hash(providedPassword).withScrypt().getResult();
            try (PreparedStatement up = conn.prepareStatement(
                    "UPDATE guests SET Password=? WHERE GuestID=?")) {
                up.setString(1, newHash);
                up.setInt(2, userId);
                up.executeUpdate();
            } catch (Exception e) {
                System.err.println("[PasswordUtil] Failed upgrading MD5→scrypt: " + e);
                // Password is correct but the migration failed; still return true so the user can log in.
            }
            return true;
        }
    }
}
