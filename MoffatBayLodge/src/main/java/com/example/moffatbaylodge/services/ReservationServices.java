package com.example.moffatbaylodge.services;

import com.example.moffatbaylodge.accessingdatamysql.Reservation;
import com.example.moffatbaylodge.accessingdatamysql.ReservationRepository;
import com.example.moffatbaylodge.accessingdatamysql.RoomSize;
import com.example.moffatbaylodge.accessingdatamysql.RoomSizeRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
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

    @Transactional
    public Reservation createReservation(Integer roomId, Integer guests, LocalDate checkIn, LocalDate checkOut) {
        RoomSize room = roomRepo.findById(roomId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid room ID: " + roomId));

        long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
        if (nights <= 0) throw new IllegalArgumentException("Check-out must be after check-in.");

        BigDecimal total = room.getRoomPrice().multiply(BigDecimal.valueOf(nights));

        Reservation r = new Reservation();
        r.setRoom(room);
        r.setNumberOfGuests(guests);
        r.setCheckinDate(checkIn);
        r.setCheckoutDate(checkOut);
        r.setTotalPrice(total);

        return reservationRepo.save(r);
    }
}

