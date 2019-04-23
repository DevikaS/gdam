package com.adstream.automate.babylon.JsonObjects.NewLibrary;

/**
 * Created by Janaki.Kamat on 05/07/2018.
 */
public class StoryBoardDownload {
    private String bundleId;
    private String[] documents;
    private String[] fileIds;
    private String[] errors;

    public String getBundleId(){
        return bundleId;
    }

    public String[] getFileIds() {
        return fileIds;
    }

    public String[] getDocuments() {
        return documents;
    }


    public String[] getErrors() {
        return errors;
    }


}
