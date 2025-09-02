package com.example.moffatbaylodge.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping("/")
    public String home() {
        return "index"; // Connect to /WEB-INF/jsp/index.jsp
    }
}
// test to reupload to github
