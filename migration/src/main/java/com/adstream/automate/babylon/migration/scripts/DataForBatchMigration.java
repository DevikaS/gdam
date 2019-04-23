package com.adstream.automate.babylon.migration.scripts;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/10/15
 * Time: 8:45 AM

 */
public class DataForBatchMigration {

    private String a5BuName;
    private String a4BuName;
    private String a4UserEmail;
    private String fakeUserEmail;
    private String fakeUserPassword;


    public DataForBatchMigration() {}

    public String getA5BuName() {
        return a5BuName;
    }

    public void setA5BuName(String a5BuName) {
        this.a5BuName = a5BuName;
    }

    public String getA4BuName() {
        return a4BuName;
    }

    public void setA4BuName(String a4BuName) {
        this.a4BuName = a4BuName;
    }

    public String getA4UserEmail() {
        return a4UserEmail;
    }

    public void setA4UserEmail(String a4UserEmail) {
        this.a4UserEmail = a4UserEmail;
    }

    public String getFakeUserEmail() {
        return fakeUserEmail;
    }

    public void setFakeUserEmail(String fakeUserEmail) {
        this.fakeUserEmail = fakeUserEmail;
    }

    public String getFakeUserPassword() {
        return fakeUserPassword;
    }

    public void setFakeUserPassword(String fakeUserPassword) {
        this.fakeUserPassword = fakeUserPassword;
    }


}
