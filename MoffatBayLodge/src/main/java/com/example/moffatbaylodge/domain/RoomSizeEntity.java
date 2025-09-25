package com.example.moffatbaylodge.domain;

import jakarta.persistence.*;
import java.math.BigDecimal;

// JPA entity mapped to the RoomSize table.
@Entity @Table(name = "RoomSize")
public class RoomSizeEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) // primary key, auto increment by the database
    @Column(name = "RoomID")
    private Integer roomId;

    @Column(name = "RoomSize", nullable = false, length = 50) // map roomSize to RoomSize
    private String roomSize;

    @Column(name = "RoomPrice", nullable = false, precision = 10, scale = 2) // map to a decimal
    private BigDecimal roomPrice;

    @Column(name = "Quantity", nullable = false) // integer for how many rooms of that size are availble
    private Integer quantity;

    // getters/setters
    public Integer getRoomId() { return roomId; }
    public String getRoomSize() { return roomSize; }
    public BigDecimal getRoomPrice() { return roomPrice; }
    public Integer getQuantity() { return quantity; }
    public void setRoomId(Integer v){this.roomId=v;}
    public void setRoomSize(String v){this.roomSize=v;}
    public void setRoomPrice(BigDecimal v){this.roomPrice=v;}
    public void setQuantity(Integer v){this.quantity=v;}
}
