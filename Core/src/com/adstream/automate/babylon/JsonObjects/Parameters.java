package com.adstream.automate.babylon.JsonObjects;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 10.09.12
 * Time: 14:11
 */
public class Parameters {
    private boolean hasRead;
    private String[] notifiedUsers;
    private String sharedType;
    private String personalMessage;
    private User[] sharedTo;
    private Project[] projects;

    public boolean isHasRead() {
        return hasRead;
    }

    public void setHasRead(boolean hasRead) {
        this.hasRead = hasRead;
    }

    public String[] getNotifiedUsers() {
        return notifiedUsers;
    }

    public void setNotifiedUsers(String[] notifiedUsers) {
        this.notifiedUsers = notifiedUsers;
    }

    public String getSharedType() {
        return sharedType;
    }

    public void setSharedType(String sharedType) {
        this.sharedType = sharedType;
    }

    public String getPersonalMessage() {
        return personalMessage;
    }

    public void setPersonalMessage(String personalMessage) {
        this.personalMessage = personalMessage;
    }

    public User[] getSharedTo() {
        return sharedTo;
    }

    public void setSharedTo(User[] sharedTo) {
        this.sharedTo = sharedTo;
    }

    public Project[] getProjects() {
        return projects;
    }

    public void setProjects(Project[] projects) {
        this.projects = projects;
    }

    //there is object User that has field agency with type String in object Parameters, thus create a new class User below with type of field agency String
    public static class User extends BaseObject {

        public User() {}

        private String email;

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }
    }
}