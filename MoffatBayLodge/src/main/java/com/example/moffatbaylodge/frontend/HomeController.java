package com.example.moffatbaylodge.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    // GET /
    @GetMapping("/")
    public String home() {
        return "index"; // directs to /WEB-INF/jsp/index.jsp
    }

    // GET /login
    @GetMapping("/login")
    public String login() {
        return "login"; // directs to /WEB-INF/jsp/login.jsp
    }


    // GET /register
    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }
}