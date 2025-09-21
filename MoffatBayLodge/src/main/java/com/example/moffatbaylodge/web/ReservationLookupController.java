package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.accessingdatamysql.Reservation;
import com.example.moffatbaylodge.accessingdatamysql.ReservationRepository;
import com.example.moffatbaylodge.accessingdatamysql.User;
import com.example.moffatbaylodge.accessingdatamysql.UserRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class ReservationLookupController {

    private final ReservationRepository reservationRepo;
    private final UserRepository userRepo;

    public ReservationLookupController(ReservationRepository reservationRepo, UserRepository userRepo) {
        this.reservationRepo = reservationRepo;
        this.userRepo = userRepo;
    }

    // ================= Lookup Reservation =================
    @GetMapping("/reservations/lookup")
    public String lookupReservation(
            @RequestParam(value = "confirmation", required = false) Integer confirmationId,
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "success", required = false) String successMessage,
            @RequestParam(value = "error", required = false) String errorMessage,
            Model model
    ) {
        boolean searched = false;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");

        if (confirmationId != null) {
            searched = true;
            Reservation found = reservationRepo.findById(confirmationId).orElse(null);
            if (found != null) {
                found.setCheckinFormatted(found.getCheckinDate() != null ? found.getCheckinDate().format(formatter) : null);
                found.setCheckoutFormatted(found.getCheckoutDate() != null ? found.getCheckoutDate().format(formatter) : null);
                model.addAttribute("reservation", found);
            }
        } else if (email != null && !email.isBlank()) {
            searched = true;
            Optional<User> guest = userRepo.findByEmailAddressIgnoreCase(email);
            if (guest.isPresent()) {
                List<Reservation> reservations = reservationRepo.findAll()
                        .stream()
                        .filter(r -> guest.get().getId().equals(r.getGuestID()))
                        .collect(Collectors.toList());

                reservations.forEach(r -> {
                    r.setCheckinFormatted(r.getCheckinDate() != null ? r.getCheckinDate().format(formatter) : null);
                    r.setCheckoutFormatted(r.getCheckoutDate() != null ? r.getCheckoutDate().format(formatter) : null);
                });

                model.addAttribute("reservations", reservations);
            }
        }

        model.addAttribute("searchPerformed", searched);

        if (successMessage != null) model.addAttribute("success", successMessage);
        if (errorMessage != null) model.addAttribute("error", errorMessage);

        return "reservation-lookup";
    }

    // ================= Show Modify Reservation Form =================
    @GetMapping("/reservations/manage")
    public String manageReservation(
            @RequestParam("conf") Integer reservationId,
            Model model
    ) {
        Optional<Reservation> reservationOpt = reservationRepo.findById(reservationId);
        if (reservationOpt.isEmpty()) {
            model.addAttribute("error", "Reservation not found.");
            return "reservation-lookup";
        }

        Reservation reservation = reservationOpt.get();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        reservation.setCheckinFormatted(reservation.getCheckinDate() != null ? reservation.getCheckinDate().format(formatter) : "");
        reservation.setCheckoutFormatted(reservation.getCheckoutDate() != null ? reservation.getCheckoutDate().format(formatter) : "");

        model.addAttribute("reservation", reservation);
        return "reservation-manage";
    }

    // ================= Update Reservation POST =================
    @PostMapping("/reservations/manage")
    public String updateReservation(
            @RequestParam("reservationId") Integer reservationId,
            @RequestParam("checkinDate") String checkinDate,
            @RequestParam("checkoutDate") String checkoutDate,
            @RequestParam("numberOfGuests") Integer guests,
            Model model
    ) {
        Optional<Reservation> reservationOpt = reservationRepo.findById(reservationId);
        if (reservationOpt.isEmpty()) {
            model.addAttribute("error", "Reservation not found.");
            return "reservation-lookup";
        }

        Reservation reservation = reservationOpt.get();
        reservation.setCheckinDate(LocalDate.parse(checkinDate));
        reservation.setCheckoutDate(LocalDate.parse(checkoutDate));
        reservation.setNumberOfGuests(guests);
        reservationRepo.save(reservation);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        reservation.setCheckinFormatted(reservation.getCheckinDate().format(formatter));
        reservation.setCheckoutFormatted(reservation.getCheckoutDate().format(formatter));

        model.addAttribute("reservation", reservation);
        model.addAttribute("success", "Reservation updated successfully!");
        return "reservation-manage";
    }

    // ================= Cancel Reservation =================
    @GetMapping("/reservations/cancel")
    public String cancelReservation(
            @RequestParam("conf") Integer reservationId
    ) {
        Optional<Reservation> reservationOpt = reservationRepo.findById(reservationId);
        if (reservationOpt.isEmpty()) {
            return "redirect:/reservations/lookup?error=Reservation+not+found";
        }

        reservationRepo.deleteById(reservationId);
        return "redirect:/reservations/lookup?success=Reservation+cancelled+successfully";
    }
}
