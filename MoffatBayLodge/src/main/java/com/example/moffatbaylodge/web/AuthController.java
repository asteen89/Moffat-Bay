package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.authentication.PassService;
import com.example.moffatbaylodge.authentication.RegistrationHash;
import com.example.moffatbaylodge.session.AuthSession;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/auth")
@SessionAttributes("auth")
public class AuthController {
    private final RegistrationHash registrationHash;
    private final PassService passService;

    private static final java.util.regex.Pattern EMAIL_RX =
            java.util.regex.Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

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
    public String showLogin(@RequestParam(value = "next", required = false) String next, ModelMap model) {
        model.addAttribute("next", next);
        return "login";
    }


    // Handles the POST login portion
    // It will accept an identifier then validate required fields, if there is
    // something missing we throw an error message with flash
    // Then normalize the identifier, validate the email format
    // Authenticate the user, if failed flash an error message
    // When succesful mark the session as authenticated and redirect to "next
    @PostMapping("/login")
    public String login(@RequestParam(value = "emailAddress", required = false) String emailAddress,
                        @RequestParam(value = "email",        required = false) String email,
                        @RequestParam String password,
                        @RequestParam(value = "next", required = false) String next,
                        @ModelAttribute("auth") AuthSession auth,
                        HttpSession session,
                        RedirectAttributes ra) {

        // Use whichever email field the form sent
        String emailRaw = (emailAddress != null && !emailAddress.isBlank()) ? emailAddress : email;

        // Require email AND password
        if (emailRaw == null || emailRaw.isBlank() || password == null || password.isBlank()) {
            ra.addFlashAttribute("errorMessage", "Please enter your email and password.");
            if (next != null && !next.isBlank()) ra.addFlashAttribute("next", next);
            return "redirect:/auth/login";
        }

        // Normalize and validate email
        String emailNorm = emailRaw.trim().toLowerCase();
        if (!EMAIL_RX.matcher(emailNorm).matches()) {
            ra.addFlashAttribute("errorMessage", "Please enter a valid email address.");
            if (next != null && !next.isBlank()) ra.addFlashAttribute("next", next);
            return "redirect:/auth/login";
        }

        // Authenticate
        Integer guestId = passService.authenticate(emailNorm, password);
        if (guestId == null) {
            ra.addFlashAttribute("errorMessage", "Invalid email or password.");
            if (next != null && !next.isBlank()) ra.addFlashAttribute("next", next);
            return "redirect:/auth/login";
        }

        // Mark logged in
        auth.setAuthenticated(true);
        auth.setEmail(emailNorm);
        auth.setGuestId(guestId);
        session.setAttribute("auth", auth);
        session.setAttribute("guestId", guestId);

        // Redirect
        String target = null;
        if (next != null && !next.isBlank()) {
            String decoded;
            try {
                decoded = java.net.URLDecoder.decode(next, java.nio.charset.StandardCharsets.UTF_8);
            } catch (IllegalArgumentException ex) {
                decoded = next; // if not encoded, use as-is
            }
            // allow only same-site relative paths
            if (decoded.startsWith("/") && !decoded.startsWith("//")) {
                target = decoded;
            }
        }
        return "redirect:" + (target != null ? target : "/");
    }


    @GetMapping("/register")
    public String showRegister(@RequestParam(value = "next", required = false) String next, ModelMap model) {
        model.addAttribute("next", next);
        return "registration";
    }
    // Register happens here
    // This handles the POST portion
    // It will validate the inputs first, then normalize and validate the email address,
    // It will attempt registration, with error handling incase
    // When successful it will mark the session and redirect with teh "next"
    @PostMapping("/register")
    public String register(@RequestParam String firstName,
                           @RequestParam String lastName,
                           @RequestParam String emailAddress,
                           @RequestParam String phoneNumber,
                           @RequestParam String password,
                           @RequestParam(value = "next", required = false) String next,
                           @ModelAttribute("auth") AuthSession auth,
                           HttpSession session,
                           RedirectAttributes ra) {
        // Validate the inputs
        if (firstName == null || firstName.isBlank() ||
                lastName == null || lastName.isBlank() ||
                emailAddress == null || emailAddress.isBlank() ||
                phoneNumber == null || phoneNumber.isBlank() ||
                password == null || password.isBlank()) {
            ra.addFlashAttribute("errorMessage", "All fields are required."); // make sure that all fields are filled out
            if (next != null && !next.isBlank()) {
                ra.addFlashAttribute("next", next);
            }
            return "redirect:/auth/register";
        }

        String emailNorm = emailAddress.trim().toLowerCase();
        if (!EMAIL_RX.matcher(emailNorm).matches()) {
            ra.addFlashAttribute("errorMessage", "Please enter a valid email address.");
            if (next != null && !next.isBlank()) {
                ra.addFlashAttribute("next", next);
            }
            return "redirect:/auth/register";
        }

        try {
            Integer guestId = registrationHash.register(firstName, lastName, emailNorm, phoneNumber, password);
            auth.setAuthenticated(true);
            auth.setEmail(emailNorm);
            auth.setGuestId(guestId);
            session.setAttribute("guestId", guestId);

            return (next != null && !next.isBlank() && next.startsWith("/"))
                    ? "redirect:" + next
                    : "redirect:/";
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("errorMessage", e.getMessage()); // error message to show "Email already in use"
            if (next != null && !next.isBlank()) {
                ra.addFlashAttribute("next", next);
            }
            return "redirect:/auth/register";
        } catch (Exception e) {
            ra.addFlashAttribute("errorMessage", "Registration failed. Please try again later.");
            if (next != null && !next.isBlank()) {
                ra.addFlashAttribute("next", next);
            }
            return "redirect:/auth/register";
        }
    }
        // Logout of the session upon clicking the logout button
    // Clear the session attributes if there is any and invalidate the HTTPSession
    // Next redirect to home
    @RequestMapping(value = "/logout", method = {RequestMethod.GET, RequestMethod.POST})
    public String logout(HttpSession session, SessionStatus status) {
        status.setComplete();
        if (session != null) {
            session.removeAttribute("auth");
            session.invalidate();
        }
        return "redirect:/";
    }
}