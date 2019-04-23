package com.adstream.automate.babylon.JsonObjects;

/**
 * User: ruslan.semerenko
 * Date: 27.07.12 11:35
 */
public class Acl {
    private String objectId;
    private String subjectId;
    private boolean inheritance;
    private Long expiration;

    public Acl() {}

    public Acl(String objectId, String subjectId, boolean inheritance, Long expiration) {
        this.objectId = objectId;
        this.subjectId = subjectId;
        this.inheritance = inheritance;
        this.expiration = expiration;
    }

    public String getObjectId() {
        return objectId;
    }

    public void setObjectId(String objectId) {
        this.objectId = objectId;
    }

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }

    public boolean isInheritance() {
        return inheritance;
    }

    public void setInheritance(boolean inheritance) {
        this.inheritance = inheritance;
    }

    public Long getExpiration() {
        return expiration;
    }

    public void setExpiration(Long expiration) {
        this.expiration = expiration;
    }
}
