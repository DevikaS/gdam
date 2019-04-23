package com.adstream.automate.babylon.swing;

import java.net.URL;

/**
 * User: ruslan.semerenko
 * Date: 27.11.12 12:42
 */
public class Environment {
    private String name;
    private URL address;
    private String login;
    private String password;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public URL getAddress() {
        return address;
    }

    public void setAddress(URL address) {
        this.address = address;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String toString() {
        return name;
    }
}
