package com.example.moffatbaylodge.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    // GET /index
    public String home() {
        return "index";
    }

    // GET /login
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    // GET /registration
    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }
}
