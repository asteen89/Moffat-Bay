package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.authentication.PassService;
import com.example.moffatbaylodge.authentication.RegistrationHash;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/auth")
public class AuthController {
    private final RegistrationHash registrationHash;
    private final PassService passService;

    public AuthController(RegistrationHash registrationHash, PassService passService) {
        this.registrationHash = registrationHash;
        this.passService = passService;
    }

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }

    // Set up with error message in case invalid email/password is attempted
    @PostMapping("/login")
    public String login(@RequestParam(value = "emailAddress", required = false) String emailAddress,
                        @RequestParam(value = "email",        required = false) String email,
                        @RequestParam(value = "username",     required = false) String username,
                        @RequestParam String password,
                        HttpSession session,
                        RedirectAttributes ra) {

        String emailAddr = (emailAddress != null && !emailAddress.isBlank()) ? emailAddress
                : (email != null && !email.isBlank()) ? email
                : (username != null && !username.isBlank()) ? username
                : null;

        if (emailAddr == null || password.isBlank()) {
            ra.addFlashAttribute("errorMessage", "Please enter your email/username and password.");
            return "redirect:/auth/login";
        }

        Integer guestId = passService.authenticate(emailAddr, password);
        if (guestId == null) {
            ra.addFlashAttribute("errorMessage", "Invalid email or password.");
            return "redirect:/auth/login";
        }

        session.setAttribute("guestId", guestId);
        return "redirect:/";
    }

    @GetMapping("/register")
    public String showRegister() {
        return "registration"; // view name: registration.jsp
    }

    private static final java.util.regex.Pattern EMAIL_RX =
            java.util.regex.Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    @PostMapping("/register")
    public String register(@RequestParam String firstName,
                           @RequestParam String lastName,
                           @RequestParam String emailAddress,
                           @RequestParam String phoneNumber,
                           @RequestParam String password,
                           RedirectAttributes ra) {

        String email = (emailAddress == null) ? null : emailAddress.trim().toLowerCase();
        // error message incase wrong email format input
        if (email == null || !EMAIL_RX.matcher(email).matches()) {
            ra.addFlashAttribute("errorMessage", "Please enter a valid email address.");
            return "redirect:/auth/register";
        }
        // Registration hashing
        registrationHash.register(firstName, lastName, email, phoneNumber, password);

        return "redirect:/auth/login?registered";
    }
// Session Management
    @GetMapping("/session/create")
    @ResponseBody
    public String create(HttpSession session) {
        session.setAttribute("guestId", 123); // demo value
        return "created sid=" + session.getId();
    }

    @GetMapping("/session/get")
    @ResponseBody
    public String get(HttpSession session) {
        Object gid = session.getAttribute("guestId");
        return (gid == null) ? "no session data" : "guestId=" + gid;
    }

    @GetMapping("/session/invalidate")
    @ResponseBody
    public String invalidate(HttpSession session) {
        session.invalidate();
        return "invalidated";
    }

    //LOGOUT // no logout page set up yet or button, will adjust that as necessary

    @PostMapping("/logout")
    public String logout(HttpSession session) {
        if (session != null) session.invalidate();
        return "redirect:/auth/login";
    }

    @GetMapping("/logout")
    public String logoutGet(HttpSession session) {
        if (session != null) session.invalidate();
        return "redirect:/auth/login";
    }
}
