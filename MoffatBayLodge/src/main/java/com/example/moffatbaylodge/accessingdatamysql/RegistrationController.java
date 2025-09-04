package com.example.moffatbaylodge.accessingdatamysql;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class RegistrationController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/register")
    public String showForm() {
        return "Registration"; // resolves to Registration.jsp
    }

    @PostMapping("/register")
    public String register(
            @RequestParam("firstName") String firstName,
            @RequestParam("lastName")  String lastName,
            @RequestParam("email")     String email,
            @RequestParam("phone")     String phone,
            @RequestParam("password")  String password,
            RedirectAttributes ra
    ) {
        User u = new User();
        u.setFirstName(firstName);
        u.setLastName(lastName);
        u.setEmailAddress(email);
        u.setPhoneNumber(phone);
        u.setPassword(password); // your entity uses passwordHash
        userRepository.save(u);

        return "redirect:/login";
    }

    @GetMapping("/users")
    @ResponseBody
    public Iterable<User> getAllUsers() {
        return userRepository.findAll();
    }
}