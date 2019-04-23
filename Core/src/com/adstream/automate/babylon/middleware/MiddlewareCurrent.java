package com.adstream.automate.babylon.middleware;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.User;

/**
 * User: ruslan.semerenko
 * Date: 16.07.12 17:35
 */
class MiddlewareCurrent {
    private User user;
    private Agency agency;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Agency getAgency() {
        return agency;
    }

    public void setAgency(Agency agency) {
        this.agency = agency;
    }
}
