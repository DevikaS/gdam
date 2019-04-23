package com.adstream.automate.babylon.swing.tree;

import com.adstream.automate.babylon.JsonObjects.User;

/**
 * User: ruslan.semerenko
 * Date: 25.11.12 13:19
 */
public class UserEntry {
    private User user;

    public UserEntry(User user) {
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String toString() {
        return user.getEmail();
    }
}
