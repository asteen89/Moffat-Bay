package com.example.moffatbaylodge.services;

import com.example.moffatbaylodge.accessingdatamysql.Reservation;
import com.example.moffatbaylodge.accessingdatamysql.ReservationRepository;
import com.example.moffatbaylodge.accessingdatamysql.RoomSize;
import com.example.moffatbaylodge.accessingdatamysql.RoomSizeRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@Service
public class ReservationServices {

    private final ReservationRepository reservationRepo;
    private final RoomSizeRepository roomRepo;

    public ReservationServices(ReservationRepository reservationRepo, RoomSizeRepository roomRepo) {
        this.reservationRepo = reservationRepo;
        this.roomRepo = roomRepo;
    }

    public Reservation findById(Integer id) {
        return reservationRepo.findById(id).orElse(null); // or throw if you prefer
    }

    @Transactional
    public Reservation createReservation(Integer roomId, Integer guests, LocalDate checkIn, LocalDate checkOut) {
        if (roomId == null) {
            throw new IllegalArgumentException("Please choose a room.");
        }
        if (checkIn == null || checkOut == null) {
            throw new IllegalArgumentException("Dates are required.");
        }
        // ✅ clearer than checking DAYS <= 0
        if (!checkOut.isAfter(checkIn)) {
            throw new IllegalArgumentException("Check-out must be after check-in.");
        }
        if (guests == null || guests < 1) {
            throw new IllegalArgumentException("Guests must be at least 1.");
        }

        RoomSize room = roomRepo.findById(roomId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid room ID: " + roomId));

        long nights = ChronoUnit.DAYS.between(checkIn, checkOut);

        BigDecimal nightly = room.getRoomPrice(); // assume BigDecimal
        if (nightly == null) {
            throw new IllegalArgumentException("Selected room is missing a nightly price.");
        }
        BigDecimal total = nightly.multiply(BigDecimal.valueOf(nights)).setScale(2, RoundingMode.HALF_UP);

        Reservation r = new Reservation();
        r.setRoom(room);
        r.setNumberOfGuests(guests);
        r.setCheckinDate(checkIn);
        r.setCheckoutDate(checkOut);
        r.setTotalPrice(total);

        return r;
    }

    @Transactional
    public Reservation confirmReservation(Reservation reservation) {
        return reservationRepo.saveAndFlush(reservation); // ensures ID is generated
    }

}

