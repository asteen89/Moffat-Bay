package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.authentication.PassService;
import com.example.moffatbaylodge.authentication.RegistrationHash;
import com.example.moffatbaylodge.session.AuthSession;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/auth")
@SessionAttributes("auth") // store the auth model attribute in HTTP session
public class AuthController {
    private final RegistrationHash registrationHash;
    private final PassService passService;

    public AuthController(RegistrationHash registrationHash, PassService passService) {
        this.registrationHash = registrationHash;
        this.passService = passService;
    }


    @ModelAttribute("auth")
    public AuthSession auth() {
        AuthSession auth = new AuthSession();
        auth.setAuthenticated(false);
        return auth;
    }

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }

    // Set up with error message in case invalid email/password is attempted
    @PostMapping("/login")
    public String login(@RequestParam(value = "emailAddress", required = false) String emailAddress,
                        @RequestParam(value = "email", required = false) String email,
                        @RequestParam(value = "username", required = false) String username,
                        @RequestParam String password,
                        @ModelAttribute("auth") AuthSession auth, HttpSession session, RedirectAttributes ra) {

        String emailAddr = (emailAddress != null && !emailAddress.isBlank()) ? emailAddress
                : (email != null && !email.isBlank()) ? email
                : (username != null && !username.isBlank()) ? username
                : null;
        // error check again
        if (emailAddr == null || password.isBlank()) {
            ra.addFlashAttribute("errorMessage", "Please enter your email/username and password.");
            return "redirect:/auth/login";
        }

        Integer guestId = passService.authenticate(emailAddr, password);
        if (guestId == null) {
            ra.addFlashAttribute("errorMessage", "Invalid email or password.");
            return "redirect:/auth/login";
        }

        // authenticated in the @SessionAttributes
        auth.setAuthenticated(true);
        auth.setEmail(emailAddr.trim().toLowerCase());
        auth.setGuestId(guestId);


        session.setAttribute("guestId", guestId);

        return "redirect:/";
    }

    @GetMapping("/register")
    public String showRegister() {
        return "registration"; // registration.jsp
    }

    // setting up to catch invalid email entry
    private static final java.util.regex.Pattern EMAIL_RX =
            java.util.regex.Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    @PostMapping("/register")
    public String register(@RequestParam String firstName,
                           @RequestParam String lastName,
                           @RequestParam String emailAddress,
                           @RequestParam String phoneNumber,
                           @RequestParam String password,
                           @ModelAttribute("auth") AuthSession auth,
                           RedirectAttributes ra) {

        String emailNorm = (emailAddress == null) ? null : emailAddress.trim().toLowerCase();
        if (emailNorm == null || !EMAIL_RX.matcher(emailNorm).matches()) {
            ra.addFlashAttribute("errorMessage", "Please enter a valid email address.");
            return "redirect:/auth/register";
        }

        // Create the user (guestID)
        Integer guestId = registrationHash.register(firstName, lastName, emailNorm, phoneNumber, password);

        // Mark user as logged in for this session
        auth.setAuthenticated(true);
        auth.setEmail(emailNorm);
        auth.setGuestId(guestId);

        return "redirect:/"; // goes to home, button will now show Logout
    }

    // LOGOUT (both GET and POST) update to button to show login/logout on session change
    @PostMapping("/logout")
    public String logoutPost(HttpSession session, SessionStatus status) {
        // Clear @SessionAttributes
        status.setComplete(); // clears auth from session
        // Remove attribute incase it gets stored in the session
        if (session != null) {
            session.removeAttribute("auth");
            session.invalidate();
        }
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logoutGet(HttpSession session, SessionStatus status) {
        status.setComplete();
        if (session != null) {
            session.removeAttribute("auth");
            session.invalidate();
        }
        return "redirect:/";
    }
}
