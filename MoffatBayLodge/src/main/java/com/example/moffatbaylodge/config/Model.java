package com.example.moffatbaylodge.config;

import com.example.moffatbaylodge.session.AuthSession;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

// This page provides a model attribute globally to all the controllers

@ControllerAdvice
public class Model {
    @ModelAttribute("auth")
    public AuthSession auth(HttpSession httpSession) {

        Object existing = httpSession.getAttribute("auth");
        if (existing instanceof AuthSession a) return a;

        AuthSession a = new AuthSession();
        httpSession.setAttribute("auth", a);
        return a;
    }
}
