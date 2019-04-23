package com.adstream.automate.babylon.logplayer;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

/**
 * User: ruslan.semerenko
 * Date: 23.10.13 11:43
 */
class MessagesList extends ArrayList<Message> {
    private Set<String> users = new HashSet<String>();

    @Override
    public boolean add(Message message) {
        users.add(message.getUserId());
        return super.add(message);
    }

    public Set<String> getUsers() {
        return users;
    }
}
