package com.example.moffatbaylodge.accessingdatamysql;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface RoomSizeRepository extends JpaRepository<RoomSize, Integer> {
    Optional<RoomSize> findByRoomSizeIgnoreCase(String roomSize);
}

