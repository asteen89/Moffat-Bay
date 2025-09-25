package com.example.moffatbaylodge.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    // GET /
    @GetMapping("/")
    public String home() {
        return "index";          // /WEB-INF/jsp/index.jsp
    }

    // GET /login
    @GetMapping("/login")
    public String login() {
        return "login";          // /WEB-INF/jsp/login.jsp
    }

    // GET /registration
    @GetMapping("/registration")
    public String registration() {
        return "registration";   // /WEB-INF/jsp/registration.jsp
    }

    // GET /attractions
    @GetMapping("/attractions")
    public String attractions() {
        return "attractions";    // -> /WEB-INF/jsp/attractions.jsp
    }
}


