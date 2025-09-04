package com.example.moffatbaylodge.accessingdatamysql;

import org.springframework.data.repository.CrudRepository;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete

public interface UserRepository extends org.springframework.data.jpa.repository.JpaRepository<User, Long> {

}