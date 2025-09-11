package com.example.moffatbaylodge.web;

import com.example.moffatbaylodge.accessingdatamysql.Reservation;
import com.example.moffatbaylodge.accessingdatamysql.RoomSize;
import com.example.moffatbaylodge.accessingdatamysql.RoomSizeRepository;
import com.example.moffatbaylodge.services.ReservationServices;
import com.example.moffatbaylodge.session.AuthSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Controller
public class ReservationController {

    private final ReservationServices reservationService;
    private final RoomSizeRepository roomRepo;

    public ReservationController(ReservationServices reservationService, RoomSizeRepository roomRepo) {
        this.reservationService = reservationService;
        this.roomRepo = roomRepo;
    }

    @GetMapping("/reservation")
    public String reservation(@ModelAttribute("auth") AuthSession auth, ModelMap model) {
        String gate = GuardedPages.require(auth, "/reservation");
        if (gate != null) return gate;

        // fetch room options for the select in the form
        List<RoomSize> roomSizes = roomRepo.findAll();
        model.addAttribute("roomSizes", roomSizes);

        return "reservation"; // /WEB-INF/jsp/reservation.jsp
    }

    @PostMapping("/reservation")
    public String submit(
            @ModelAttribute("auth") AuthSession auth,
            @RequestParam("roomId") Integer roomId,
            @RequestParam("guests") Integer guests,
            @RequestParam("checkin") String checkin,
            @RequestParam("checkout") String checkout,
            ModelMap model
    ) {
        String gate = GuardedPages.require(auth, "/reservation");
        if (gate != null) return gate;

        LocalDate checkInDate = LocalDate.parse(checkin);
        LocalDate checkOutDate = LocalDate.parse(checkout);

        // create reservation via service (calculates nights & total, and saves)
        Reservation reservation = reservationService.createReservation(roomId, guests, checkInDate, checkOutDate);

        long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);

        // pass data to JSP (both the reservation object and legacy attributes)
        model.addAttribute("reservation", reservation);
        model.addAttribute("reservationId", reservation.getReservationID());
        model.addAttribute("roomSize", reservation.getRoom().getRoomSize());
        model.addAttribute("guests", reservation.getNumberOfGuests());
        model.addAttribute("checkIn", checkInDate.toString());
        model.addAttribute("checkOut", checkOutDate.toString());
        model.addAttribute("nights", nights);
        model.addAttribute("total", reservation.getTotalPrice());

        return "reservation-summary"; // /WEB-INF/jsp/reservation-summary.jsp
    }
}
