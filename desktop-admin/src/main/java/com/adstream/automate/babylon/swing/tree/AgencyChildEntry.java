package com.adstream.automate.babylon.swing.tree;

/**
 * User: ruslan.semerenko
 * Date: 24.11.12 20:52
 */
public class AgencyChildEntry {
    public static enum Type {
        USERS("Users"),
        ASSETS("Assets"),
        ROLES("Roles");

        private String type;

        private Type(String type) {
            this.type = type;
        }

        public String toString() {
            return type;
        }
    }

    private Type type;
    private String value;
    private String parentId;
    private boolean loaded = false;

    public AgencyChildEntry(Type type, String value, String parentId) {
        this.type = type;
        this.value = value.isEmpty() ? type.toString() : value;
        this.parentId = parentId;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public boolean isLoaded() {
        return loaded;
    }

    public void setLoaded(boolean loaded) {
        this.loaded = loaded;
    }

    public String toString() {
        return value;
    }
}
