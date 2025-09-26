package com.example.moffatbaylodge.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

// controller for the attractions page

@Controller
public class AttractionsController {
    @GetMapping("/attractions")
    public String attractions() {
        return "attractions";
    }
}