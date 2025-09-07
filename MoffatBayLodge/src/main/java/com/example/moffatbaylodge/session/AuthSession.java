package com.example.moffatbaylodge.session;

import java.io.Serializable;

public class AuthSession implements Serializable {
    private boolean authenticated;
    private String email;
    private Integer guestId;

    public boolean isAuthenticated() { return authenticated; }
    public void setAuthenticated(boolean a) { this.authenticated = a; }

    public String getEmail() { return email; }
    public void setEmail(String e) { this.email = e; }

    // Not set but will use for reservations to attach
    public Integer getGuestId() { return guestId; }
    public void setGuestId(Integer id) { this.guestId = id; }
}