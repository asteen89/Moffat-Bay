package com.example.moffatbaylodge.accessingdatamysql;

import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface RoomSizeRepository extends JpaRepository<RoomSize, Integer> {

    Optional<RoomSize> findByRoomSizeIgnoreCase(String roomSize);

    // For initial load / no dates:
    @Query("select r from RoomSize r order by r.roomPrice asc")
    List<RoomSize> findAllOrderByPrice();

    // Availability by date range
    @Query(value = """
        SELECT r.RoomID        AS roomId,
               r.RoomSize      AS roomSize,
               r.RoomPrice     AS roomPrice,
               (r.Quantity - COALESCE(COUNT(res.ReservationID),0)) AS available FROM RoomSize r LEFT JOIN Reservation res ON res.RoomID = r.RoomID AND res.CheckinDate < :checkout AND res.CheckoutDate > :checkin
GROUP BY r.RoomID, r.RoomSize, r.RoomPrice, r.Quantity HAVING available > 0 ORDER BY r.RoomPrice ASC
        """, nativeQuery = true)
    List<RoomAvailabilityRow> findAvailableTypes(
            @Param("checkin")  LocalDate checkin,
            @Param("checkout") LocalDate checkout
    );

    // Spring Data projection
    interface RoomAvailabilityRow {
        Integer getRoomId();
        String  getRoomSize();
        java.math.BigDecimal getRoomPrice();
        Integer getAvailable();
    }
}
