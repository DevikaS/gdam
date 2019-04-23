package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.User;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;


public class TestDataContainer {
    private Map<String, Agency> agenciesMap = new ConcurrentHashMap<String, Agency>();
    private Map<String, User> usersMap = new ConcurrentHashMap<String, User>();
    private User currentUser = new User();
    private String sessionId = "";
    private Map<String, String> scenarioValues = new HashMap<String, String>();

    private static List<TestDataContainer> dataSet = new ArrayList<TestDataContainer>();

    public static synchronized TestDataContainer getDataSet(int ind) {
        if (dataSet.size() <= ind){
            dataSet.add(new TestDataContainer());
        }
        return dataSet.get(ind);
    }

    public User getUserByType(String type) {
        return usersMap.get(type);
    }

    public Agency getAgencyByName(String name) {
           return agenciesMap.get(name);
    }

    public Collection<Agency> getAgencies() {
        return agenciesMap.values();
    }

    public Map<String, String> getScenarioValues() {
        return scenarioValues;
    }

    public String getScenarioValue(String key) {
        return scenarioValues.get(key);
    }

    public void addAgency(String name, Agency agency) {
        agenciesMap.put(name, agency);
    }

    public void addUser(String type, User user) {
        usersMap.put(type, user);
    }

    public void addScenarioValue(String key, String value) {
        scenarioValues.put(key, value);
    }

    public void removeScenarioValue(String key) {
        scenarioValues.remove(key);
    }

    public void setCurrentUser(User currentUser) {
        this.currentUser = currentUser == null? new User(): currentUser;
    }

    public User getCurrentUser() {
        return this.currentUser;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public Map<String, Agency> getAgencyMap(){
        return agenciesMap;
    }
}
