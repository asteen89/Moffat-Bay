package com.example.moffatbaylodge.beans;

public class UserBean {
    private String firstName;
    private String lastName;
    private String phone;
    private String email;
    private String password;

    public UserBean() {}

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public boolean  isValid() {
        return !(firstName == null || firstName.isBlank() ||
                lastName == null || lastName.isBlank() ||
                email == null || email.isBlank() ||
                phone == null || phone.isBlank() ||
                password == null || password.isBlank());
    }
}
