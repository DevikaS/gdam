package com.adstream.automate.babylon.logplayer;

import java.util.*;

/**
 * User: ruslan.semerenko
 * Date: 23.10.13 14:10
 */
public class MessageTree {
    private Message message;
    private Map<String, Integer> users = new HashMap<String, Integer>();
    private Map<String, List<Long>> userTimes = new HashMap<String, List<Long>>();
    private Map<MessageTree, Integer> branches;

    public MessageTree() {}

    public MessageTree(Message message) {
        this.message = message;
    }

    public Message getMessage() {
        return message;
    }

    public void setMessage(Message message) {
        this.message = message;
    }

    public void addUser(String userId) {
        Integer count = users.get(userId);
        if (count == null) {
            users.put(userId, 1);
        } else {
            users.put(userId, count + 1);
        }
    }

    public Map<String, Integer> getUsers() {
        return users;
    }

    public void addUserTime(String userId, long time) {
        List<Long> times = userTimes.get(userId);
        if (times == null) {
            userTimes.put(userId, new ArrayList<Long>(Arrays.asList(time)));
        } else {
            times.add(time);
        }
    }

    public Map<String, List<Long>> getUserTimes() {
        return userTimes;
    }

    public MessageTree addBranch(Message message, long time) {
        MessageTree tree = getTreeForMessage(message);
        int count = 0;
        if (tree == null) {
            tree = new MessageTree(message);
        } else {
            count = getBranches().get(tree);
        }
        tree.addUser(message.getUserId());
        tree.addUserTime(message.getUserId(), time);
        getBranches().put(tree, count + 1);
        return tree;
    }

    public Map<MessageTree, Integer> getBranches() {
        if (branches == null) {
            branches = new HashMap<MessageTree, Integer>();
        }
        return branches;
    }

    private MessageTree getTreeForMessage(Message message) {
        for (Map.Entry<MessageTree, Integer> entry : getBranches().entrySet()) {
            if (entry.getKey().getMessage().getType() == message.getType()) {
                return entry.getKey();
            }
        }
        return null;
    }

    @Override
    public String toString() {
        if (message == null) {
            return super.toString();
        }
        return message.toString();
    }
}
