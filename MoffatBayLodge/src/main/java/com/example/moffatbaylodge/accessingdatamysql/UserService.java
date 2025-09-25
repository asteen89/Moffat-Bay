package com.example.moffatbaylodge.accessingdatamysql;

import org.springframework.stereotype.Service;

import java.util.Optional;

// This is needed to work with the user entity

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User register(User user) {
        return userRepository.save(user);
    }

    public Optional<User> findByEmail(String emailAddress) {
        return userRepository.findByEmailAddressIgnoreCase(emailAddress);
    }
}
