package com.adstream.automate.babylon.logplayer;

import com.adstream.automate.utils.IO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 23.10.13 11:43
 */
class Analyzer {
    private MessagesList messages;

    Analyzer(MessagesList messages) {
        this.messages = messages;
    }

    public void analyze() {
        Map<String, List<Session>> sessionsMap = getSessionsMap();
        MessageTree tree = new MessageTree();
        for (Map.Entry<String, List<Session>> entry : sessionsMap.entrySet()) {
            for (Session session : entry.getValue()) {
                MessageTree branch = tree;
                Message previousMessage = null;
                for (Message message : session.getMessages()) {
                    if (message.getType() == MessageType.CURRENT_USER
                            || message.getType() == MessageType.CURRENT_AGENCY
                            || message.getType() == MessageType.GROUP_HEAD) {
                        continue;
                    }
                    long time = 0;
                    if (previousMessage != null) {
                        time = message.getDateTime().getMillis() - previousMessage.getDateTime().getMillis();
                    }
                    branch = branch.addBranch(message, time);
                    previousMessage = message;
                }
            }
        }
//        new Saver(tree).saveJson(new File("c:\\Work\\log.json"));
        new Saver(tree).saveSQLite(new File("C:\\Work\\test.db"));
    }

    public Map<String, List<Session>> getSessionsMap() {
        Map<String, List<Session>> sessionsMap = new HashMap<>();
        Map<String, Session> currentSessionsMap = new HashMap<>();
        boolean auth = false;
        for (Message message : messages) {
            if (message.getType() == MessageType.AUTH) {
                auth = true;
            } else if (message.getType() == MessageType.CURRENT_USER && auth) {
                auth = false;
                Session session = currentSessionsMap.get(message.getUserId());
                if (session != null) {
                    List<Session> sessions = sessionsMap.get(message.getUserId());
                    if (sessions == null) {
                        sessions = new ArrayList<>();
                        sessionsMap.put(message.getUserId(), sessions);
                    }
                    sessions.add(session);
                }
                session = new Session();
                session.setUserId(message.getUserId());
                session.getMessages().add(message);
                currentSessionsMap.put(message.getUserId(), session);
            } else if (currentSessionsMap.containsKey(message.getUserId())) {
                auth = false;
                currentSessionsMap.get(message.getUserId()).getMessages().add(message);
            }
        }
        for (Map.Entry<String, Session> currentSession : currentSessionsMap.entrySet()) {
            List<Session> sessions = sessionsMap.get(currentSession.getKey());
            if (sessions == null) {
                sessions = new ArrayList<>();
                sessionsMap.put(currentSession.getKey(), sessions);
            }
            sessions.add(currentSession.getValue());
        }
        return sessionsMap;
    }
}
