package com.adstream.automate.babylon.tests.steps.domain;

/**
 * Created by sobolev-a on 15.01.2015.
 */
public interface FileActivity extends ActivityAction {

    public void transcodedFileActivity();

    public void sharedFileToUserActivity(String condition, String user, String file, String userFullName);

    public void commentedFileActivity();

    public void uploadedFileActivity();

}
