package com.publicApi.jsonPayLoads.GsonClasses;

public class Users {
    private String email;

    private String user;

    private Roles[] roles;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public void setRoles(Roles[] roles) {
        this.roles = roles;
    }

    public Roles[] getRoles() {
        return roles;
    }
}