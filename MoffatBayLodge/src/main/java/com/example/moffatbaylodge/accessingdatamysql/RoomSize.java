package com.example.moffatbaylodge.accessingdatamysql;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "RoomSize")
public class RoomSize {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RoomID")
    private Integer roomId;

    @Column(name = "RoomSize", nullable = false, length = 50)
    private String roomSize;

    @Column(name = "RoomPrice", nullable = false, precision = 10, scale = 2)
    private BigDecimal roomPrice;

    @Column(name = "Quantity", nullable = false)
    private Integer quantity;

    // no-args constructor
    public RoomSize() {}

    // Getters/setters
    public Integer getRoomId() { return roomId; }
    public void setRoomId(Integer roomId) { this.roomId = roomId; }

    public String getRoomSize() { return roomSize; }
    public void setRoomSize(String roomSize) { this.roomSize = roomSize; }

    public BigDecimal getRoomPrice() { return roomPrice; }
    public void setRoomPrice(BigDecimal roomPrice) { this.roomPrice = roomPrice; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
}
