package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.accessingdatamysql.Reservation;
import com.example.moffatbaylodge.accessingdatamysql.RoomSize;
import com.example.moffatbaylodge.accessingdatamysql.RoomSizeRepository;
import com.example.moffatbaylodge.services.ReservationServices;
import com.example.moffatbaylodge.session.AuthSession;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import java.time.format.DateTimeFormatter;
import java.time.LocalDate;
import java.util.List;
import java.time.ZoneId;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

// test to send to github

@Controller
public class ReservationController {

    private final ReservationServices reservationServices;
    private final RoomSizeRepository roomRepo;

    private static final DateTimeFormatter DATE_FMT = // Formating the date so it shows properly
            DateTimeFormatter.ofPattern("MMM d, yyyy");

    public ReservationController(ReservationServices reservationServices, RoomSizeRepository roomRepo) {
        this.reservationServices = reservationServices;
        this.roomRepo = roomRepo;
    }

    @GetMapping("/reservation")
    public String reservation(@ModelAttribute("auth") AuthSession auth,
                              HttpSession session,
                              ModelMap model) {
        if (auth == null || auth.getGuestId() == null) {
            AuthSession sessionAuth = (AuthSession) session.getAttribute("auth");
            if (sessionAuth != null) {
                auth = sessionAuth;
                model.addAttribute("auth", auth);
            }
        }

        String gate = GuardedPages.require(auth, "/reservation");
        if (gate != null) return gate;

        List<RoomSize> roomSizes = roomRepo.findAll();
        model.addAttribute("roomSizes", roomSizes);
        return "reservation"; // /WEB-INF/jsp/reservation.jsp
    }

    // User submits the form, build the pending reservation as a preview, then redirect to confirm
    @PostMapping("/reservation/preview")
    public String preview(@ModelAttribute("auth") AuthSession auth,
                          @RequestParam("roomId") Integer roomId,
                          @RequestParam("guests") Integer guests,
                          @RequestParam("checkin") String checkin,
                          @RequestParam("checkout") String checkout,
                          ModelMap model,
                          HttpSession session,
                          RedirectAttributes ra) {   // ← add RA here

        String gate = GuardedPages.require(auth, "/reservation");
        if (gate != null) return gate;

        try {
            LocalDate in  = LocalDate.parse(checkin);
            LocalDate out = LocalDate.parse(checkout);

            // Throw IllegalArgumentException
            Reservation pending = reservationServices.createReservation(roomId, guests, in, out);
            session.setAttribute("pendingReservation", pending);

            return "redirect:/reservation/confirm";

        } catch (IllegalArgumentException ex) {
            // Flash error and repopulate the form
            ra.addFlashAttribute("errorMessage", ex.getMessage());
            ra.addFlashAttribute("prefillRoomId", roomId);
            ra.addFlashAttribute("prefillGuests", guests);
            ra.addFlashAttribute("prefillCheckIn", checkin);
            ra.addFlashAttribute("prefillCheckOut", checkout);
            return "redirect:/reservation";
        }
    }

    // Show the confirmation/summary page from session
    @GetMapping("/reservation/confirm")
    public String confirm(@ModelAttribute("auth") AuthSession auth,
                          HttpSession session,
                          ModelMap model) {

        String gate = GuardedPages.require(auth, "/reservation/confirm");
        if (gate != null) return gate;

        Reservation pending = (Reservation) session.getAttribute("pendingReservation");
        if (pending == null) return "redirect:/reservation?error=expired";

        if (pending.getRoom() != null) {
            pending.getRoom().getRoomSize();
        }

        long nights = java.time.temporal.ChronoUnit.DAYS
                .between(pending.getCheckinDate(), pending.getCheckoutDate());

        ZoneId tz = ZoneId.of("America/Chicago"); // timezone set up

        model.addAttribute("reservation", pending);
        model.addAttribute("nights", nights);
        model.addAttribute("roomSize", pending.getRoom() != null ? pending.getRoom().getRoomSize() : null);
        model.addAttribute("guests", pending.getNumberOfGuests());
        // fixed the date format to show month, day and then year
        model.addAttribute("checkIn",  DATE_FMT.format(pending.getCheckinDate()));
        model.addAttribute("checkOut", DATE_FMT.format(pending.getCheckoutDate()));
        model.addAttribute("total", pending.getTotalPrice());

        model.addAttribute("showActions", true);
        return "reservation-summary";

    }

    // user clicks Confirm "submit" go to saved summary
    @PostMapping("/reservation/confirm")
    public String submitConfirm(@ModelAttribute("auth") AuthSession auth,
                                HttpSession session,
                                RedirectAttributes ra) {

        String gate = GuardedPages.require(auth, "/reservation/confirm");
        if (gate != null) return gate;

        Integer gid = auth.getGuestId();
        if (gid == null) return "redirect:/auth/login?next=/reservation";

        Reservation pending = (Reservation) session.getAttribute("pendingReservation");
        if (pending == null) {
            ra.addFlashAttribute("errorMessage", "Your reservation preview expired. Please start again.");
            return "redirect:/reservation";
        }

        pending.setGuestID(gid);
        Reservation saved = reservationServices.confirmReservation(pending); // persist
        session.removeAttribute("pendingReservation");

        int id = saved.getReservationID();

        // flash message to let user know it saved
        ra.addFlashAttribute("successMessage",
                "Reservation #" + saved.getReservationID() + " saved successfully!");

        return "redirect:/reservation/" + id + "/summary";


    }

    // FYI - Final saved summary by ID because ID cannot be shown until after submit!!
    @GetMapping("/reservation/{id}/summary")
    public String savedSummary(@ModelAttribute("auth") AuthSession auth,
                               @PathVariable Integer id,
                               ModelMap model) {

        String gate = GuardedPages.require(auth, "/reservation/" + id + "/summary");
        if (gate != null) return gate;

        Reservation reservation = reservationServices.findById(id);
        if (reservation == null) {
            return "redirect:/reservation?error=notfound";
        }

        if (reservation.getRoom() != null) {
            reservation.getRoom().getRoomSize();
        }

        long nights = java.time.temporal.ChronoUnit.DAYS
                .between(reservation.getCheckinDate(), reservation.getCheckoutDate());
        // fixed date format to show date in proper order of month, day adn then year
        model.addAttribute("checkIn",  DATE_FMT.format(reservation.getCheckinDate()));
        model.addAttribute("checkOut", DATE_FMT.format(reservation.getCheckoutDate()));
        model.addAttribute("reservation", reservation);
        model.addAttribute("nights", nights);
        model.addAttribute("showActions", false); // hide buttons on final summary
        return "reservation-summary";
    }

    // cancel button
    @PostMapping("/reservation/cancel")
    public String cancel(HttpSession session, RedirectAttributes ra) {
        session.removeAttribute("pendingReservation");
        // flash a message incase error happens
        ra.addFlashAttribute("successMessage", "Reservation draft discarded.");
        return "redirect:/reservation";
    }
}
