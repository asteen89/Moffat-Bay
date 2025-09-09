package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.config.Model;
import com.example.moffatbaylodge.session.AuthSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

// this is just a test

@Controller
public class ReservationController {
    @GetMapping("/reservation")
    public String reservation(@ModelAttribute("auth") AuthSession auth, Model model) {
        String gate = GuardedPages.require(auth, "/reservation"); // the guard is here
        if (gate != null) return gate;

        // page content
        return "reservation"; // /WEB-INF/jsp/reservation.jsp
    }

    @PostMapping("/reservation")
    public String submit(@ModelAttribute("auth") AuthSession auth /*, ... */) {
        String gate = GuardedPages.require(auth, "/reservation");
        if (gate != null) return gate;

        // handles the submission
        return "reservation-confirm";
    }
}