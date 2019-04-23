package com.adstream.automate.babylon.tests.steps.domain;

/**
 * Created by sobolev-a on 16.01.2015.
 */
public interface ProjectActivity extends ActivityAction {

    public void sharedFolderToUserActivity(String condition, String sender, String file, String recipient);

    public void sharedProjectToUserActivity(String condition, String sender, String project, String recipient);

    public void uploadFileActivity(String condition, String uploader, String filePath);

    public void createObject(String condition, String author, String objectName);

    public void createFolder(String condition, String author, String folderName);

    public void updateObject(String condition, String author, String objectName);

    public void downloadMasterFile(String condition, String uploader, String filePath);

    public void sharedForApproval(String condition, String sharedUserEmail, String fileName);

    public void sharedFileToUser(String condition, String sharedUserEmail, String fileName, String recipientEmail);

    public void movedFileFromFolderToFolder(String condition, String movedUserEmail, String folderName, String toFolderName, String fileName);

}
