package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.session.AuthSession;
import org.springframework.web.util.UriUtils;
import java.nio.charset.StandardCharsets;

/**
 * Utility for guarding controller handlers behind login.
 * If the user is authenticated, returns null; otherwise returns a Spring
 * "redirect" string to the login page with an encoded next parameter.
 */


 public final class GuardedPages {
     private GuardedPages() {}
        public static String require(AuthSession auth, String nextPath) {
            if (auth == null || !auth.isAuthenticated()) {
                String next = (nextPath == null || nextPath.isBlank()) ? "" :
                        "?next=" + UriUtils.encode(nextPath, StandardCharsets.UTF_8);
                return "redirect:/auth/login" + next;
            }
            return null;
        }
    }
