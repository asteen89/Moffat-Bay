package com.example.moffatbaylodge.accessingdatamysql;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "RoomSize")
public class RoomSize {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RoomID")
    private Integer roomID;

    @Column(name = "RoomSize", nullable = false)
    private String roomSize;

    @Column(name = "RoomPrice", nullable = false)
    private BigDecimal roomPrice;

    @Column(name = "Quantity")
    private Integer quantity;

    // getters & setters
    public Integer getRoomID() { return roomID; }
    public void setRoomID(Integer roomID) { this.roomID = roomID; }

    public String getRoomSize() { return roomSize; }
    public void setRoomSize(String roomSize) { this.roomSize = roomSize; }

    public BigDecimal getRoomPrice() { return roomPrice; }
    public void setRoomPrice(BigDecimal roomPrice) { this.roomPrice = roomPrice; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
}

