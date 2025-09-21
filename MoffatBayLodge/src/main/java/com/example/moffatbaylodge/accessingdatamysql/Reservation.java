package com.example.moffatbaylodge.accessingdatamysql;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "Reservation")
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ReservationID")
    private Integer reservationID;

    @Column(name = "GuestID")
    private Integer guestID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "RoomID")
    private RoomSize room;

    @Column(name = "NumberOfGuests", nullable = false)
    private Integer numberOfGuests;

    @Column(name = "CheckinDate", nullable = false)
    private LocalDate checkinDate;

    @Column(name = "CheckoutDate", nullable = false)
    private LocalDate checkoutDate;

    @Column(name = "TotalPrice", nullable = false)
    private BigDecimal totalPrice;

    // --- Transient fields for formatted dates ---
    @Transient
    private String checkinFormatted;

    @Transient
    private String checkoutFormatted;

    // --- Getters & Setters ---
    public Integer getReservationID() { return reservationID; }
    public void setReservationID(Integer reservationID) { this.reservationID = reservationID; }

    public Integer getGuestID() { return guestID; }
    public void setGuestID(Integer guestID) { this.guestID = guestID; }

    public RoomSize getRoom() { return room; }
    public void setRoom(RoomSize room) { this.room = room; }

    public Integer getNumberOfGuests() { return numberOfGuests; }
    public void setNumberOfGuests(Integer numberOfGuests) { this.numberOfGuests = numberOfGuests; }

    public LocalDate getCheckinDate() { return checkinDate; }
    public void setCheckinDate(LocalDate checkinDate) {
        this.checkinDate = checkinDate;
        updateCheckinFormatted();
    }

    public LocalDate getCheckoutDate() { return checkoutDate; }
    public void setCheckoutDate(LocalDate checkoutDate) {
        this.checkoutDate = checkoutDate;
        updateCheckoutFormatted();
    }

    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }

    public String getCheckinFormatted() { return checkinFormatted; }
    public void setCheckinFormatted(String checkinFormatted) { this.checkinFormatted = checkinFormatted; }

    public String getCheckoutFormatted() { return checkoutFormatted; }
    public void setCheckoutFormatted(String checkoutFormatted) { this.checkoutFormatted = checkoutFormatted; }

    // --- Helper methods to auto-format dates ---
    private void updateCheckinFormatted() {
        if (this.checkinDate != null) {
            this.checkinFormatted = this.checkinDate.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
        } else {
            this.checkinFormatted = "";
        }
    }

    private void updateCheckoutFormatted() {
        if (this.checkoutDate != null) {
            this.checkoutFormatted = this.checkoutDate.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
        } else {
            this.checkoutFormatted = "";
        }
    }
}
