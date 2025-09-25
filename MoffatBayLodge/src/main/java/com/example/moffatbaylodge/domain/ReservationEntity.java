package com.example.moffatbaylodge.domain;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

//JPA entity mapped to the "Reservation" table.
//Represents one booking made by a guest for a specific room size
//over a check-in/check-out date range, with a total price.

@Entity @Table(name = "Reservation")
public class ReservationEntity {
    // primary key (map to column "reservationID"
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ReservationID")
    private Integer reservationId;

    // Foreign key
    @Column(name = "GuestID")
    private Integer guestId;

    // Lazy: room details load only when accessed.
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "RoomID", nullable = false)
    private RoomSizeEntity room;

    @Column(name = "NumberOfGuests", nullable = false)
    private Integer numberOfGuests;

    @Column(name = "CheckinDate", nullable = false)
    private LocalDate checkinDate;

    @Column(name = "CheckoutDate", nullable = false)
    private LocalDate checkoutDate;

    @Column(name = "TotalPrice", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalPrice;

    // getters/setters
    public Integer getReservationId(){return reservationId;}
    public Integer getGuestId(){return guestId;}
    public RoomSizeEntity getRoom(){return room;}
    public Integer getNumberOfGuests(){return numberOfGuests;}
    public LocalDate getCheckinDate(){return checkinDate;}
    public LocalDate getCheckoutDate(){return checkoutDate;}
    public BigDecimal getTotalPrice(){return totalPrice;}
    public void setReservationId(Integer v){this.reservationId=v;}
    public void setGuestId(Integer v){this.guestId=v;}
    public void setRoom(RoomSizeEntity v){this.room=v;}
    public void setNumberOfGuests(Integer v){this.numberOfGuests=v;}
    public void setCheckinDate(LocalDate v){this.checkinDate=v;}
    public void setCheckoutDate(LocalDate v){this.checkoutDate=v;}
    public void setTotalPrice(BigDecimal v){this.totalPrice=v;}
}
