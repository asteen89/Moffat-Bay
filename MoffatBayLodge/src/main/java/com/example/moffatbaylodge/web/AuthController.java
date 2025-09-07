// src/main/java/com/example/moffatbaylodge/web/AuthController.java
package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.authentication.PassService;
import com.example.moffatbaylodge.authentication.RegistrationHash;
import com.example.moffatbaylodge.session.AuthSession;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
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
    public AuthSession authSession() {
        return new AuthSession();
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
                        @ModelAttribute("auth") AuthSession auth, // <— get the session-backed POJO
                        HttpSession session,
                        RedirectAttributes ra) {

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
                           RedirectAttributes ra) {

        String emailNorm = (emailAddress == null) ? null : emailAddress.trim().toLowerCase();
        if (emailNorm == null || !EMAIL_RX.matcher(emailNorm).matches()) {
            // error message incase user does not enter a valid email using redirect attribute
            ra.addFlashAttribute("errorMessage", "Please enter a valid email address.");
            return "redirect:/auth/register";
        }
        registrationHash.register(firstName, lastName, emailNorm, phoneNumber, password);
        return "redirect:/auth/login?registered";
    }

    // LOGOUT (both GET and POST) logout button not created yet but will be done
    @PostMapping("/logout")
    public String logoutPost(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/auth/login";
    }

    @GetMapping("/logout")
    public String logoutGet(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/auth/login";
    }
}
