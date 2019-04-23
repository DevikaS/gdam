package com.adstream.automate.babylon.JsonObjects.mediamanager;

/**
 * Created by Saritha.Dhanala on 19/02/2018.
 */
public class AQAReport {
       private String fileId;

        private String id;

        private Document document;

        private SystemInfo systemInfo;

    public String getFileId ()
    {
        return fileId;
    }

    public void setFileId (String fileId)
    {
        this.fileId = fileId;
    }

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public Document getDocument ()
    {
        return document;
    }

    public void setDocument (Document document)
    {
        this.document = document;
    }

    public SystemInfo getSystemInfo ()
    {
        return systemInfo;
    }

    public void setSystemInfo (SystemInfo systemInfo)
    {
        this.systemInfo = systemInfo;
    }

}
