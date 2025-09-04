package com.example.moffatbaylodge.accessingdatamysql;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.*;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "guests")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // good for MySQL
    @Column(name = "GuestID")
    private Long id; // use Long if GuestID is BIGINT

    @Column(name = "FirstName", nullable = false, length = 100)
    private String firstName;

    @Column(name = "LastName", nullable = false, length = 100)
    private String lastName;

    @Column(name = "PhoneNumber", length = 20)
    private String phoneNumber;

    @Column(name = "EmailAddress", nullable = false, unique = true, length = 255)
    private String emailAddress;

    @Column(name = "Password", nullable = false, length = 255)
    private String password;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getEmailAddress() { return emailAddress; }
    public void setEmailAddress(String emailAddress) { this.emailAddress = emailAddress; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}