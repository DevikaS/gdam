package com.adstream.automate.babylon.JsonObjects;

/**
 * User: ruslan.semerenko
 * Date: 02.07.12 9:18
 */
public class TeamPermission {
    private String fsObjectId;
    private String user;
    private String newRole;
    private String oldRole;
    private Boolean inheritance;
    private Long expiration;

    // used to add user to project team
    public TeamPermission(String fsObjectId, String emailOrUserId, String newRole, Boolean inheritance, Long expiration) {
        this.fsObjectId = fsObjectId;
        this.user = emailOrUserId;
        this.newRole = newRole;
        this.inheritance = inheritance;
        this.expiration = expiration;
    }

    // used to remove user from project team
    public TeamPermission(String fsObjectId, String emailOrUserId, String oldRole) {
        this.fsObjectId = fsObjectId;
        this.user = emailOrUserId;
        this.oldRole = oldRole;
    }

    public String getFsObjectId() {
        return fsObjectId;
    }

    public void setFsObjectId(String fsObjectId) {
        this.fsObjectId = fsObjectId;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String emailOrUserId) {
        this.user = emailOrUserId;
    }

    public String getNewRole() {
        return newRole;
    }

    public void setNewRole(String newRole) {
        this.newRole = newRole;
    }

    public String getOldRole() {
        return oldRole;
    }

    public void setOldRole(String oldRole) {
        this.oldRole = oldRole;
    }

    public Boolean getInheritance() {
        return inheritance;
    }

    public void setInheritance(Boolean inheritance) {
        this.inheritance = inheritance;
    }

    public Long getExpiration() {
        return expiration;
    }

    public void setExpiration(Long expiration) {
        this.expiration = expiration;
    }
}
