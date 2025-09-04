package com.example.moffatbaylodge.web;

public class RegisterDTO {

    private String firstName;
    private String lastName;
    private String email;
    private Integer phoneNumber;
    private String password;

 //   @NotNull
   // @NotEmpty
    private String FirstName;

   // @NotNull
   // @NotEmpty
    private String LastName;

   // @NotNull
   // @NotEmpty
    private String EmailAddress;

   // @NotNull
   // @NotEmpty
    private Integer PhoneNumber;

   // @NotNull
   // @NotEmpty
    private String Password;
    private String matchingPassword;

    @Override
    public String toString() {
        return"RegisterDTO [firstName=" + firstName + ", lastName=" + lastName + ", email=" + email + ", phoneNumber=" + phoneNumber + ", password=" + password +"]";
    }
    // standard getters and setters
}