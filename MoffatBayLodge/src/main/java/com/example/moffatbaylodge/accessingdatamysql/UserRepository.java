package com.example.moffatbaylodge.accessingdatamysql;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByEmailAddressIgnoreCase(String emailAddress);
}